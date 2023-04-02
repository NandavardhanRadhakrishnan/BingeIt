enum MediaType {
  movie,
  tv,
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final List<String>? genres;
  final String releaseDate;
  final String? posterPath;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.genres = const [],
    required this.releaseDate,
    this.posterPath,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<dynamic>? genreList = json['genres'];
    List<String>? genres = genreList?.map((genre) => genre['name'].toString()).toList();

    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      genres: genres,
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      rating: json['vote_average'].toDouble(),
    );
  }
}

class TVShow {
  final int id;
  final String name;
  final String? overview;
  final String? posterUrl;

  TVShow({
    required this.id,
    required this.name,
    this.overview,
    this.posterUrl,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterUrl: json['poster_path'] == null ? null : 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
    );
  }
}
