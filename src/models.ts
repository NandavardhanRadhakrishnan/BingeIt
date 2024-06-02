// Define the genre lookup
export const genreLookup: { [key: number]: string } = {
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
  
  // Define Movie interface
  interface IMovie {
    id: number;
    title: string;
    overview: string;
    genres: string[];
    releaseDate: string;
    posterUrl: string;
    rating: number;
  }
  
  // Define TVShow interface
  interface ITVShow {
    id: number;
    title: string;
    overview: string;
    genres: string[];
    posterUrl: string;
    rating: number;
  }
  
  // Define Book interface
  interface IBook {
    title: string;
    authors: string[];
    isbn: string;
    coverImageUrl: string;
    rating: number;
    categories: string[];
  }
  
  // Movie class implementing IMovie interface
  export class Movie implements IMovie {
    id: number;
    title: string;
    overview: string;
    genres: string[];
    releaseDate: string;
    posterUrl: string;
    rating: number;
  
    constructor(
      id: number,
      title: string,
      overview: string,
      genres: string[],
      releaseDate: string,
      posterUrl: string,
      rating: number
    ) {
      this.id = id;
      this.title = title;
      this.overview = overview;
      this.genres = genres;
      this.releaseDate = releaseDate;
      this.posterUrl = posterUrl;
      this.rating = rating;
    }
  
    static fromJson(json: any): Movie {
      const genreIds: number[] = json.genre_ids;
      const genres: string[] = genreIds.map((id) => genreLookup[id] || "");
  
      return new Movie(
        json.id,
        json.title,
        json.overview,
        genres,
        json.release_date,
        `https://image.tmdb.org/t/p/w500${json.poster_path}`,
        Math.round(parseFloat(json.vote_average))/2
      );
    }
  }
  
  // TVShow class implementing ITVShow interface
  export class TVShow implements ITVShow {
    id: number;
    title: string;
    overview: string;
    genres: string[];
    posterUrl: string;
    rating: number;
  
    constructor(
      id: number,
      title: string,
      overview: string,
      genres: string[],
      posterUrl: string,
      rating: number
    ) {
      this.id = id;
      this.title = title;
      this.overview = overview;
      this.genres = genres;
      this.posterUrl = posterUrl;
      this.rating = rating;
    }
  
    static fromJson(json: any): TVShow {
      const genreIds: number[] = json.genre_ids;
      const genres: string[] = genreIds.map((id) => genreLookup[id] || "");
      return new TVShow(
        json.id,
        json.name,
        json.overview,
        genres,
        json.poster_path
          ? `https://image.tmdb.org/t/p/w500${json.poster_path}`
          : '',
        Math.round(parseFloat(json.vote_average))/2
        
      );
    }
  }
  
  // Book class implementing IBook interface
  export class Book implements IBook {
    title: string;
    authors: string[];
    isbn: string;
    coverImageUrl: string;
    rating = 0.0;
    categories: string[];
  
    constructor(
      title: string,
      authors: string[],
      isbn: string,
      coverImageUrl: string,
      rating: number,
      categories: string[]
    ) {
      this.title = title;
      this.authors = authors;
      this.isbn = isbn;
      this.coverImageUrl = coverImageUrl;
      this.rating = rating;
      this.categories = categories;
    }
  
    static fromJson(json: any): Book {
      const title: string = json.title || "";
      const authors: string[] = (json.author_name || []).map((author: any) =>
        author.toString()
      );
      const isbn: string = json.isbn ? json.isbn[0] : "";
      const coverImageUrl: string = json.cover_edition_key
      ? `https://covers.openlibrary.org/b/olid/${json.cover_edition_key}-M.jpg`
      : "";
      const rating:number = parseFloat(json.ratings_average)
      const categories: string[] = (json.subject || []).map((category: any) =>
        category.toString()
      );
  
      return new Book(title, authors, isbn, coverImageUrl, rating, categories);
    }
  }
  