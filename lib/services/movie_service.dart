import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:movie_app/models/movie_model.dart';


class MovieService {
  final String apiKey="4dc13f40";
  
  Future<MovieModel> fetchMovie(String movieName) async{
    final url = await Uri.parse("http://www.omdbapi.com/?apikey=$apiKey&t=${Uri.encodeComponent(movieName)}");
    final reponse = await http.get(url);

    if(reponse.statusCode == 200){
      final data = jsonDecode(reponse.body);
      if(data["Response"] == "True"){
        return MovieModel.fromJson(data);
    }else{
        throw Exception(data["Error"] ?? "Movie not Found");
      }
    }else{
      throw Exception("Failed to connect to OMDb API");
    }

  }
}