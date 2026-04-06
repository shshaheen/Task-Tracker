import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_state.dart' as task_state;
import '../models/task.dart';
import '../../team/models/team.dart';
import '../../team/bloc/team_bloc.dart';
import '../../team/bloc/team_state.dart' as team_state;
import '../widgets/kanban_column.dart';
import '../widgets/responsive_board.dart';
import '../widgets/task_form_dialog.dart';
import '../../../services/socket_service.dart';

class TeamBoardScreen extends StatefulWidget {
  final Team? team; // null means 'All Tasks'

  const TeamBoardScreen({super.key, this.team});

  @override
  State<TeamBoardScreen> createState() => _TeamBoardScreenState();
}

class _TeamBoardScreenState extends State<TeamBoardScreen> {
  static const _columns = [
    (label: 'To Do', status: 'todo', color: Color(0xFF757575)),
    (label: 'In Progress', status: 'inprogress', color: Color(0xFFF57C00)),
    (label: 'Done', status: 'done', color: Color(0xFF388E3C)),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.team != null) {
      context.read<SocketService>().joinTeam(widget.team!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = widget.team?.name ?? 'All Tasks';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDark ? "assets/night_sky.jpg" : "assets/day_sky.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<TaskBloc, task_state.TaskState>(
        builder: (context, state) {
          if (state is task_state.TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is task_state.TaskError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red)));
          }

          final tasks = state is task_state.TaskLoaded ? state.tasks : <Task>[];

          List<Task> boardTasks;
          if (widget.team != null) {
            boardTasks =
                tasks.where((t) => t.teamId == widget.team!.id).toList();
          } else {
            boardTasks = tasks;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ResponsiveBoard(
              columns: _columns.map((col) {
                return KanbanColumn(
                  title: col.label,
                  status: col.status,
                  color: col.color,
                  tasks: boardTasks,
                  teamId: widget.team?.id ?? '',
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final teamBlocState = context.read<TeamBloc>().state;
          List<Team> teams = teamBlocState is team_state.TeamLoaded
              ? teamBlocState.teams
              : [];
          String initialTeamId =
              widget.team?.id ?? (teams.isNotEmpty ? teams.first.id : '');
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => TaskFormDialog(
              initialTeamId: initialTeamId,
              teams: teams,
            ),
          );
        },
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          'Add Task',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
