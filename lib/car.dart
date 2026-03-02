import 'dart:convert';

class Car {
  final int? id;
  final int? year;
  final String? make;
  final String? model;
  final String? type;

  Car({this.id, this.year, this.make, this.model, this.type});

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      year: map['year'] is int ? map['year'] : int.tryParse(map['year'].toString()),
      make: map['make'] as String?,
      model: map['model'] as String?,
      type: map['type'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'make': make,
      'model': model,
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
