import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/task_model.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

// ---------------------------------------------------------------------------
// SocketService
//
// Maintains a persistent Socket.io connection to the backend.
//
// On every real-time event emitted by the server (taskCreated, taskUpdated,
// taskDeleted) it dispatches FetchTasks to the TaskBloc so the board
// refreshes automatically on ALL connected clients.
//
// Lifecycle:
//   1. Instantiate with a TaskBloc reference.
//   2. Call connect() once (e.g. inside initState / main).
//   3. Call dispose() when the app is torn down to close the socket cleanly.
// ---------------------------------------------------------------------------

class SocketService {
  static const String _serverUrl = 'https://task-tracker-1-pu1i.onrender.com';

  final TaskBloc taskBloc;
  late final io.Socket _socket;

  SocketService({required this.taskBloc});

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Opens the socket connection and registers all event listeners.
  void connect() {
    _socket = io.io(
      _serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket']) // skip polling, go straight to WS
          .disableAutoConnect() // we connect explicitly below
          .build(),
    );

    // ── Lifecycle events ───────────────────────────────────────────────────
    _socket.onConnect((_) {
      debugPrint('[SocketService] Connected — id: ${_socket.id}');
    });

    _socket.onDisconnect((_) {
      debugPrint('[SocketService] Disconnected');
    });

    _socket.onConnectError((err) {
      debugPrint('[SocketService] Connection error: $err');
    });

    // ── Domain events — each triggers a local sync ────────────────────────
    //
    // Instead of refetching the full list, we parse the incoming task
    // and update the existing BLoC state directly for zero flickering.

    _socket.on('taskCreated', (data) {
      debugPrint('[SocketService] taskCreated received');
      if (data is Map<String, dynamic>) {
        taskBloc.add(TaskEvent.taskAddedLocally(task: Task.fromJson(data)));
      }
    });

    _socket.on('taskUpdated', (data) {
      debugPrint('[SocketService] taskUpdated received');
      if (data is Map<String, dynamic>) {
        taskBloc.add(TaskEvent.taskUpdatedLocally(task: Task.fromJson(data)));
      }
    });

    _socket.on('taskDeleted', (data) {
      debugPrint('[SocketService] taskDeleted received');
      // For deletion, data might be the _id string or a map with _id.
      final String? id = data is String ? data : data['_id'] as String?;
      if (id != null) {
        taskBloc.add(TaskEvent.taskDeletedLocally(id: id));
      }
    });

    _socket.connect();
  }

  /// Closes the socket and frees resources.
  void dispose() {
    _socket.dispose();
    debugPrint('[SocketService] Disposed');
  }
}
