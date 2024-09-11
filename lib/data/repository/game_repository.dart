import 'package:sample_project/data/model/game_detail_model.dart';
import 'package:sample_project/data/model/game_model.dart';
import 'package:sample_project/data/repository/api/api.dart';

class GameRepository {
  API api = API();
  Future<List<GameModel>> fetchGames() async {
    try {
      final response = await api.sendRequest.get('/games');
      if (response.statusCode == 200) {
        final responseJson = response.data;
        return List<GameModel>.from(
            responseJson.map((x) => GameModel.fromJson(x)));
      } else {
        // If the server returns an error response, throw an Exception
        throw Exception('Failed to fetch games: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GameDetailModel?> fetchGameDetail({required String id}) async {
    try {
      final response = await api.sendRequest.get('/game?id=$id');
      if (response.statusCode == 200) {
        final responseJson = response.data;
        return GameDetailModel.fromJson(responseJson);
      } else {
        // If the server returns an error response, throw an Exception
        throw Exception('Failed to load game detail: ${response.statusCode}');
      }
    } catch (e) {
      // If an error occurs during the request, return null
      rethrow;
    }
  }
}
