import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';
import 'screens/home_screen.dart';
import 'services/socket_service.dart';

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

void main() {
  runApp(const TaskTrackerApp());
}

// ---------------------------------------------------------------------------
// TaskTrackerApp — StatefulWidget so we can own the BLoC + Socket lifecycle.
//
// Flow:
//   1. initState creates TaskBloc and immediately dispatches FetchTasks.
//   2. SocketService connects; every server event triggers another FetchTasks.
//   3. BlocProvider.value shares the bloc instance down the widget tree.
//   4. dispose() closes both the socket and the bloc cleanly on app exit.
// ---------------------------------------------------------------------------

class TaskTrackerApp extends StatefulWidget {
  const TaskTrackerApp({super.key});

  @override
  State<TaskTrackerApp> createState() => _TaskTrackerAppState();
}

class _TaskTrackerAppState extends State<TaskTrackerApp> {
  late final TaskBloc _taskBloc;
  late final SocketService _socketService;

  @override
  void initState() {
    super.initState();

    // Create the bloc and kick off the initial data load.
    _taskBloc = TaskBloc()..add(const TaskEvent.fetchTasks());

    // Connect the socket; it will re-dispatch FetchTasks on every server event.
    _socketService = SocketService(taskBloc: _taskBloc)..connect();
  }

  @override
  void dispose() {
    _socketService.dispose();
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _taskBloc,
      child: MaterialApp(
        title: 'Task Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
