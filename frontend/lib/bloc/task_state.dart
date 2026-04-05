import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/task_model.dart';
import '../models/team_model.dart';

part 'task_state.freezed.dart';

// ---------------------------------------------------------------------------
// TaskState — sealed union of every UI state the board can be in.
//
// Freezed generates == / hashCode / toString / when / maybeWhen for free.
// ---------------------------------------------------------------------------

@freezed
sealed class TaskState with _$TaskState {
  /// App just launched — no data fetched yet.
  const factory TaskState.initial() = TaskInitial;

  /// A network request is in flight.
  const factory TaskState.loading() = TaskLoading;

  /// Tasks and teams fetched successfully.
  const factory TaskState.loaded({
    required List<Task> tasks,
    required List<Team> teams,
  }) = TaskLoaded;

  /// Something went wrong; [message] is shown in a SnackBar.
  const factory TaskState.error({required String message}) = TaskError;
}
