import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:movie_project_flutter/presentation/cubit/movie_cubit.dart';
import 'package:movie_project_flutter/presentation/popular_movies/widget/movie_card.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  late MovieCubit movieCubit;

  int page = 1;
  bool isLoadMore = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.getPopularMovies(page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        page = page + 1;
        isLoadMore = true;
        movieCubit.getPopularMovies(page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverStickyHeader(
              header: Container(
                height: 40,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text(
                  'Popular Movies',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
              ),
              sliver: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is LoadingState && movieCubit.movies.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  if (state is FailedState) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                            child: Text(
                          state.message,
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                    );
                  }

                  return SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      childAspectRatio:
                          320 / 480, // Set cards aspect ratio to 2:3
                    ),
                    itemCount: movieCubit.movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MovieCard(movie: movieCubit.movies[index]);
                    },
                  );
                },
              ),
            ),
            if (isLoadMore)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
