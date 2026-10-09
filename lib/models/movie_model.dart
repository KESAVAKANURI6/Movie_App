class MovieModel {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String poster;
  final String imdbRating;

  MovieModel({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.poster,
    required this.imdbRating,
});

  factory MovieModel.fromJson(Map<String,dynamic> json){
    return MovieModel(
      title: json["Title"] ?? "N/A",
      year: json["Year"] ?? "N/A",
      rated: json["Rated"] ?? "N/A",
      released: json["Released"] ?? "N/A",
      runtime: json["Runtime"] ?? "N/A",
      genre: json["Genre"] ?? "N/A",
      director: json["Director"] ?? "N/A",
      writer: json["Writer"] ?? "N/A",
      actors: json["Actors"] ?? "N/A",
      plot: json["Plot"] ?? "N/A",
      language: json["Language"] ?? "N/A",
      country: json["Country"] ?? "N/A",
      poster: json["Poster"] ?? "",
      imdbRating: json["imdbRating"] ?? "N/A",
    );
  }
}