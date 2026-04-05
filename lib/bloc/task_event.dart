import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/task_model.dart';

part 'task_event.freezed.dart';

// ---------------------------------------------------------------------------
// TaskEvent — sealed union of every action the BLoC can handle.
//
// Freezed generates:
//   • == / hashCode
//   • toString()
//   • pattern-matching helpers (map / maybeMap / when / maybeWhen)
// ---------------------------------------------------------------------------

@freezed
sealed class TaskEvent with _$TaskEvent {
  /// Load all tasks from the backend.
  const factory TaskEvent.fetchTasks() = FetchTasks;

  /// Create a new task.
  const factory TaskEvent.addTask({
    required String title,
    required String teamId,
    String? description,
    String? priority,
    String? assignedTo,
  }) = AddTask;

  /// Update task fields optionally.
  const factory TaskEvent.updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? teamId,
    String? assignedTo,
  }) = UpdateTask;

  /// Permanently remove the task identified by [id].
  const factory TaskEvent.deleteTask({required String id}) = DeleteTask;

  /// Create a new team.
  const factory TaskEvent.createTeam({
    required String name,
    String? description,
  }) = CreateTeam;

  /// Optimistic / Real-time sync events
  const factory TaskEvent.taskAddedLocally({required Task task}) =
      TaskAddedLocally;
  const factory TaskEvent.taskUpdatedLocally({required Task task}) =
      TaskUpdatedLocally;
  const factory TaskEvent.taskDeletedLocally({required String id}) =
      TaskDeletedLocally;
}
