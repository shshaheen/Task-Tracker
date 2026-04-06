import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/task_api_service.dart';
import '../models/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskApiService _apiService;

  TaskBloc({TaskApiService? apiService})
      : _apiService = apiService ?? TaskApiService(),
        super(const TaskState.initial()) {
    on<FetchTasks>(_onFetchTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);

    // Sync handlers
    on<TaskAddedLocally>((event, emit) => _handleLocalAdd(event.task, emit));
    on<TaskUpdatedLocally>(
      (event, emit) => _handleLocalUpdate(event.task, emit),
    );
    on<TaskDeletedLocally>((event, emit) => _handleLocalDelete(event.id, emit));
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    if (state is TaskInitial) {
      emit(const TaskState.loading());
    }

    try {
      final tasks = await _apiService.fetchTasks(teamId: event.teamId);
      emit(TaskState.loaded(tasks: tasks));
    } on DioException catch (e) {
      emit(TaskState.error(message: _formatDioError(e)));
      if (_currentTasks.isNotEmpty) {
        emit(TaskState.loaded(tasks: _currentTasks));
      }
    } catch (e) {
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;

    // 1. Optimistic Update
    final tempTask = Task(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      title: event.title,
      description: event.description ?? '',
      status: 'todo',
      priority: event.priority ?? 'medium',
      teamId: event.teamId,
      assignedTo: event.assignedTo,
    );

    emit(TaskState.loaded(tasks: [...previousTasks, tempTask]));

    try {
      await _apiService.createTask(
        title: event.title,
        teamId: event.teamId,
        description: event.description,
        priority: event.priority,
        assignedTo: event.assignedTo,
      );
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to add task: $e'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;

    try {
      final serverTask = await _apiService.updateTask(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        priority: event.priority,
        teamId: event.teamId,
        assignedTo: event.assignedTo,
      );

      final updatedTasks = previousTasks.map((t) {
        return (t.id == serverTask.id) ? serverTask : t;
      }).toList();

      emit(TaskState.loaded(tasks: updatedTasks));
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to update task: $e'));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;
    final updatedTasks = previousTasks.where((t) => t.id != event.id).toList();

    emit(TaskState.loaded(tasks: updatedTasks));

    try {
      await _apiService.deleteTask(event.id);
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to delete task: $e'));
    }
  }

  void _handleLocalAdd(Task task, Emitter<TaskState> emit) {
    if (_currentTasks.any((t) => t.id == task.id)) return;

    final filtered = _currentTasks.where((t) => !t.id.startsWith('temp-')).toList();
    emit(TaskState.loaded(tasks: [...filtered, task]));
  }

  void _handleLocalUpdate(Task task, Emitter<TaskState> emit) {
    final updated = _currentTasks
        .map((t) => t.id == task.id ? task : t)
        .toList();
    emit(TaskState.loaded(tasks: updated));
  }

  void _handleLocalDelete(String id, Emitter<TaskState> emit) {
    final updated = _currentTasks.where((t) => t.id != id).toList();
    emit(TaskState.loaded(tasks: updated));
  }

  List<Task> get _currentTasks =>
      state is TaskLoaded ? (state as TaskLoaded).tasks : <Task>[];

  String _formatDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Is the server running?';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Cannot reach the server. Check your network.';
    }
    final status = e.response?.statusCode;
    final serverMsg = e.response?.data?['message'] as String?;
    if (serverMsg != null) return serverMsg;
    return status != null ? 'Server error ($status)' : 'Network error';
  }
}
