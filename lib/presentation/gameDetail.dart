import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/domain/game_detail_cubit/game_detail_cubit.dart';
import 'package:sample_project/domain/game_detail_cubit/game_detail_state.dart';

class GameDetail extends StatefulWidget {
  final id;
  const GameDetail({super.key, this.id});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Detail"),
      ),
      body: Container(
        child: BlocConsumer<GameDetailCubit, GameDetailState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case GameDetailLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case GameDetailLoadedState:
                var gameDetailLoadedState = state as GameDetailLoadedState;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: CarouselSlider.builder(
                          itemCount: gameDetailLoadedState
                              .gameDetailModel.screenshots!.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return Image.network(
                              gameDetailLoadedState
                                      .gameDetailModel.screenshots?[index].image
                                      .toString() ??
                                  '',
                              fit: BoxFit.cover,
                            );
                          },
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                gameDetailLoadedState.gameDetailModel.title
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                gameDetailLoadedState.gameDetailModel.publisher
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Text(
                            gameDetailLoadedState.gameDetailModel.description
                                .toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      )
                    ],
                  ),
                );
              case GameDetailErrorState:
                var gameDetailErrorState = state as GameDetailErrorState;
                return Center(
                  child: Text(gameDetailErrorState.msg.toString()),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
