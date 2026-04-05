import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../services/task_api_service.dart';

class TeamFormDialog extends StatefulWidget {
  const TeamFormDialog({super.key});

  @override
  State<TeamFormDialog> createState() => _TeamFormDialogState();
}

class _TeamFormDialogState extends State<TeamFormDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String? _nameError;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _nameError = 'Team name is required';
      });
      return;
    }

    setState(() {
      _nameError = null;
      _isLoading = true;
    });

    try {
      final apiService = TaskApiService();
      await apiService.createTeam(
        name: name,
        description: _descController.text.trim(),
      );

      if (!mounted) return;
      context.read<TaskBloc>().add(const TaskEvent.fetchTasks());
      Navigator.of(context).pop();
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() { _isLoading = false; });
      
      final String errorMessage = e.response?.data?['message']?.toString() ?? '';
      
      if (e.response?.statusCode == 400 && 
         (errorMessage == 'Team with this name already exists' || 
          errorMessage.contains('E11000 duplicate key'))) {
        setState(() {
          _nameError = 'Team name already exists. Please choose another name.';
        });
      } else {
        final fallbackMsg = errorMessage.isNotEmpty ? errorMessage : (e.message ?? 'Failed to create team');
        // Fallback for other errors: Since it could be a generic error, we can still show it in _nameError 
        // or just let the user know. Showing it in the field error is visible and clean.
        setState(() {
          _nameError = fallbackMsg;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() { _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine bottom padding for keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Text(
            'Create Team',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Organize tasks by teams',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 32),
          
          // Form Fields
          TextField(
            controller: _nameController,
            onChanged: (val) {
              if (_nameError != null) setState(() => _nameError = null);
            },
            decoration: InputDecoration(
              labelText: 'Team Name *',
              hintText: 'Frontend, Backend, DevOps',
              errorText: _nameError,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Optional description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _submit,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add),
              label: Text(
                _isLoading ? 'Creating...' : 'Create Team',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

