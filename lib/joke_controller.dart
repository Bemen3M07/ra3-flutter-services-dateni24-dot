import 'package:flutter/material.dart';
import 'joke.dart';
import 'joke_service.dart';

class JokeController extends ChangeNotifier {
  final JokeService _service = JokeService();

  Joke? joke;
  bool isLoading = false;
  String? error;

  Future<void> fetchJoke() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      joke = await _service.getRandomJoke();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
