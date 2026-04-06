import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../task/bloc/task_bloc.dart';
import '../../task/bloc/task_event.dart';
import '../../task/bloc/task_state.dart' as task_state;
import '../../task/models/task.dart';
import '../bloc/team_bloc.dart';
import '../bloc/team_event.dart';
import '../bloc/team_state.dart' as team_state;
import '../models/team.dart';
import '../widgets/team_form_dialog.dart';
import '../../task/screens/team_board_screen.dart';

// ---------------------------------------------------------------------------
// TeamsScreen — root screen, renders the list of teams and global stats.
// ---------------------------------------------------------------------------

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TeamBloc>().add(const TeamEvent.fetchTeams());
    context.read<TaskBloc>().add(const TaskEvent.fetchTasks());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        title: Row(
          children: const [
            Icon(Icons.dashboard, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Task Tracker',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TeamBloc, team_state.TeamState>(
        builder: (context, teamState) {
          return BlocBuilder<TaskBloc, task_state.TaskState>(
            builder: (context, taskState) {
              if (teamState is team_state.TeamLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (teamState is team_state.TeamError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Connection Error',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          teamState.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => context
                              .read<TeamBloc>()
                              .add(const TeamEvent.fetchTeams()),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final teams =
                  teamState is team_state.TeamLoaded ? teamState.teams : <Team>[];
              final tasks =
                  taskState is task_state.TaskLoaded ? taskState.tasks : <Task>[];

              return CustomScrollView(
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Your Teams',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0) {
                            return _buildSpecialCard(
                              context,
                              title: 'All Tasks',
                              icon: Icons.all_inbox,
                              count: tasks.length,
                              color: Colors.blueAccent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const TeamBoardScreen(),
                                  ),
                                );
                              },
                            );
                          }

                          if (index == teams.length + 1) {
                            return _buildSpecialCard(
                              context,
                              title: 'Create Team',
                              icon: Icons.add,
                              color: Theme.of(context).colorScheme.primary,
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24)),
                                ),
                                builder: (_) => const TeamFormDialog(),
                              ),
                            );
                          }

                          final team = teams[index - 1];
                          final teamTaskCount =
                              tasks.where((t) => t.teamId == team.id).length;

                          return _buildTeamCard(
                            context,
                            team: team,
                            taskCount: teamTaskCount,
                          );
                        },
                        childCount: teams.length + 2,
                      ),
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context,
      {required Team team, required int taskCount}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeamBoardScreen(team: team),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.group,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                team.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '$taskCount tasks',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    int? count,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (count != null) ...[
                const SizedBox(height: 4),
                Text(
                  '$count tasks',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
