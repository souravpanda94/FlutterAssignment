import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/data/repository/game_repository.dart';
import 'package:sample_project/domain/game_detail_cubit/game_detail_state.dart';

class GameDetailCubit extends Cubit<GameDetailState> {
  final String _id;
  GameDetailCubit(this._id) : super(GameDetailLoadingState()) {
    gameDeatilFetchEvent(_id);
  }
  //final GameRepository _gameRepository = GameRepository();

  void gameDeatilFetchEvent(String id) async {
    emit(GameDetailLoadingState());
    var gameRepository = GameRepository();
    var gameDeatil = await gameRepository.fetchGameDetail(id: id);
    if (gameDeatil == null) {
      emit(GameDetailErrorState(msg: "Error Fetching Data"));
    } else {
      emit(GameDetailLoadedState(gameDetailModel: gameDeatil));
    }
  }
}
