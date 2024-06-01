import React, { useEffect, useState } from "react";
import main from "./bingeIt";
import MovieListing from "./components/MovieListing";
import TvListing from "./components/TvListing";
import { Movie, TVShow, Book, genreLookup } from "./models";
import StarRating from "./components/StarRating";
import TagGroup from "./components/TagGroup";

function App() {
  const [results, setResults] = useState([]);

  useEffect(() => {
    async function fetchData() {
      const watched = "interstellar";
      const recommendWhat = "movie";
      const data = await main(watched, recommendWhat);
      setResults(data);
    }

    fetchData();
  }, []);

  return (
    <div>
      <h1>Recommendations</h1>
      <div className="row card-columns">
        {results.map((item: Movie, index) => (
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
    </div>
  );

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
}

export default App;
