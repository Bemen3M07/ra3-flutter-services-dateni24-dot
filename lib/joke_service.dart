import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'joke.dart';

class JokeService {
  final String _url = 'https://api.sampleapis.com/jokes/goodJokes';

  Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      final random = Random();
      final map = list[random.nextInt(list.length)];
      return Joke.fromMap(map);
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
