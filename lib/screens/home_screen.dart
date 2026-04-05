import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_state.dart';
import '../models/task_model.dart';
import '../widgets/kanban_column.dart';
import '../widgets/responsive_board.dart';
import '../widgets/task_form_dialog.dart';

// ---------------------------------------------------------------------------
// HomeScreen — root screen, renders the full Kanban board.
// ---------------------------------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _columns = [
    (label: 'To Do', status: 'todo', color: Color(0xFF757575)),
    (label: 'In Progress', status: 'inprogress', color: Color(0xFFF57C00)),
    (label: 'Done', status: 'done', color: Color(0xFF388E3C)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      // Show a SnackBar whenever the BLoC emits an error state.
      listener: (context, state) {
        if (state is TaskError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        appBar: AppBar(
          elevation: 4,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage((DateTime.now().hour >= 6 && DateTime.now().hour < 18) ? "assets/day_sky.jpg" : "assets/night_sky.jpg"),
                fit: BoxFit.cover,
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const TaskFormDialog(),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Add Task',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final tasks = state is TaskLoaded ? state.tasks : <Task>[];

            // Show a global loader ONLY during the very first fetch.
            // If we have tasks already, keep the UI visible even if Loading.
            if (state is TaskLoading && tasks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ResponsiveBoard(
                columns: _columns
                    .map(
                      (col) => KanbanColumn(
                        title: col.label,
                        status: col.status,
                        color: col.color,
                        tasks: tasks, // column filters internally by status
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
