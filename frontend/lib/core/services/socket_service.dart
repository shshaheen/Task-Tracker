import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../features/task/models/task.dart';
import '../../features/task/bloc/task_bloc.dart';
import '../../features/task/bloc/task_event.dart';
import '../config/api_config.dart';

// ---------------------------------------------------------------------------
// SocketService
//
// Maintains a persistent Socket.io connection to the backend.
//
// On every real-time event emitted by the server (taskCreated, taskUpdated,
// taskDeleted) it dispatches local sync events to the TaskBloc so the board
// refreshes automatically on ALL connected clients.
//
// Lifecycle:
//   1. Instantiate with a TaskBloc reference.
//   2. Call connect() once (e.g. inside initState / main).
//   3. Call dispose() when the app is torn down to close the socket cleanly.
// ---------------------------------------------------------------------------

class SocketService {
  static const String _serverUrl = ApiConfig.serverUrl;

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
      debugPrint('[SocketService] taskDeleted received: $data');
      final String? id = data is String
          ? data
          : (data['id'] as String? ?? data['_id'] as String?);
      if (id != null) {
        taskBloc.add(TaskEvent.taskDeletedLocally(id: id));
      }
    });

    _socket.connect();
  }

  /// Join a specific team room to receive targeted real-time updates.
  void joinTeam(String teamId) {
    if (_socket.connected) {
      _socket.emit('joinTeam', teamId);
      debugPrint('[SocketService] Joining room: team_$teamId');
    }
  }

  /// Closes the socket and frees resources.
  void dispose() {
    _socket.dispose();
    debugPrint('[SocketService] Disposed');
  }
}
