import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task.dart';
import '../../team/models/team.dart';
import '../../team/bloc/team_bloc.dart';
import '../../team/bloc/team_state.dart' as team_state;
import 'board_scroll_provider.dart';
import 'task_form_dialog.dart';
import 'task_view_dialog.dart';

// ---------------------------------------------------------------------------
// TaskCard
//
// Displays a single task's title and a delete button.
// Wrapped in a LongPressDraggable so it can be dragged between columns.
// ---------------------------------------------------------------------------

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: task,
      // Ghost shown under the finger while dragging
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: Transform.scale(
          scale: 1.05,
          child: _CardBody(task: task, isDragging: true),
        ),
      ),
      // Dim the original card while it is being dragged
      childWhenDragging: Opacity(opacity: 0.35, child: _CardBody(task: task)),
      onDragUpdate: (details) {
        final scrollProvider = BoardScrollProvider.of(context);
        if (scrollProvider == null) return;

        final screenWidth = MediaQuery.of(context).size.width;
        final dx = details.globalPosition.dx;

        const edgeSize = 80.0;
        const speed = 7.0; // 7 pixels per 16ms (~430px per second)

        if (dx < edgeSize) {
          scrollProvider.startAutoScroll(-speed);
        } else if (dx > screenWidth - edgeSize) {
          scrollProvider.startAutoScroll(speed);
        } else {
          scrollProvider.stopAutoScroll();
        }
      },
      onDragEnd: (_) {
        BoardScrollProvider.of(context)?.stopAutoScroll();
      },
      onDraggableCanceled: (_, __) {
        BoardScrollProvider.of(context)?.stopAutoScroll();
      },
      child: _CardBody(task: task),
    );
  }
}

// ---------------------------------------------------------------------------
// _CardBody — the visual Card, separated so Draggable can reuse it.
// ---------------------------------------------------------------------------

class _CardBody extends StatelessWidget {
  final Task task;
  final bool isDragging;

  const _CardBody({required this.task, this.isDragging = false});

  Widget _buildPriorityBadge(String priority) {
    Color c;
    if (priority == 'high') {
      c = Colors.red;
    } else if (priority == 'low') {
      c = Colors.green;
    } else {
      c = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.2), width: 0.5),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          color: c.withValues(alpha: 0.8),
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 4,
        shadowColor: Colors.black26,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Row(
          children: [
            Icon(Icons.delete_outline_rounded, color: Colors.red.shade600),
            const SizedBox(width: 8),
            const Text(
              'Delete Task',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: const Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(fontSize: 15),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              foregroundColor: Colors.grey.shade700,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(TaskEvent.deleteTask(id: task.id));
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required String label,
    required IconData icon,
    Color? color,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuItem<String>(
      value: value,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color ?? colorScheme.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color ?? colorScheme.primary.withValues(alpha: 0.9),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: isDragging ? 220 : double.infinity,
      child: GestureDetector(
        onTap: isDragging
            ? null
            : () => showDialog(
                  context: context,
                  builder: (_) => TaskViewDialog(task: task),
                ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              if (!isDragging)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              if (isDragging)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6, top: 2),
                  child: Icon(
                    Icons.drag_indicator,
                    size: 18,
                    color: colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                              height: 1.2,
                            ),
                      ),
                      if (task.description != null &&
                          task.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            task.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      _buildPriorityBadge(task.priority),
                    ],
                  ),
                ),
                if (!isDragging)
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    splashRadius: 18,
                    offset: const Offset(0, 32),
                    elevation: 3,
                    color: colorScheme.surface,
                    constraints: const BoxConstraints(minWidth: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: colorScheme.onSurface.withValues(alpha: 0.05),
                        width: 1,
                      ),
                    ),
                    icon: Icon(
                      Icons.more_horiz,
                      color: colorScheme.onSurface.withValues(alpha: 0.3),
                      size: 18,
                    ),
                    onSelected: (value) {
                      if (value == 'view') {
                        showDialog(
                          context: context,
                          builder: (_) => TaskViewDialog(task: task),
                        );
                      } else if (value == 'edit') {
                        final teamState = context.read<TeamBloc>().state;
                        final teams = teamState is team_state.TeamLoaded
                            ? teamState.teams
                            : <Team>[];
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24)),
                          ),
                          builder: (_) => TaskFormDialog(
                            taskToEdit: task,
                            teams: teams,
                          ),
                        );
                      } else if (value == 'delete') {
                        _showDeleteConfirmation(context);
                      }
                    },
                    itemBuilder: (context) => [
                      _buildPopupMenuItem(
                        value: 'view',
                        label: 'View',
                        icon: Icons.visibility_outlined,
                        context: context,
                      ),
                      _buildPopupMenuItem(
                        value: 'edit',
                        label: 'Edit',
                        icon: Icons.edit_outlined,
                        context: context,
                      ),
                      const PopupMenuDivider(height: 1),
                      _buildPopupMenuItem(
                        value: 'delete',
                        label: 'Delete',
                        icon: Icons.delete_outline_rounded,
                        color: Colors.red.shade600,
                        context: context,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
