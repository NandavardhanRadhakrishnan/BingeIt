import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_key.dart';
import 'models.dart';

void main() async {
  String watched = 'interstellar';
  MediaType recommendWhat = MediaType.book;
  var recommended = await recommend(watched, recommendWhat, 5);
  var listOfMedia = recommended.split('|');
  List<dynamic> results = List.empty(growable: true);
  for (var i in listOfMedia) {
    results.add(await findMedia(i, recommendWhat));
  }
  print(results);
}

String helperEnumToString(MediaType mediaType) {
  if (mediaType == MediaType.book) {
    return 'Book';
  }
  if (mediaType == MediaType.movie) {
    return 'Movie';
  } else {
    return 'TV show';
  }
}

Future<String> recommend(String watched, MediaType recommendWhat, int n) async {
  final url = Uri.parse('https://api.openai.com/v1/completions');
  Map<String, String> headers = {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8', 'Authorization': 'Bearer $openAiApiKey'};
  String promptData =
      "give me just the ${helperEnumToString(recommendWhat)} name $n examples in the format ex1|ex2|ex3 ... i recently watched $watched and i liked it recommend a ${helperEnumToString(recommendWhat)} that is similar";

  final data = jsonEncode({"model": "text-davinci-003", "prompt": promptData, "temperature": 0.4, "max_tokens": 64, "top_p": 1, "frequency_penalty": 0, "presence_penalty": 0});
  var response = await http.post(url, headers: headers, body: data);
  // print(response.body);
  if (response.statusCode == 200) {
    var formattedText = jsonDecode(response.body)['choices'][0]['text'].replaceAll('\n', '');
    return (formattedText);
  } else {
    return '';
  }
}

Future<dynamic> findMedia(String query, MediaType mediaType) async {
  if (mediaType == MediaType.book) {
    final baseUrl = 'http://openlibrary.org/search.json';
    final response = await http.get(Uri.parse('$baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // print(data['docs'].first);
      if (data['docs'].isEmpty) {
        throw Exception('No results found');
      }
      var bookData = data['docs'].first;
      if (bookData == null) {
        throw Exception('Failed to load media');
      }
      final Book book = Book.fromJson(bookData);
      return book;
    } else {
      throw Exception('Failed to load media');
    }
  } else {
    final baseUrl = 'https://api.themoviedb.org/3';
    final mediaPath = mediaType == MediaType.movie ? '/movie' : '/tv';
    final response = await http.get(Uri.parse('$baseUrl/search/$mediaPath?api_key=$tmdbApiKey&query=$query'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['success'] == false) {
        throw Exception(data['status_message']);
      }

      if (data['results'].isEmpty) {
        throw Exception('No results found');
      }

      if (mediaType == MediaType.movie) {
        final List<dynamic> results = data['results'];
        final Movie movie = Movie.fromJson(results.first);
        return movie;
      } else {
        final List<dynamic> results = data['results'];
        final TVShow tvShow = TVShow.fromJson(results.first);
        return tvShow;
      }
    } else {
      throw Exception('Failed to load media');
    }
  }
}
