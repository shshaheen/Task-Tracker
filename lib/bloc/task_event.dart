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

  /// Create a new task with the given [title].
  const factory TaskEvent.addTask({
    required String title,
    String? description,
    String? priority,
  }) = AddTask;

  /// Update task fields optionally.
  const factory TaskEvent.updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    String? priority,
  }) = UpdateTask;

  /// Permanently remove the task identified by [id].
  const factory TaskEvent.deleteTask({required String id}) = DeleteTask;

  /// Optimistic / Real-time sync events
  const factory TaskEvent.taskAddedLocally({required Task task}) = TaskAddedLocally;
  const factory TaskEvent.taskUpdatedLocally({required Task task}) = TaskUpdatedLocally;
  const factory TaskEvent.taskDeletedLocally({required String id}) = TaskDeletedLocally;
}

