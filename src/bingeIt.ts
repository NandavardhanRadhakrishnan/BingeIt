import Groq from "groq-sdk";
import axios from "axios";
import { Movie, TVShow, Book, genreLookup } from "./models";

const tmdbApiKey = "798d0f567e46dc804c56e50cc84c0e5b";
const groqApiKey = "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"

// export default async function main(watched: string, recommendWhat: "movie" | "tv" | "book"): Promise<(Movie | TVShow | Book)[]> {
//   const recommended = await recommend(watched, recommendWhat);
//   const listOfMedia = recommended.similar;
//   const results: (Movie | TVShow | Book)[] = [];
  
//   for (const item of listOfMedia) {
//     results.push(await findMedia(item, recommendWhat));
//   }

//   return results;
// }

export async function recommend(watched: string, recommendWhat: "movie" | "tv" | "book"): Promise<{ similar: string[] }> {
  const groq = new Groq({
    apiKey: groqApiKey,
    dangerouslyAllowBrowser: true,
  });

  try {
    const chatCompletion = await groq.chat.completions.create({
      messages: [
        {
          role: "system",
          content: "JSON output {similar:[name1,name2...]}",
        },
        {
          role: "user",
          content: `${recommendWhat} similar to ${watched}`,
        },
      ],
      model: "llama3-70b-8192",
      temperature: 0,
      max_tokens: 1024,
      top_p: 1,
      stream: false,
      response_format: {
        type: "json_object",
      },
      stop: null,
    });

    const content = chatCompletion.choices[0].message.content;
    if (content) {
      return JSON.parse(content);
    } else {
      return { similar: [] };
    }
  } catch (error) {
    console.error(error);
    return { similar: [] };
  }
}

export async function findMovie(query:string):Promise<Movie> {
  const baseUrl = "https://api.themoviedb.org/3";
  const mediaPath="/movie";
  
  try {
    const response = await axios.get(`${baseUrl}/search${mediaPath}`, {
      params: {
        api_key: tmdbApiKey,
        query: query,
      },
    });

    if (response.status === 200) {
      const data = response.data;

      if (!data.results || data.results.length === 0) {
        throw new Error("No results found");
      }

      
      const movie = Movie.fromJson(data.results[0]);
      return movie;

    } else {
      throw new Error("Failed to load media");
    }
  } catch (error) {
    console.error(error);
    throw new Error("Failed to load media");
  }

}

export async function findTvShow(query:string):Promise<TVShow> {
  const baseUrl = "https://api.themoviedb.org/3";
  const mediaPath="/tv";
  
  try {
    const response = await axios.get(`${baseUrl}/search${mediaPath}`, {
      params: {
        api_key: tmdbApiKey,
        query: query,
      },
    });

    if (response.status === 200) {
      const data = response.data;

      if (!data.results || data.results.length === 0) {
        throw new Error("No results found");
      }

      
      const movie = TVShow.fromJson(data.results[0]);
      return movie;

    } else {
      throw new Error("Failed to load media");
    }
  } catch (error) {
    console.error(error);
    throw new Error("Failed to load media");
  }

}

export async function findBook(query: string):Promise<Book> {
  const baseUrl = "http://openlibrary.org/search.json";

    try {
      const response = await axios.get(`${baseUrl}?q=${query}`);
      if (response.status === 200) {
        const data = response.data;
        if (data.docs.length === 0) {
          throw new Error("No results found");
        }
        const bookData = data.docs[0];
        const book = Book.fromJson(bookData);
        return book;
      } else {
        throw new Error("Failed to load media");
      }
    } catch (error) {
      console.error(error);
      throw new Error("Failed to load media");
    }
}