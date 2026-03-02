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

  test('getTypes returns data', () async {
    final service = CarDataService();
    final types = await service.getTypes();
    expect(types, isNotEmpty);
  });

  test('getMakes returns data', () async {
    final service = CarDataService();
    final makes = await service.getMakes();
    expect(makes, isNotEmpty);
  });

  test('getYears returns data', () async {
    final service = CarDataService();
    final years = await service.getYears();
    expect(years, isNotEmpty);
  });
}
