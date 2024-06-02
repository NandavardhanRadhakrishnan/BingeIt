import { Book } from "../models";
import BookListing from "./BookListing";

interface Props {
  books: Book[];
}

function BookGroup({ books }: Props) {
  return (
    <div className="row card-columns">
      {books.map((item: Book, index: number) => (
        <BookListing
          key={index}
          title={item.title}
          authors={item.authors}
          rating={item.rating}
          coverImageUrl={item.coverImageUrl}
          categories={item.categories}
        />
      ))}
    </div>
  );
}

export default BookGroup;
