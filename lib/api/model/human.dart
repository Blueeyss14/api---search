import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_search/api/api_key.dart';

class Movie {
  String title, poster, overview;

  Movie({
    required this.title,
    required this.poster,
    required this.overview,
  });

  static Future<List<Movie>> movieApi() async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?${ApiKey.apiKey}&page=1');

    var responseAPI = await http.get(url);
    var data = (json.decode(responseAPI.body))['results'] as List;

    return data
        .map((data) => Movie(
              title: data['title'],
              poster: data['poster_path'],
              overview: data['overview'],
            ))
        .toList();
  }
}
