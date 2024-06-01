import StarRating from "./StarRating";
import TagGroup from "./TagGroup";

interface Props {
  title: string;
  authors: string[];
  coverImageUrl: string;
  rating: number;
  categories: string[];
}

function BookListing({
  title,
  authors,
  coverImageUrl,
  rating,
  categories,
}: Props) {
  return (
    <>
      <div className="card" style={{ width: "18rem", display: "inline-flex" }}>
        <img className="card-img-top" src={coverImageUrl} />
        <div className="card-body">
          <h4 className="card-title">{title}</h4>
          <StarRating rating={rating} />
          {/* {authors.length == 0 ? (
            <div className="card-text">{authors}</div>
          ) : (
            <TagGroup tags={authors} />
          )} */}

          <div className="card-text">{authors}</div>
          {categories.length > 5 ? (
            <TagGroup tags={categories.splice(0, 5)} />
          ) : (
            <TagGroup tags={categories} />
          )}
        </div>
      </div>
    </>
  );
}

export default BookListing;
