import 'dart:async';
import 'dart:convert';
import 'package:flutter_splash/splash/index.dart';
import 'package:http/http.dart';

class SplashProvider {
  final SplashRepository _splashRepository = new SplashRepository();

  SplashProvider();

  Client client = Client();
  final _apiKey = '436399d0406e2dd02cf1cd21fe2735b2';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MovieListModel> getData() async {
    print("entered");
    final response = await client
        .get("$_baseUrl/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MovieListModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
