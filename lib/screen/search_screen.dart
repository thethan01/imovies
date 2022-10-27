import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovies/constant.dart';
import 'package:imovies/screen/detail_screen.dart';

import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../models/search_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();

  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                _searchBloc.add(
                  TextChanged(query: text),
                );
              },
              controller: _textController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: kDarkColor)),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: kDarkColor,
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
            child: _SearchBody(),
          )
        ],
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchStateError) {
          return const Center(
              child: Text('Error',
                  style: TextStyle(fontSize: 16, color: Colors.white)));
        }
        if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? const Center(
                  child: Text(
                  'No Results',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ))
              : SizedBox(
                  width: width - 50,
                  height: height,
                  child: _SearchResults(items: state.items));
        }
        return const Center(
          child: Text(
            'Please enter a term to begin',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<SearchResultItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 2 / 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: items)),
            );
          },
          child: CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/original/${items[index].posterPath}',
            imageBuilder: (context, imageProvider) {
              return Container(
                width: MediaQuery.of(context).size.width / 2.8,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) => const SizedBox(
              width: 180,
              height: 250,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(),
          ),
        );
      },
    );
  }
}
