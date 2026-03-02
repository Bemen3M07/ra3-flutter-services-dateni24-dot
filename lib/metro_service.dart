import 'dart:convert';
import 'package:http/http.dart' as http;
import 'metro_models.dart';

class MetroService {

  final String appId = 'aa6e9b02';
  final String appKey = '748161505532faea9edebf13ef000d42';
  final String baseUrl = 'https://api.tmb.cat/v1/itransit/metro';


  Future<List<MetroLinia>> getPrevisioEstacio(String codisEstacions) async {
    final uri = Uri.parse(
      '$baseUrl/estacions?estacions=$codisEstacions&app_id=$appId&app_key=$appKey',
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> linies = data['linies'] ?? [];
      return linies.map((l) => MetroLinia.fromMap(l)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('Error d\'autorització: comprova app_id i app_key');
    } else {
      throw Exception('Error carregant dades: ${response.statusCode}');
    }
  }
}
