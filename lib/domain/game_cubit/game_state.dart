import 'package:sample_project/data/model/game_model.dart';

sealed class GameState {}

final class GameInitial extends GameState {}

// Game List Fetch State

class GameLoadingState extends GameState {}

// ignore: must_be_immutable
class GameLoadedState extends GameState {
  List<GameModel> gameList = [];
  GameLoadedState({required this.gameList});
}

// ignore: must_be_immutable
class GameErrorState extends GameState {
  String msg = "";
  GameErrorState({required this.msg});
}
