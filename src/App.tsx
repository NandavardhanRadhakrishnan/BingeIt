import React, { useEffect, useState } from "react";
import { recommend, findMovie, findTvShow, findBook } from "./bingeIt";
import MovieGroup from "./components/MovieGroup";
import TvGroup from "./components/TvGroup";
import BookGroup from "./components/BookGroup";
import Loading from "./components/Loading";
import { Movie, TVShow, Book } from "./models";

// TODO handle input and switch output

// function App() {
//   // const [results, setResults] = useState<(Movie | TVShow | Book)[]>([]);
//   const [results, setResults] = useState([]);

//   const watched = "interstellar";
//   const recommendWhat = "tv";
//   useEffect(() => {
//     async function fetchData() {
//       const data = await main(watched, recommendWhat);
//       setResults(data);
//     }

//     fetchData();
//   }, []);

//   return (
//     <div>
//       <h1>Recommendations</h1>
//     </div>
//   );

// const ratingsArray = [];
// for (let i = 0; i <= 5; i += 0.5) {
//   ratingsArray.push(i);
// }
// return (
//   <>
//     {ratingsArray.map((r, i) => (
//       <>
// <StarRating rating={r} />
//         <br />
//       </>
//     ))}
//   </>
// );

// return (
//   <>
//     <h1>hello</h1>
//     <TagGroup tags={["hello", "world"]}></TagGroup>
//   </>
// );
// }

// export default App;

function App() {
  const [watched, setWatched] = useState("");
  const [recommendWhat, setRecommendWhat] = useState<"movie" | "tv" | "book">(
    "movie"
  );
  const [movies, setMovies] = useState<Movie[]>([]);
  const [tvShows, setTvShows] = useState<TVShow[]>([]);
  const [books, setBooks] = useState<Book[]>([]);
  const [loading, setLoading] = useState(false);

  const handleRecommend = async () => {
    setLoading(true);

    try {
      const recommendation = await recommend(watched, recommendWhat);
      const { similar } = recommendation;

      if (recommendWhat === "movie") {
        const movieResults = await Promise.all(similar.map(findMovie));
        setMovies(movieResults);
        setTvShows([]);
        setBooks([]);
      } else if (recommendWhat === "tv") {
        const tvResults = await Promise.all(similar.map(findTvShow));
        setTvShows(tvResults);
        setMovies([]);
        setBooks([]);
      } else if (recommendWhat === "book") {
        const bookResults = await Promise.all(similar.map(findBook));
        setBooks(bookResults);
        setMovies([]);
        setTvShows([]);
      }
    } catch (error) {
      console.error("Error fetching recommendations:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-100">
      <h1 className="text-dark mb-5 font-style text-center display-4">
        BingeIt
      </h1>

      <div className="w-100 d-flex justify-content-center align-items-center">
        <div className="pill-shaped bg-secondary p-3 d-flex align-items-center">
          <span className="h3 text-light mr-3">I have seen</span>
          <input
            type="text"
            value={watched}
            onChange={(e) => setWatched(e.target.value)}
            placeholder="Movie/TV Show/Book"
            className="form-control-lg bg-light pill-shaped text-dark border-0 mr-3"
          />
          <span className="h3 text-light mr-3">recommend me</span>
          <select
            value={recommendWhat}
            onChange={(e) =>
              setRecommendWhat(e.target.value as "movie" | "tv" | "book")
            }
            className="form-control-lg bg-light text-dark pill-shaped border-0 mr-3"
          >
            <option value="movie">Movies</option>
            <option value="tv">TV Shows</option>
            <option value="book">Books</option>
          </select>
          <button
            onClick={handleRecommend}
            className="btn btn-lg btn-secondary text-light pill-shaped border"
          >
            Submit
          </button>
        </div>
      </div>

      <div className="w-100 mt-5">
        {" "}
        {/* Add margin top for space */}
        <div className="custom-container">
          {" "}
          {/* Apply custom-container class */}
          {loading && <Loading />}
          {!loading && movies.length > 0 && <MovieGroup movies={movies} />}
          {!loading && tvShows.length > 0 && <TvGroup tvshows={tvShows} />}
          {!loading && books.length > 0 && <BookGroup books={books} />}
        </div>
      </div>
    </div>
  );
}
export default App;
