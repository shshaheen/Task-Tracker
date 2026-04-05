import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task_model.dart';
import 'task_card.dart';

// ---------------------------------------------------------------------------
// KanbanColumn
//
// Renders one board column.
//
// Responsibilities:
//   • Filters [tasks] to only those matching [status].
//   • Acts as a DragTarget<Task> — accepts dragged cards from other columns.
//   • Dispatches UpdateTask when a card is dropped here.
//   • Shows an animated hover highlight while a valid card is over it.
// ---------------------------------------------------------------------------

class KanbanColumn extends StatelessWidget {
  /// Display label shown in the column header (e.g. "In Progress").
  final String title;

  /// Backend status value this column represents ("todo" | "inprogress" | "done").
  final String status;

  /// Accent colour used for the header and the drag-hover highlight.
  final Color color;

  /// Filtered tasks for THIS column.
  final List<Task> tasks;

  /// The ID of the team this column belongs to.
  final String teamId;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.status,
    required this.color,
    required this.tasks,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context) {
    // Filter by status.
    final columnTasks = tasks.where((t) => t.status == status).toList();

    return DragTarget<Task>(
      onWillAcceptWithDetails: (details) => details.data.status != status,
      onAcceptWithDetails: (details) {
        context.read<TaskBloc>().add(
              TaskEvent.updateTask(
                id: details.data.id,
                status: status,
                teamId: teamId, // Ensure it stays in this team or updates if moving across
              ),
            );
      },

      builder: (context, candidateData, _) {
        final isHovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: isHovering
                ? color.withValues(alpha: 0.15)
                : Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovering 
                  ? color 
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.03),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ColumnHeader(
                title: title,
                color: color,
                count: columnTasks.length,
              ),
              _TaskList(tasks: columnTasks),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// _ColumnHeader — coloured pill showing the column title and task count.
// ---------------------------------------------------------------------------

class _ColumnHeader extends StatelessWidget {
  final String title;
  final Color color;
  final int count;

  const _ColumnHeader({
    required this.title,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          // Task-count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _TaskList — scrollable list of TaskCards, or an empty-state hint.
// ---------------------------------------------------------------------------

class _TaskList extends StatelessWidget {
  final List<Task> tasks;

  const _TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Drop tasks here',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: tasks.length,
        itemBuilder: (_, i) => TaskCard(task: tasks[i]),
      ),
    );
  }
}
