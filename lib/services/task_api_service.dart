import 'package:dio/dio.dart';
import '../models/task_model.dart';

// ---------------------------------------------------------------------------
// TaskApiService
//
// Wraps every REST endpoint exposed by the backend.
// All methods throw [DioException] on network / HTTP errors — callers
// (the BLoC) are responsible for catching and surfacing them to the UI.
// ---------------------------------------------------------------------------

class TaskApiService {
  static const String _baseUrl = 'https://task-tracker-1-pu1i.onrender.com/api';

  // Single shared Dio instance with base config applied once.
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

  // ── GET /tasks ─────────────────────────────────────────────────────────────
  /// Fetches all tasks from the backend, sorted newest-first (server handles order).
  /// Returns an empty list if [data] is null or empty.
  Future<List<Task>> fetchTasks() async {
    final response = await _dio.get('/tasks');

    final data = response.data['data'] as List<dynamic>? ?? [];

    return data
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── POST /tasks ────────────────────────────────────────────────────────────
  /// Creates a new task with the given [title], [description], and [priority].
  /// The backend assigns status "todo" by default.
  Future<Task> createTask({
    required String title,
    String? description,
    String? priority,
  }) async {
    final response = await _dio.post('/tasks', data: {
      'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
    });

    return Task.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  // ── PATCH /tasks/:id ───────────────────────────────────────────────────────
  /// Updates allowed fields of the task identified by [id].
  Future<Task> updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    String? priority,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (status != null) data['status'] = status;
    if (priority != null) data['priority'] = priority;

    final response = await _dio.patch('/tasks/$id', data: data);

    return Task.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  // ── DELETE /tasks/:id ──────────────────────────────────────────────────────
  /// Deletes the task identified by [id].
  Future<void> deleteTask(String id) async {
    await _dio.delete('/tasks/$id');
  }
}
