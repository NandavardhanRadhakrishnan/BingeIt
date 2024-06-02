import { TVShow } from "../models";
import TvListing from "./TvListing";

interface Props {
  tvshows: TVShow[];
}

function TvGroup({ tvshows }: Props) {
  return (
    <div className="row card-columns">
      {tvshows.map((item: TVShow, index: number) => (
        <TvListing
          key={index}
          title={item.title}
          overview={item.overview}
          rating={item.rating}
          posterUrl={item.posterUrl}
          genres={item.genres}
        />
      ))}
    </div>
  );
}

export default TvGroup;
