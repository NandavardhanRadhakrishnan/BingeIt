import StarRating from "./StarRating";
import TagGroup from "./TagGroup";

interface Props {
  title: string;
  overview: string;
  rating: number;
  posterUrl: string;
  genres: string[];
  releaseDate: string;
}

function MovieListing({
  title,
  overview,
  rating,
  posterUrl,
  genres,
  releaseDate,
}: Props) {
  return (
    <div className="card" style={{ width: "18rem", display: "inline-flex" }}>
      <img className="card-img-top" src={posterUrl} />
      <div className="card-body">
        <h4 className="card-title">{title}</h4>
        <div style={{ display: "flex", justifyContent: "space-between" }}>
          <div>
            <StarRating rating={rating}></StarRating>
          </div>
          <span className="card-text">{releaseDate}</span>
        </div>
        <br />
        <TagGroup tags={genres}></TagGroup>
        <p className="card-text text-truncate">{overview}</p>
      </div>
    </div>
  );
}

export default MovieListing;
