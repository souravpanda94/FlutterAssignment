import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/data/repository/game_repository.dart';
import 'package:sample_project/domain/game_cubit/game_cubit.dart';
import 'package:sample_project/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GameRepository gameRepository = GameRepository();

    return BlocProvider(
      create: (context) => GameCubit(gameRepository),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: "/gameList", // Initial route
      ),
    );
  }
}
