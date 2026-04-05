import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import '../models/team_model.dart';
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
    on<CreateTeam>(_onCreateTeam);
  }

  // ── FetchTasks ─────────────────────────────────────────────────────────────

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    if (state is TaskInitial) {
      emit(const TaskState.loading());
    }

    try {
      final results = await Future.wait([
        _apiService.fetchTeams(),
        _apiService.fetchTasks(),
      ]);

      final teams = results[0] as List<Team>;
      final tasks = results[1] as List<Task>;

      emit(TaskState.loaded(tasks: tasks, teams: teams));
    } on DioException catch (e) {
      emit(TaskState.error(message: _formatDioError(e)));
      if (_currentTasks.isNotEmpty) {
        emit(TaskState.loaded(tasks: _currentTasks, teams: _currentTeams));
      }
    } catch (e) {
      emit(TaskState.error(message: 'Unexpected error: $e'));
    }
  }

  // ── AddTask ────────────────────────────────────────────────────────────────

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;
    final previousTeams = _currentTeams;

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

    emit(TaskState.loaded(tasks: [...previousTasks, tempTask], teams: previousTeams));

    try {
      await _apiService.createTask(
        title: event.title,
        teamId: event.teamId,
        description: event.description,
        priority: event.priority,
        assignedTo: event.assignedTo,
      );
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks, teams: previousTeams));
      emit(TaskState.error(message: 'Failed to add task: $e'));
    }
  }

  // ── UpdateTask ─────────────────────────────────────────────────────────────

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;
    final previousTeams = _currentTeams;

    final updatedTasks = previousTasks.map((t) {
      if (t.id == event.id) {
        return t.copyWith(
          title: event.title ?? t.title,
          description: event.description ?? t.description,
          status: event.status ?? t.status,
          priority: event.priority ?? t.priority,
          teamId: event.teamId ?? t.teamId,
          assignedTo: event.assignedTo ?? t.assignedTo,
        );
      }
      return t;
    }).toList();

    emit(TaskState.loaded(tasks: updatedTasks, teams: previousTeams));

    try {
      await _apiService.updateTask(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        priority: event.priority,
        teamId: event.teamId,
        assignedTo: event.assignedTo,
      );
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks, teams: previousTeams));
      emit(TaskState.error(message: 'Failed to update task: $e'));
    }
  }

  // ── DeleteTask ─────────────────────────────────────────────────────────────

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;
    final previousTeams = _currentTeams;

    final updatedTasks = previousTasks.where((t) => t.id != event.id).toList();
    emit(TaskState.loaded(tasks: updatedTasks, teams: previousTeams));

    try {
      await _apiService.deleteTask(event.id);
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks, teams: previousTeams));
      emit(TaskState.error(message: 'Failed to delete task: $e'));
    }
  }

  // ── Local Sync Handlers ────────────────────────────────────────────────────

  void _handleLocalAdd(Task task, Emitter<TaskState> emit) {
    if (_currentTasks.any((t) => t.id == task.id)) return;

    final filtered = _currentTasks.where((t) => !t.id.startsWith('temp-')).toList();
    emit(TaskState.loaded(tasks: [...filtered, task], teams: _currentTeams));
  }

  void _handleLocalUpdate(Task task, Emitter<TaskState> emit) {
    final updated = _currentTasks
        .map((t) => t.id == task.id ? task : t)
        .toList();
    emit(TaskState.loaded(tasks: updated, teams: _currentTeams));
  }

  void _handleLocalDelete(String id, Emitter<TaskState> emit) {
    final updated = _currentTasks.where((t) => t.id != id).toList();
    emit(TaskState.loaded(tasks: updated, teams: _currentTeams));
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  List<Task> get _currentTasks =>
      state is TaskLoaded ? (state as TaskLoaded).tasks : <Task>[];

  List<Team> get _currentTeams =>
      state is TaskLoaded ? (state as TaskLoaded).teams : <Team>[];

  Future<void> _onCreateTeam(CreateTeam event, Emitter<TaskState> emit) async {
    final previousTasks = _currentTasks;
    final previousTeams = _currentTeams;

    // 1. Optimistic Update
    final tempTeam = Team(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      name: event.name,
      description: event.description,
    );

    emit(TaskState.loaded(tasks: previousTasks, teams: [...previousTeams, tempTeam]));

    try {
      await _apiService.createTeam(
        name: event.name,
        description: event.description,
      );
      // We don't need to manually add the result because most of the time we'll 
      // trigger a fetch or use Socket.IO but for simplicity here we refetch:
      add(const TaskEvent.fetchTasks());
    } catch (e) {
      emit(TaskState.loaded(tasks: previousTasks, teams: previousTeams));
      emit(TaskState.error(message: 'Failed to create team: $e'));
    }
  }

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
