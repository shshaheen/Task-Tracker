import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/team.dart';

part 'team_state.freezed.dart';

@freezed
sealed class TeamState with _$TeamState {
  const factory TeamState.initial() = TeamInitial;
  const factory TeamState.loading() = TeamLoading;
  const factory TeamState.loaded({
    required List<Team> teams,
  }) = TeamLoaded;
  const factory TeamState.error({required String message}) = TeamError;
}
