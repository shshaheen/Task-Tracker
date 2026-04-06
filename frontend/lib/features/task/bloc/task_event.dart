import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/task.dart';

part 'task_event.freezed.dart';

@freezed
sealed class TaskEvent with _$TaskEvent {
  const factory TaskEvent.fetchTasks({String? teamId}) = FetchTasks;

  const factory TaskEvent.addTask({
    required String title,
    required String teamId,
    String? description,
    String? priority,
    String? assignedTo,
  }) = AddTask;

  const factory TaskEvent.updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? teamId,
    String? assignedTo,
  }) = UpdateTask;

  const factory TaskEvent.deleteTask({required String id}) = DeleteTask;

  // Real-time sync events
  const factory TaskEvent.taskAddedLocally({required Task task}) =
      TaskAddedLocally;
  const factory TaskEvent.taskUpdatedLocally({required Task task}) =
      TaskUpdatedLocally;
  const factory TaskEvent.taskDeletedLocally({required String id}) =
      TaskDeletedLocally;
}
