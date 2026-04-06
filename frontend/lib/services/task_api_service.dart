import 'package:dio/dio.dart';
import 'package:task_tracker/features/task/models/task.dart';
import 'package:task_tracker/features/team/models/team.dart';

class TaskApiService {
  static const String _baseUrl = 'https://task-tracker-1-pu1i.onrender.com/api';

  final Dio _dio;

  TaskApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  // ── Teams ──────────────────────────────────────────────────────────────────

  Future<List<Team>> fetchTeams() async {
    final response = await _dio.get('/teams');
    final data = response.data['data'] as List<dynamic>? ?? [];
    return data
        .map((json) => Team.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Team> createTeam({required String name, String? description}) async {
    final response = await _dio.post(
      '/teams',
      data: {
        'name': name,
        if (description != null) 'description': description,
      },
    );
    return Team.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  // ── GET /tasks ─────────────────────────────────────────────────────────────

  Future<List<Task>> fetchTasks({String? teamId}) async {
    final response = await _dio.get(
      '/tasks',
      queryParameters: teamId != null ? {'teamId': teamId} : null,
    );

    final data = response.data['data'] as List<dynamic>? ?? [];

    return data
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── POST /tasks ────────────────────────────────────────────────────────────

  Future<Task> createTask({
    required String title,
    required String teamId,
    String? description,
    String? priority,
    String? assignedTo,
    String? createdBy,
  }) async {
    final response = await _dio.post(
      '/tasks',
      data: {
        'title': title,
        'teamId': teamId,
        if (description != null) 'description': description,
        if (priority != null) 'priority': priority,
        if (assignedTo != null) 'assignedTo': assignedTo,
        if (createdBy != null) 'createdBy': createdBy,
      },
    );

    return Task.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  // ── PATCH /tasks/:id ───────────────────────────────────────────────────────

  Future<Task> updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? teamId,
    String? assignedTo,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (status != null) data['status'] = status;
    if (priority != null) data['priority'] = priority;
    if (teamId != null) data['teamId'] = teamId;
    if (assignedTo != null) data['assignedTo'] = assignedTo;

    final response = await _dio.patch('/tasks/$id', data: data);

    return Task.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  // ── DELETE /tasks/:id ──────────────────────────────────────────────────────

  Future<void> deleteTask(String id) async {
    await _dio.delete('/tasks/$id');
  }

  // ── DELETE /teams/:id ──────────────────────────────────────────────────────

  Future<void> deleteTeam(String id) async {
    await _dio.delete('/teams/$id');
  }
}
