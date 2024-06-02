import { Movie } from "../models";
import MovieListing from "./MovieListing";

interface Props {
  movies: Movie[];
}

function MovieGroup({ movies }: Props) {
  return (
    <div className="row card-columns">
      {movies.map((item: Movie, index: number) => (
        <MovieListing
          key={index}
          title={item.title}
          overview={item.overview}
          rating={item.rating}
          posterUrl={item.posterUrl}
          genres={item.genres}
          releaseDate={item.releaseDate}
        />
      ))}
    </div>
  );
}

export default MovieGroup;
