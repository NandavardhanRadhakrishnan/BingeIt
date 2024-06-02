enum MediaType {
  movie,
  tv,
  book,
}

Map<int, String> genreLookup = {
  28: "Action",
  12: "Adventure",
  16: "Animation",
  35: "Comedy",
  80: "Crime",
  99: "Documentary",
  18: "Drama",
  10751: "Family",
  14: "Fantasy",
  36: "History",
  27: "Horror",
  10402: "Music",
  9648: "Mystery",
  10749: "Romance",
  878: "Science Fiction",
  10770: "TV Movie",
  53: "Thriller",
  10752: "War",
  37: "Western",
};

// class Movie {
//   final int id;
//   final String title;
//   final String overview;
//   final List<String>? genres;
//   final String releaseDate;
//   final String? posterPath;
//   final double rating;

//   Movie({
//     required this.id,
//     required this.title,
//     required this.overview,
//     this.genres = const [],
//     required this.releaseDate,
//     this.posterPath,
//     required this.rating,
//   });

//   factory Movie.fromJson(Map<String, dynamic> json) {
//     List<String>? genres = List<String>.from((json['genres'] ?? []).map((genre) => genre['name'].toString()));

//     return Movie(
//       id: json['id'],
//       title: json['title'],
//       overview: json['overview'],
//       genres: genres,
//       releaseDate: json['release_date'],
//       posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
//       rating: json['vote_average'].toDouble(),
//     );
//   }
// }

class Movie {
  final int id;
  final String title;
  final String overview;
  final List<String> genres;
  final String releaseDate;
  final String posterPath;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.genres,
    required this.releaseDate,
    required this.posterPath,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<dynamic> genreIds = json['genre_ids'];
    List<String> genres = genreIds.map((id) => genreLookup[id] ?? "").toList();

    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      genres: genres,
      releaseDate: json['release_date'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
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

class Book {
  final String title;
  final List<String> authors;
  final String isbn;
  final String coverImageUrl;
  final List<String> categories;

  factory Book.fromJson(Map<String, dynamic> json) {
    final String title = json['title'] != null ? json['title'] : '';
    final List<dynamic> authorsJson = json['author_name'] ?? [];
    final List<String> authors = authorsJson.map((author) => author.toString()).toList();
    final String isbn = json['isbn'] != null ? json['isbn'][0] : '';
    final String coverImageUrl = json['cover_edition_key'] != null ? 'https://covers.openlibrary.org/b/olid/${json['cover_edition_key']}-M.jpg' : '';
    final List<dynamic> categoriesJson = json['subject'] ?? [];
    final List<String> categories = categoriesJson.map((category) => category.toString()).toList();

    return Book(
      title: title,
      authors: authors,
      isbn: isbn,
      coverImageUrl: coverImageUrl,
      categories: categories,
    );
  }

  Book({
    required this.title,
    required this.authors,
    required this.isbn,
    required this.coverImageUrl,
    required this.categories,
  });
}
