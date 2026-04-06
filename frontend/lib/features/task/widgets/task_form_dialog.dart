import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task.dart';
import '../../team/models/team.dart';

class TaskFormDialog extends StatefulWidget {
  final Task? taskToEdit;
  final List<Team> teams;
  final String? initialTeamId;

  const TaskFormDialog({
    super.key,
    this.taskToEdit,
    this.teams = const [],
    this.initialTeamId,
  });

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late String _priority;
  late String? _selectedTeamId;
  String? _titleError;
  String? _teamError;

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
    _selectedTeamId = widget.taskToEdit?.teamId ?? widget.initialTeamId;

    // Fallback to first team if none provided
    if (_selectedTeamId == null && widget.teams.isNotEmpty) {
      _selectedTeamId = widget.teams.first.id;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();

    setState(() {
      _titleError = title.isEmpty ? 'Title cannot be empty' : null;
      _teamError = _selectedTeamId == null ? 'Please select a team' : null;
    });

    if (title.isEmpty || _selectedTeamId == null) {
      return;
    }

    final desc = _descController.text.trim();
    final bloc = context.read<TaskBloc>();

    if (widget.taskToEdit == null) {
      bloc.add(
        TaskEvent.addTask(
          title: title,
          teamId: _selectedTeamId!,
          description: desc.isEmpty ? null : desc,
          priority: _priority,
        ),
      );
    } else {
      bloc.add(
        TaskEvent.updateTask(
          id: widget.taskToEdit!.id,
          title: title,
          teamId: _selectedTeamId,
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

  InputDecoration _buildInputDecoration(String hint, BuildContext context,
      {String? errorText}) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      errorText: errorText,
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: bottomInset > 0 ? bottomInset + 24 : 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Header
            Row(
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
                    fontSize: 24,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Form contents in ScrollView so it doesn't overflow easily
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLabeledField(
                      'Team *',
                      DropdownButtonFormField<String>(
                        value: _selectedTeamId,
                        decoration: _buildInputDecoration(
                          'Select Team',
                          context,
                          errorText: _teamError,
                        ),
                        icon: Icon(
                          Icons.groups_outlined,
                          size: 18,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        dropdownColor: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        items: widget.teams
                            .map((team) => DropdownMenuItem(
                                  value: team.id,
                                  child: Text(
                                    team.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedTeamId = val;
                              _teamError = null;
                            });
                          }
                        },
                      ),
                      context,
                    ),
                    const SizedBox(height: 18),
                    _buildLabeledField(
                      'Title *',
                      TextField(
                        controller: _titleController,
                        autofocus: !isEdit,
                        onChanged: (val) {
                          if (_titleError != null)
                            setState(() => _titleError = null);
                        },
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                        decoration: _buildInputDecoration(
                          'Enter task title...',
                          context,
                          errorText: _titleError,
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
                        decoration:
                            _buildInputDecoration('Add details...', context),
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
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Submitter Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: colorScheme.onSurfaceVariant,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: Icon(isEdit ? Icons.save : Icons.add),
                    label: Text(
                      isEdit ? 'Save Changes' : 'Add Task',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
