import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/task/bloc/task_bloc.dart';
import 'features/task/bloc/task_event.dart';
import 'features/team/bloc/team_bloc.dart';
import 'features/team/bloc/team_event.dart';
import 'features/team/screens/teams_screen.dart';
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
//   1. initState creates Blocs and immediately dispatches Fetch events.
//   2. SocketService connects; every server event triggers local sync.
//   3. MultiBlocProvider shares the bloc instances down the widget tree.
//   4. dispose() closes both the socket and the blocs cleanly on app exit.
// ---------------------------------------------------------------------------

class TaskTrackerApp extends StatefulWidget {
  const TaskTrackerApp({super.key});

  @override
  State<TaskTrackerApp> createState() => _TaskTrackerAppState();
}

class _TaskTrackerAppState extends State<TaskTrackerApp> {
  late final TaskBloc _taskBloc;
  late final TeamBloc _teamBloc;
  late final SocketService _socketService;

  @override
  void initState() {
    super.initState();

    // Create the blocs and kick off the initial data load.
    _taskBloc = TaskBloc()..add(const TaskEvent.fetchTasks());
    _teamBloc = TeamBloc()..add(const TeamEvent.fetchTeams());

    // Connect the socket; it will re-dispatch FetchTasks on every server event.
    _socketService = SocketService(taskBloc: _taskBloc)..connect();
  }

  @override
  void dispose() {
    _socketService.dispose();
    _taskBloc.close();
    _teamBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _taskBloc),
        BlocProvider.value(value: _teamBloc),
      ],
      child: RepositoryProvider.value(
        value: _socketService,
        child: MaterialApp(
          title: 'Task Tracker',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system, // Dynamically follow device setting
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2563EB),
              brightness: Brightness.light,
              surface: const Color(0xFFFFFFFF),
              surfaceContainer:
                  const Color(0xFFF1F5F9), // Light blue-grey for columns
              onSurface: const Color(0xFF1E293B),
            ),
            scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Very light grey
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3B82F6),
              brightness: Brightness.dark,
              surface: const Color(0xFF1E293B), // Card color
              surfaceContainer: const Color(0xFF0F172A), // Column background
              onSurface: const Color(0xFFF8FAFC),
            ),
            scaffoldBackgroundColor: const Color(0xFF020617), // Deepest dark
          ),
          home: const TeamsScreen(),
        ),
      ),
    );
  }
}
