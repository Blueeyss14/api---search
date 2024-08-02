import 'package:api_search/api/model/human.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final Future<List<Movie>> _movie = Movie.movieApi();
  Future<List<Movie>> searchFiltered = Movie.movieApi();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFiltered = _movie;
  }

  void searchMovie(String search) {
    setState(() {
      searchFiltered = _movie.then((movies) => movies
          .where((movie) =>
              movie.title.toLowerCase().contains(search.toLowerCase()))
          .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          onChanged: searchMovie,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                searchMovie(_controller.text);
              },
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: searchFiltered,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movies[index].title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
