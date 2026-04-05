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
  }

  // ── FetchTasks ─────────────────────────────────────────────────────────────

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(const TaskState.loading());
    try {
      final tasks = await _apiService.fetchTasks();
      emit(TaskState.loaded(tasks: tasks));
    } on DioException catch (e) {
      emit(TaskState.error(message: _formatDioError(e)));
    } catch (e) {
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  // ── AddTask ────────────────────────────────────────────────────────────────

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    // Keep the existing board visible while the request is in flight.
    final currentTasks = _currentTasks;

    try {
      await _apiService.createTask(
        title: event.title,
        description: event.description,
        priority: event.priority,
      );
      // Re-fetch so the new task gets its server-assigned _id and timestamps.
      add(const TaskEvent.fetchTasks());
    } on DioException catch (e) {
      // Restore the previous list so the board doesn't disappear on error.
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: _formatDioError(e)));
    } catch (e) {
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  // ── UpdateTask ─────────────────────────────────────────────────────────────

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final currentTasks = _currentTasks;

    try {
      await _apiService.updateTask(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        priority: event.priority,
      );
      add(const TaskEvent.fetchTasks());
    } on DioException catch (e) {
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: _formatDioError(e)));
    } catch (e) {
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  // ── DeleteTask ─────────────────────────────────────────────────────────────

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final currentTasks = _currentTasks;

    try {
      await _apiService.deleteTask(event.id);
      add(const TaskEvent.fetchTasks());
    } on DioException catch (e) {
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: _formatDioError(e)));
    } catch (e) {
      emit(TaskState.loaded(tasks: currentTasks));
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
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
