import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/data/repository/game_repository.dart';
import 'package:sample_project/domain/game_cubit/game_cubit.dart';
import 'package:sample_project/domain/game_detail_cubit/game_detail_cubit.dart';
import 'package:sample_project/presentation/gameDetail.dart';
import 'package:sample_project/presentation/gameList.dart';

// class Routes {
//   static Route? onGenerateRoute(RouteSettings routeSettings) {
//     GameRepository gameRepository = GameRepository();
//     switch (routeSettings.name) {
//       case "/gameList":
//         return MaterialPageRoute(
//             builder: (context) => BlocProvider(
//                   create: (context) => GameCubit(gameRepository),
//                   child: const MaterialApp(
//                     debugShowCheckedModeBanner: false,
//                     home: GameList(),
//                   ),
//                 ));

//       case "/gameDetail":
//         Map<String, dynamic> args =
//             routeSettings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//             builder: (context) => BlocProvider(
//                   create: (context) =>
//                       GameDetailCubit(gameRepository, args["id"]),
//                   child: const MaterialApp(
//                     debugShowCheckedModeBanner: false,
//                     home: GameDetail(),
//                   ),
//                 ));
//     }
//     return null;
//   }
// }

class Routes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    GameRepository gameRepository = GameRepository();

    switch (routeSettings.name) {
      case "/gameList":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => GameCubit(gameRepository),
            child: const GameList(), // Removed MaterialApp here
          ),
        );

      case "/gameDetail":
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                GameDetailCubit(args["id"]), // Assuming "id" is an integer
            child: const GameDetail(), // Removed MaterialApp here
          ),
        );
    }

    return null; // Handle other unknown routes or return a default route if needed
  }
}
