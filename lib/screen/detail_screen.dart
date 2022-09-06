import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imovies/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:imovies/blocs/movie_detail/movie_detail_event.dart';
import 'package:imovies/blocs/movie_detail/movie_detail_state.dart';
import 'package:imovies/constant.dart';
import 'package:imovies/models/cast.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/models/movie_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(vsync: this, length: 3);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            MovieDetailBloc()..add(MovieDetailEventStated(widget.movie.id)),
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: buildAppBar(context),
          body: SafeArea(
            child: buildDetailBody(),
          ),
        ));
  }

  BlocBuilder<MovieDetailBloc, MovieDetailState> buildDetailBody() {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
              child: CupertinoActivityIndicator(color: Colors.white));
        } else if (state is MovieDetailLoaded) {
          MovieDetail movieDetail = state.detail;
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                                decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ));
                          },
                        ),
                      ),
                    ), // banner
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4,
                          left: MediaQuery.of(context).size.width - 75),
                      child: GestureDetector(
                        onTap: () async {
                          final youtubeUrl = Uri.parse(
                              'https://www.youtube.com/embed/${movieDetail.trailerId}');
                          if (await canLaunchUrl(youtubeUrl)) {
                            await launchUrl(youtubeUrl);
                          }
                        }, // su kien ontap
                        child: const Icon(
                          CupertinoIcons.play_circle,
                          color: kDarkColor,
                          size: 65,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          top: MediaQuery.of(context).size.height / 5.2),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${movieDetail.posterPath}',
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: MediaQuery.of(context).size.height / 3.8,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                              decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ));
                        },
                      ),
                    ), // poster
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2.4 + 45,
                          top: MediaQuery.of(context).size.height / 3 + 35,
                          right: 40),
                      child: Text(
                        movieDetail.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ), // Text title film
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 1.2 + 5,
                              top: MediaQuery.of(context).size.height / 3 + 20,
                              right: 5),
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                      'assets/images/star.svg')),
                              Text(
                                movieDetail.voteAverage,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ) // Vote average
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: SizedBox(
                      height: 700,
                      child: Stack(
                        children: [
                          TabBar(
                            controller: _tabController,
                            unselectedLabelStyle: const TextStyle(fontSize: 14),
                            labelPadding: const EdgeInsets.only(right: 25),
                            labelStyle: const TextStyle(fontSize: 18),
                            indicator: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(width: 3, color: kDarkColor)),
                            ),
                            isScrollable: true,
                            tabs: const [
                              Tab(
                                text: "About Movie",
                              ),
                              Tab(
                                text: "Reviews",
                              ),
                              Tab(
                                text: "Casts",
                              ),
                            ], // TabBar
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 65),
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Overviews:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ), // text Overviews
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 10),
                                        child: Text(
                                          movieDetail.overview,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ), // Overview
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              "Release Date:\n${movieDetail.releaseDate}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            "Rate Count:\n${movieDetail.voteCount}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ), // Release Date
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                "Budget:\n${movieDetail.budget}\$",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(
                                              "Vote Average:\n${movieDetail.voteAverage}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ), // Budget
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                "Duration:\n${movieDetail.runtime} Minutes",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) //Duration
                                    ],
                                  ), //Tab About movie
                                  Column(
                                    children: const [
                                      Text("Reviews"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Casts:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const VerticalDivider(
                                              color: Colors.transparent,
                                              width: 10,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                movieDetail.castList!.length,
                                            itemBuilder: (context, index) {
                                              Cast cast =
                                                  movieDetail.castList![index];
                                              String url;
                                              if (cast.profilePath == null) {
                                                url =
                                                    'https://image.tmdb.org/t/p/w200/10RyQ33J0ybXFzzXylgeF2yoMbx.jpg';
                                              } else {
                                                url =
                                                    'https://image.tmdb.org/t/p/w200${cast.profilePath}';
                                              } // neu profilePath =  null thi thay the bang url bat ky
                                              return Column(
                                                children: [
                                                  Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      elevation: 3,
                                                      child: ClipRRect(
                                                          child:
                                                              CachedNetworkImage(
                                                        imageUrl: url,
                                                        imageBuilder: (context,
                                                            imageBuilder) {
                                                          return Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.2,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                5,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          16)),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageBuilder,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ))), // the dien vien
                                                  Center(
                                                    child: Text(
                                                      cast.name,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.2,
                                                    child: Center(
                                                      child: Text(
                                                        '(${cast.character})',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      )
                      // ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) => buildList(index)),
                      ),
                )
              ],
            ),
          );
        } else {
          return const Center(
              child: CupertinoActivityIndicator(color: Colors.white));
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'Detail',
        style: TextStyle(fontSize: 16),
      ),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
      ],
    );
  } // Appbar

  // Widget buildList(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedIndex = index;
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 25),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //                 border: Border(
  //                     bottom: BorderSide(
  //                         width: 3,
  //                         color: selectedIndex == index
  //                             ? kDarkColor
  //                             : kBackgroundColor))),
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 6),
  //               child: Text(
  //                 list[index],
  //                 style: TextStyle(
  //                     fontSize: selectedIndex == index ? 20 : 15,
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
