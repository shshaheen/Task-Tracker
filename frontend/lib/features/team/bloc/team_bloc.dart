import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/task_api_service.dart';
import '../models/team.dart';
import 'team_event.dart';
import 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TaskApiService _apiService;

  TeamBloc({TaskApiService? apiService})
      : _apiService = apiService ?? TaskApiService(),
        super(const TeamState.initial()) {
    on<FetchTeams>(_onFetchTeams);
    on<CreateTeam>(_onCreateTeam);
    on<DeleteTeam>(_onDeleteTeam);
  }

  Future<void> _onFetchTeams(FetchTeams event, Emitter<TeamState> emit) async {
    if (state is TeamInitial) {
      emit(const TeamState.loading());
    }

    try {
      final teams = await _apiService.fetchTeams();
      emit(TeamState.loaded(teams: teams));
    } on DioException catch (e) {
      emit(TeamState.error(message: _formatDioError(e)));
    } catch (e) {
      emit(TeamState.error(message: 'Unexpected error: $e'));
    }
  }

  Future<void> _onCreateTeam(CreateTeam event, Emitter<TeamState> emit) async {
    final previousTeams = _currentTeams;

    // 1. Optimistic Update
    final tempTeam = Team(
      id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
      name: event.name,
      description: event.description,
    );

    emit(TeamState.loaded(teams: [...previousTeams, tempTeam]));

    try {
      await _apiService.createTeam(
        name: event.name,
        description: event.description,
      );
      // Refetch to get actual ID from server
      add(const TeamEvent.fetchTeams());
    } catch (e) {
      emit(TeamState.loaded(teams: previousTeams));
      emit(TeamState.error(message: 'Failed to create team: $e'));
    }
  }

  Future<void> _onDeleteTeam(DeleteTeam event, Emitter<TeamState> emit) async {
    final previousTeams = _currentTeams;
    final updatedTeams = previousTeams.where((t) => t.id != event.id).toList();

    emit(TeamState.loaded(teams: updatedTeams));

    try {
      await _apiService.deleteTeam(event.id);
    } catch (e) {
      emit(TeamState.loaded(teams: previousTeams));
      emit(TeamState.error(message: 'Failed to delete team: $e'));
    }
  }

  List<Team> get _currentTeams =>
      state is TeamLoaded ? (state as TeamLoaded).teams : [];

  String _formatDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Is the server running?';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Cannot reach the server. Check your network.';
    }
    final status = e.response?.statusCode;
    final serverMsg = e.response?.data?['message'] as String?;
    if (serverMsg != null) return serverMsg;
    return status != null ? 'Server error ($status)' : 'Network error';
  }
}
