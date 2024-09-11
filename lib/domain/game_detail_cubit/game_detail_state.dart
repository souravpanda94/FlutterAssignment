import 'package:sample_project/data/model/game_detail_model.dart';

sealed class GameDetailState {}

final class GameDetailInitial extends GameDetailState {}

class GameDetailLoadingState extends GameDetailState {}

// ignore: must_be_immutable
class GameDetailLoadedState extends GameDetailState {
  GameDetailModel gameDetailModel;
  GameDetailLoadedState({required this.gameDetailModel});
}

// ignore: must_be_immutable
class GameDetailErrorState extends GameDetailState {
  String msg = "";
  GameDetailErrorState({required this.msg});
}
