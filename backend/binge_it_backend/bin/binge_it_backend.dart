import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_key.dart';

void main() async {
  String a = await recommend('james bond', 'movie');
  print(a);
}

Future<String> recommend(String watched, String recommendWhat) async {
  var url = Uri.parse('https://api.openai.com/v1/completions');
  Map<String, String> headers = {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8', 'Authorization': 'Bearer $openAiApiKey'};
  String promptData = "give me just the $recommendWhat name ... i recently watched $watched and i liked it recommend a $recommendWhat that is similar";

  final data = jsonEncode({"model": "text-davinci-003", "prompt": promptData, "temperature": 0.4, "max_tokens": 64, "top_p": 1, "frequency_penalty": 0, "presence_penalty": 0});
  var response = await http.post(url, headers: headers, body: data);
  print(response.body);
  var formattedText = jsonDecode(response.body)['choices'][0]['text'].replaceAll('\n', '');
  return (formattedText);
}
