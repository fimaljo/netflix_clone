import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/coustome_button_widget.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';

import '../../application/Home/home_bloc.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (BuildContext context, index, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.hasError) {
                          return const Center(
                            child: Text("something error"),
                          );
                        }
                        //released past year
                        final _releasedPastYear =
                            state.pastYearMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        //trending
                        final _trending = state.trendingMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        //tense drama
                        final _tenseDrama = state.tenseDramasMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        //south IndianMovies
                        final _southIndianMovies =
                            state.southIndianMovieList.map((m) {
                          return '$imageAppendUrl${m.posterPath}';
                        }).toList();
                        _southIndianMovies.shuffle();
                        //top10Tvshows
                        final _top10Tvlist = state.trendingTvList.map((t) {
                          return '$imageAppendUrl${t.posterPath}';
                        }).toList();
                        _top10Tvlist.shuffle();
                        return ListView(
                          children: [
                            BackgroundCard(),
                            MainTitleCard(
                              title: "Released in the past Year",
                              posterList: _releasedPastYear.sublist(0, 10),
                            ),
                            kHight,
                            MainTitleCard(
                              title: "Trending Now",
                              posterList: _trending.sublist(0, 10),
                            ),
                            kHight,
                            NumberTitleCard(
                              posterList: _top10Tvlist.sublist(0, 10),
                            ),
                            kHight,
                            MainTitleCard(
                              title: "Tense Dramas",
                              posterList: _tenseDrama.sublist(0, 10),
                            ),
                            kHight,
                            MainTitleCard(
                              title: "South Indian Cinema",
                              posterList: _southIndianMovies.sublist(0, 10),
                            ),
                            kHight,
                          ],
                        );
                      },
                    ),
                    scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 90,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      "https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png",
                                      width: 60,
                                      height: 60,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    kWidth,
                                    Container(
                                      height: 30,
                                      width: 30,
                                      color: Colors.blue,
                                    ),
                                    kWidth
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Tv Shows",
                                      style: kHomeTitileText,
                                    ),
                                    Text(
                                      "Movies",
                                      style: kHomeTitileText,
                                    ),
                                    Text(
                                      "Categories",
                                      style: kHomeTitileText,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : kHight
                  ],
                ),
              );
            }));
  }
}
