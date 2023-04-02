enum MediaType {
  movie,
  tv,
  book,
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
