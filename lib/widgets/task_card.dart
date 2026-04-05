import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task_model.dart';
import 'board_scroll_provider.dart';
import 'task_form_dialog.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.bold),
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: isDragging ? 220 : double.infinity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDragging) // hide when ghost is dragged
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            if (isDragging) // slightly stronger shadow for the ghost
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 0, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 6, top: 2),
                child: Icon(
                  Icons.drag_indicator,
                  size: 18,
                  color: Colors.black26,
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
                            color: Colors.grey.shade600,

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
                  icon: Icon(
                    Icons.more_horiz,
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                    size: 18,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      showDialog(
                        context: context,
                        builder: (_) => TaskFormDialog(taskToEdit: task),
                      );
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
