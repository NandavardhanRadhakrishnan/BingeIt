import StarRating from "./StarRating";
import TagGroup from "./TagGroup";

interface Props {
  title: string;
  overview: string;
  rating: number;
  posterUrl: string;
  genres: string[];
}

function TvListing({ title, overview, rating, posterUrl, genres }: Props) {
  return (
    <div className="card" style={{ width: "18rem", display: "inline-flex" }}>
      <img className="card-img-top" src={posterUrl} />
      <div className="card-body">
        <h4 className="card-title">{title}</h4>
        <StarRating rating={rating} />
        <br />
        <TagGroup tags={genres}></TagGroup>
        <p className="card-text text-truncate">{overview}</p>
      </div>
    </div>
  );
}

export default TvListing;
