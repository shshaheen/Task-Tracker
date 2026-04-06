import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/task.dart';

part 'task_state.freezed.dart';

@freezed
sealed class TaskState with _$TaskState {
  const factory TaskState.initial() = TaskInitial;
  const factory TaskState.loading() = TaskLoading;
  const factory TaskState.loaded({
    required List<Task> tasks,
  }) = TaskLoaded;
  const factory TaskState.error({required String message}) = TaskError;
}
