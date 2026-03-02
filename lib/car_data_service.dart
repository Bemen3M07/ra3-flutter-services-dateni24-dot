import 'dart:convert';
import 'package:http/http.dart' as http;
import 'car.dart';

class CarDataService {
  final String apiKey = 'e45d51ce02mshd4e4d6f2062715ep1bb9e7jsnb5f1b684bd95';
  final String baseUrl = 'https://car-data.p.rapidapi.com';

  Future<List<Car>> getCars() async {
    final response = await http.get(
      Uri.parse('$baseUrl/cars'),
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': 'car-data.p.rapidapi.com',
      },
    );
    if (response.statusCode == 200) {
      return carsFromJson(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
