import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/domain/game_cubit/game_cubit.dart';
import 'package:sample_project/domain/game_cubit/game_state.dart';

class GameList extends StatefulWidget {
  const GameList({super.key});

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  // final GameBloc _gameBloc = GameBloc();
  @override
  void initState() {
    // _gameBloc.add(GameListFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game List"),
      ),
      body: Container(
        child: BlocConsumer<GameCubit, GameState>(
          // bloc: _gameBloc,
          listener: (context, state) {
            if (state is GameLoadedState) {
              print("Game Is loaded");
            }
          },
          builder: (context, state) {
            if (state is GameLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GameLoadedState) {
              return ListView.builder(
                  itemCount: state.gameList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/gameDetail", arguments: {
                          "id": state.gameList[index].id.toString()
                        });
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 20, top: 10, left: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                state.gameList[index].thumbnail
                                    .toString(), // Your image URL
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null)
                                    return child; // If the image has loaded, display it

                                  // Show CircularProgressIndicator while the image is loading
                                  return Center(
                                    // Ensure the progress indicator is centered
                                    child: SizedBox(
                                      width:
                                          50.0, // Set the desired width for the progress indicator
                                      height:
                                          50.0, // Set the desired height for the progress indicator
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                        strokeWidth:
                                            5.0, // Set the thickness of the progress indicator
                                      ),
                                    ),
                                  );
                                },
                                fit: BoxFit
                                    .cover, // This ensures the image fits within the SizedBox dimensions
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.gameList[index].title.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      state.gameList[index].shortDescription
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (state is GameErrorState) {
              return Container(
                child: Center(
                  child: Text(state.msg),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
