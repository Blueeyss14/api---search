import 'package:api_search/api/model/human.dart';
import 'package:api_search/components/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Movie>> _movie = Movie.movieApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Test"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySearchBar(),
                      ));
                },
                child: Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder(
          future: _movie,
          builder: (context, dynamic snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${snapshot.data[index].poster}'),
                    ),
                    title: Text(snapshot.data[index].title),
                  );
                },
              );
            } else {
              return const Center(child: Text("No data"));
            }
          }),
    );
  }
}
