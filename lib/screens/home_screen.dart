import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  final MovieService movieService = MovieService();

  MovieModel? movie;

  bool isLoading = false;

  String? errorMessage;

  Future<void> searchMovie() async {
    if (controller.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await movieService.fetchMovie(
        controller.text.trim(),
      );

      setState(() {
        movie = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        movie = null;
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Movie Search",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Search Movie",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter movie name",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchMovie,
                ),
              ),

              onSubmitted: (_) {
                searchMovie();
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: isLoading ? null : searchMovie,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (errorMessage != null)
              Center(
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),

            if (movie != null)
              movieDetails(movie!),
          ],
        ),
      ),
    );
  }

  Widget movieDetails(MovieModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (movie.poster.isNotEmpty && movie.poster != "N/A")
          Center(
            child: Image.network(
              movie.poster,
              width: 200,
              height: 300,
              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.movie,
                  size: 150,
                );
              },
            ),
          ),

        const SizedBox(height: 20),

        Center(
          child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 20),

        movieInfo("Year", movie.year),
        movieInfo("Rated", movie.rated),
        movieInfo("Released", movie.released),
        movieInfo("Runtime", movie.runtime),
        movieInfo("Genre", movie.genre),
        movieInfo("Director", movie.director),
        movieInfo("Writer", movie.writer),
        movieInfo("Actors", movie.actors),
        movieInfo("Language", movie.language),
        movieInfo("Country", movie.country),
        movieInfo("IMDb Rating", movie.imdbRating),

        const SizedBox(height: 20),

        const Text(
          "Plot",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          movie.plot,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget movieInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 110,

            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
