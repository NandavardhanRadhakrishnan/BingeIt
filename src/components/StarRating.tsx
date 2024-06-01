interface Props {
  rating: number;
}

function StarRating({ rating }: Props) {
  const filledStars = Math.floor(rating);
  const halfStars = rating - filledStars >= 0.5;
  const emptyStars = 5 - filledStars - (halfStars ? 1 : 0);
  const stars = [];
  for (let i = 0; i < filledStars; i++) {
    stars.push(<i key={i} className="bi bi-star-fill"></i>);
  }
  if (halfStars) {
    stars.push(<i key="half" className="bi bi-star-half"></i>);
  }
  for (let i = 0; i < emptyStars; i++) {
    stars.push(<i key={i} className="bi bi-star"></i>);
  }
  return <>{stars}</>;
}

export default StarRating;
