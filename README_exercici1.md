# Exercici 1: Accés a un servei REST des de Flutter

## Resum
Aquest exercici mostra com consumir una API REST (https://car-data.p.rapidapi.com) des d'una aplicació Flutter, modelar la resposta amb una classe Dart, i provar-ho amb una prova unitaria.

---

## 1. Afegir dependències
Al fitxer `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```
Després executa:
```bash
flutter pub get
```

---

## 2. Crear el model Car
Fitxer: `lib/car.dart`
```dart
class Car {
  final String? make;
  final String? model;
  final int? year;
  final String? type;

  Car({this.make, this.model, this.year, this.type});

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      make: map['make'] as String?,
      model: map['model'] as String?,
      year: map['year'] is int ? map['year'] : int.tryParse(map['year'].toString()),
      type: map['type'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'type': type,
    };
  }
}

List<Car> carsFromJson(String jsonString) {
  final List<dynamic> decoded = jsonDecode(jsonString);
  return decoded.map((item) => Car.fromMap(item)).toList();
}

String carsToJson(List<Car> cars) {
  final List<Map<String, dynamic>> mapped = cars.map((car) => car.toMap()).toList();
  return jsonEncode(mapped);
}
```

---

## 3. Crear el servei per consumir la API
Fitxer: `lib/car_data_service.dart`
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ra3-flutter-services-dateni24-dot/car.dart';

class CarDataService {
  final String apiKey = 'TU_API_KEY_RAPIDAPI'; // Reemplaça per la teva API Key
  final String baseUrl = 'https://car-data.p.rapidapi.com';

  Future<List<Car>> getCars() async {
    final response = await http.get(
      Uri.parse('$baseUrl/cars'),
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'car-data.p.rapidapi.com',
      },
    );
    if (response.statusCode == 200) {
      return carsFromJson(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
```

---

## 4. Prova unitaria
Fitxer: `test/car_data_service_test.dart`
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ra3-flutter-services-dateni24-dot/car_data_service.dart';
import 'package:ra3-flutter-services-dateni24-dot/car.dart';

void main() {
  test('getCars returns Car objects', () async {
    final service = CarDataService();
    final cars = await service.getCars();
    expect(cars, isNotEmpty);
    expect(cars.first, isA<Car>());
  });
}
```

---

## 5. Permís d'internet per Android
Afegeix al fitxer `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

## 6. Provar la API manualment amb Postman

### Passos:
1. Instal·la Postman (o el plugin de VS Code).
2. Crea una nova petició GET a:
   ```
   https://car-data.p.rapidapi.com/cars
   ```
3. Afegeix els headers:
   - `x-rapidapi-host`: `car-data.p.rapidapi.com`
   - `x-rapidapi-key`: (la teva RapidAPI Key)
4. Fes clic a "Send".

### Resultat:
- Rebràs una resposta JSON amb dades de cotxes.
- Status: 200 OK.
- Pots veure el format del JSON i utilitzar-lo per modelar la classe Car.

#### Exemple de resposta:
```json
[
  {"id":9582,"year":2008,"make":"Buick","model":"Enclave","type":"SUV"},
  {"id":9583,"year":2006,"make":"MINI","model":"Convertible","type":"Convertible"},
  ...
]
```

### Captura de pantalla recomanada:
Inclou una captura de la configuració i la resposta en Postman per documentar el procés.

---

## 7. Execució de la prova
Executa:
```bash
flutter test test/car_data_service_test.dart
```

---

## 8. Resultat esperat
- La prova ha de passar i mostrar que es recuperen dades correctament de l'API.
- El model Car permet convertir entre JSON i objectes Dart fàcilment.

---

## 9. Github
- Puja tot el codi i fitxers creats al teu repositori.

---

## 10. Notes
- Recorda substituir la teva RapidAPI Key.
- Pots ampliar el servei per a altres endpoints (types, makes, years) seguint el mateix patró.
