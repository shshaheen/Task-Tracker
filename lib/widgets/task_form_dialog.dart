import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task_model.dart';

// ---------------------------------------------------------------------------
// TaskFormDialog
//
// A modernized, clean dialog for creating and editing tasks mirroring
// aesthetics from tools like Notion or Linear. Fixed overlapping labels.
// ---------------------------------------------------------------------------

class TaskFormDialog extends StatefulWidget {
  final Task? taskToEdit;

  const TaskFormDialog({super.key, this.taskToEdit});

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late String _priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.taskToEdit?.title ?? '',
    );
    _descController = TextEditingController(
      text: widget.taskToEdit?.description ?? '',
    );
    _priority = widget.taskToEdit?.priority ?? 'medium';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title cannot be empty')));
      return;
    }

    final desc = _descController.text.trim();
    final bloc = context.read<TaskBloc>();

    if (widget.taskToEdit == null) {
      bloc.add(
        TaskEvent.addTask(
          title: title,
          description: desc.isEmpty ? null : desc,
          priority: _priority,
        ),
      );
    } else {
      bloc.add(
        TaskEvent.updateTask(
          id: widget.taskToEdit!.id,
          title: title,
          description: desc.isEmpty ? null : desc,
          priority: _priority,
          status: widget.taskToEdit!.status,
        ),
      );
    }

    Navigator.of(context).pop();
  }

  Widget _buildLabeledField(
    String label,
    Widget fieldWidget,
    BuildContext context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        fieldWidget,
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hint, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.45),
        fontSize: 14,
      ),
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.taskToEdit != null;
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      surfaceTintColor: colorScheme.surface,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isEdit ? Icons.edit_note_rounded : Icons.edit_document,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            isEdit ? 'Edit Task' : 'New Task',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      content: SizedBox(
        width: 400, // Cap maximum width for big screens
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabeledField(
                'Title *',
                TextField(
                  controller: _titleController,
                  autofocus: !isEdit,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                  decoration: _buildInputDecoration(
                    'Enter task title...',
                    context,
                  ),
                ),
                context,
              ),
              const SizedBox(height: 18),
              _buildLabeledField(
                'Description',
                TextField(
                  controller: _descController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                  decoration: _buildInputDecoration('Add details...', context),
                ),
                context,
              ),
              const SizedBox(height: 18),
              _buildLabeledField(
                'Priority',
                DropdownButtonFormField<String>(
                  value: _priority,
                  decoration: _buildInputDecoration('', context),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  dropdownColor: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  items: [
                    DropdownMenuItem(
                      value: 'low',
                      child: Text(
                        'Low',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text(
                        'Medium',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'high',
                      child: Text(
                        'High',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _priority = val);
                    }
                  },
                ),
                context,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            foregroundColor: colorScheme.onSurfaceVariant,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
          child: Text(
            isEdit ? 'Save Changes' : 'Add Task',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
