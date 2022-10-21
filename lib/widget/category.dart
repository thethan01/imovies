import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/blocs/genre/genre_bloc.dart';
import 'package:imovies/blocs/genre/genre_event.dart';
import 'package:imovies/blocs/genre/genre_state.dart';
import 'package:imovies/blocs/movie_genre/movie_genre_bloc.dart';
import 'package:imovies/blocs/movie_genre/movie_genre_event.dart';
import 'package:imovies/blocs/movie_genre/movie_genre_state.dart';
import 'package:imovies/constant.dart';
import 'package:imovies/models/genre.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/screen/detail_screen.dart';

class Category extends StatefulWidget {
  final int selectGenre;

  const Category({Key? key, this.selectGenre = 28}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late int selectGenre;

  @override
  void initState() {
    super.initState();
    selectGenre = widget.selectGenre;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GenreBloc>(
          create: (_) => GenreBloc()..add(const GenreEventStart())),
      BlocProvider<MovieGenreBloc>(
          create: (_) =>
              MovieGenreBloc()..add(MovieGenreEventStart(selectGenre, '')))
    ], child: _buildGenre(context));
  }

  Widget _buildGenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreBloc, GenreState>(builder: (context, state) {
          if (state is GenreLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is GenreLoaded) {
            List<Genre> genres = state.genreList;
            return Padding(
              padding: const EdgeInsets.only(left: 25, top: 15, right: 5),
              child: SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    Genre genre = genres[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Genre genre = genres[index];
                              selectGenre = genre.id;
                              context
                                  .read<MovieGenreBloc>()
                                  .add(MovieGenreEventStart(selectGenre, ''));
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 3,
                                            color: (genre.id == selectGenre)
                                                ? kDarkColor
                                                : kBackgroundColor))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    genre.name,
                                    style: TextStyle(
                                        fontSize:
                                            (genre.id == selectGenre) ? 18 : 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ); // ListView chon chu de phim
          } else {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.white,
            ));
          }
        }),
        BlocBuilder<MovieGenreBloc, MovieGenreState>(builder: (context, state) {
          if (state is MovieGenreLoading) {
            return const CupertinoActivityIndicator();
          } else if (state is MovieGenreLoaded) {
            List<Movie> movieList = state.movieGenreList;
            return Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          Movie movie = movieList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(movie: movie)),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        // placeholder: (context, url) =>
                                        //     const SizedBox(
                                        //   width: 180,
                                        //   height: 250,
                                        //   child: Center(
                                        //     child: CupertinoActivityIndicator(),
                                        //   ),
                                        // ),
                                        // errorWidget: (context, url, error) =>
                                        //     Container(),
                                      ),
                                    ),
                                    // Hinh minh hoa
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.6),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15,
                                                  top: 10,
                                                  left: 15),
                                              child: Text(
                                                'Title:\n${movie.title}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15, left: 15),
                                              child: Text(
                                                'Release Date:\n${movie.releaseDate}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15, left: 15),
                                              child: Text(
                                                'Vote Count:\n${movie.voteCount}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                'Vote Average:\n${movie.voteAverage}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ), // so luoc phim
                                      ),
                                    ),
                                    // so luoc phim
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: MediaQuery.of(context)
                                    //                   .size
                                    //                   .width /
                                    //               2.8 +
                                    //           MediaQuery.of(context)
                                    //                   .size
                                    //                   .width /
                                    //               2.6),
                                    //   child: Column(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.start,
                                    //     children: [
                                    //       IconButton(
                                    //           onPressed: () {},
                                    //           icon: SvgPicture.asset(
                                    //               'assets/images/watch_list.svg')),
                                    //       IconButton(
                                    //           onPressed: () {},
                                    //           icon: SvgPicture.asset(
                                    //               'assets/images/star.svg')),
                                    //       Text(
                                    //         movie.voteAverage,
                                    //         style: const TextStyle(
                                    //             fontSize: 14,
                                    //             color: Colors.white),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ) // Rate, luu phim
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ) //khoang trong duoi hinh anh
                            ],
                          ); // danh sach phim theo chu de
                        }))
              ],
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        })
      ],
    );
  }
}
