import 'package:flutter_test/flutter_test.dart';
import '../lib/car_data_service.dart';
import '../lib/car.dart';

void main() {
  test('getCars returns Car objects', () async {
    final service = CarDataService();
    final cars = await service.getCars();
    expect(cars, isNotEmpty);
    expect(cars.first, isA<Car>());
  });
}
