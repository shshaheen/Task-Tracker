import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../services/task_api_service.dart';
import 'task_event.dart';
import 'task_state.dart';

// ---------------------------------------------------------------------------
// TaskBloc
//
// Bridges UI events → API calls → new UI states.
//
// Strategy after every mutating operation (add / update / delete):
//   Re-fetch the full task list so the board always reflects server truth.
//   This keeps local state minimal and avoids manual list-splicing bugs.
// ---------------------------------------------------------------------------

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

  // ── FetchTasks ─────────────────────────────────────────────────────────────

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    // ONLY show global loading on the very first load.
    if (state is TaskInitial) {
      emit(const TaskState.loading());
    }

    try {
      final tasks = await _apiService.fetchTasks();
      emit(TaskState.loaded(tasks: tasks));
    } on DioException catch (e) {
      emit(TaskState.error(message: _formatDioError(e)));
      // If we already had tasks, stay in Loaded state with those tasks
      // so the board doesn't disappear.
      if (_currentTasks.isNotEmpty) {
        emit(TaskState.loaded(tasks: _currentTasks));
      }
    } catch (e) {
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  // ── AddTask ────────────────────────────────────────────────────────────────

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;

    // 1. Optimistic Update: Add a temporary task to the UI.
    final tempTask = Task(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      title: event.title,
      description: event.description ?? '',
      status: 'todo',
      priority: event.priority ?? 'medium',
    );

    emit(TaskState.loaded(tasks: [...previousTasks, tempTask]));

    try {
      // 2. Perform API call.
      await _apiService.createTask(
        title: event.title,
        description: event.description,
        priority: event.priority,
      );
      // 3. Instead of refetching everything, we wait for the Socket event
      // or we could refetch silently. The requirement says "Socket updates should
      // update the existing state without triggering a full reload."
      // So we'll let Socket handle the official insertion.
    } catch (e) {
      // 4. Revert on error.
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to add task: $e'));
    }
  }

  // ── UpdateTask ─────────────────────────────────────────────────────────────

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;

    // 1. Optimistic Update: Update the task in the list immediately.
    final updatedTasks = previousTasks.map((t) {
      if (t.id == event.id) {
        return t.copyWith(
          title: event.title ?? t.title,
          description: event.description ?? t.description,
          status: event.status ?? t.status,
          priority: event.priority ?? t.priority,
        );
      }
      return t;
    }).toList();

    emit(TaskState.loaded(tasks: updatedTasks));

    try {
      await _apiService.updateTask(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        priority: event.priority,
      );
    } catch (e) {
      // Revert on error.
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to update task: $e'));
    }
  }

  // ── DeleteTask ─────────────────────────────────────────────────────────────

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;

    // 1. Optimistic Update: Remove from list immediately.
    final updatedTasks = previousTasks.where((t) => t.id != event.id).toList();
    emit(TaskState.loaded(tasks: updatedTasks));

    try {
      await _apiService.deleteTask(event.id);
    } catch (e) {
      // Revert on error.
      emit(TaskState.loaded(tasks: previousTasks));
      emit(TaskState.error(message: 'Failed to delete task: $e'));
    }
  }

  // ── Local Sync Handlers ────────────────────────────────────────────────────

  void _handleLocalAdd(Task task, Emitter<TaskState> emit) {
    final tasks = _currentTasks;
    // Don't add if already exists (avoids duplicates with optimistic UI)
    if (tasks.any((t) => t.id == task.id)) return;

    // Remove any temp tasks that match this one (if we had a way to correlate,
    // usually by title/description for new tasks)
    final filtered = tasks.where((t) => !t.id.startsWith('temp-')).toList();
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

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Returns the task list from the current [TaskLoaded] state,
  /// or an empty list if the state is not [TaskLoaded].
  List<Task> get _currentTasks =>
      state is TaskLoaded ? (state as TaskLoaded).tasks : <Task>[];

  /// Converts a [DioException] into a human-readable string for the UI.
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
