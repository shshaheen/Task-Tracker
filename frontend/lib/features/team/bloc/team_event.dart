import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_event.freezed.dart';

@freezed
sealed class TeamEvent with _$TeamEvent {
  const factory TeamEvent.fetchTeams() = FetchTeams;

  const factory TeamEvent.createTeam({
    required String name,
    String? description,
  }) = CreateTeam;

  const factory TeamEvent.deleteTeam({required String id}) = DeleteTeam;
}
