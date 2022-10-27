import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:imovies/blocs/movie/movie_bloc.dart';
import 'package:imovies/blocs/movie/movie_event.dart';
import 'package:imovies/blocs/movie/movie_state.dart';
import 'package:imovies/constant.dart';
import 'package:imovies/models/movie.dart';
import 'package:imovies/screen/detail_screen.dart';
import 'package:imovies/screen/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = "Home_Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _textController = TextEditingController();

  // late SearchBloc _githubSearchBloc;

  @override
  void initState() {
    super.initState();
    // _githubSearchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(const MovieEventStart(0, '')),
        ),
      ],
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (_selectedIndex == 0) {
              return homeScreen();
            } else if (_selectedIndex == 1) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 25, left: 25),
                    child: Text(
                      'What do you want to watch?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    child: TextField(
                      maxLines: 1,
                      onChanged: (text) {
                        // _githubSearchBloc.add(
                        //   TextChanged(query: text),
                        // );
                      },
                      controller: _textController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: kDarkColor)),
                        hintText: 'Seach',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: kDarkColor,
                        filled: true,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    child: Text(
                      'Top Search',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // BlocBuilder<SearchCubit, SearchState>(
                  //     builder: (context, state) {
                  //   if (state is SearchInitial) {
                  //     return const Center(
                  //       child: Text(
                  //         "There's nothing here",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     );
                  //   }
                  //   if (state is SearchLoadedState) {}
                  //   if (state is SearchErrorState) {
                  //     return const Text('Error'); //ErrorPage in progress
                  //   } else {
                  //     return Container();
                  //   }
                  // })
                ],
              );
            } else if (_selectedIndex == 2) {
              return const Center(
                  child: Text(
                'Watch list tab',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ));
            }
            return const Center(
                child: Text(
              'Setting tab',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ));
          },
        )),
        bottomNavigationBar: buildNavigatorBar(),
      ),
    );
  }

  Widget buildNavigatorBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        child: GNav(
          rippleColor: kBackgroundColor,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: kDarkColor,
          iconSize: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.white,
          color: Colors.white,
          tabs: const [
            GButton(
              icon: CupertinoIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: CupertinoIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: CupertinoIcons.heart,
              text: 'Favorites',
            ),
            GButton(
              icon: CupertinoIcons.settings,
              text: 'Setting',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget homeScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30, left: 25),
            child: Text(
              'What do you want to watch?',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ), // Text mo dau
          ),
          buildSlideShowMovie(),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 25),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ), // Text Categories
          ),
          const Category(),
        ],
      ),
    );
  }

  LayoutBuilder buildSlideShowMovie() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: constrains.minHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  List<Movie> movies = state.movieList;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index, _) {
                          Movie movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(movie: movie)),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '$urlImg${movie.backdropPath}',
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CupertinoActivityIndicator(
                                            color: Colors.white),
                                    errorWidget: (context, url, error) =>
                                        Container(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15,
                                    left: 15,
                                  ),
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: const TextStyle(
                                      color: kTextDarkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CupertinoActivityIndicator(color: Colors.white);
                }
              },
            )
          ],
        ),
      );
    });
  }
}
