import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/data/model/game_model.dart';
import 'package:sample_project/data/repository/game_repository.dart';
import 'package:sample_project/domain/game_cubit/game_state.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  GameCubit(this._gameRepository) : super(GameLoadingState()) {
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      List<GameModel> games = await _gameRepository.fetchGames();
      emit(GameLoadedState(gameList: games));
    } catch (ex) {
      emit(GameErrorState(msg: ex.toString()));
    }
  }
}
