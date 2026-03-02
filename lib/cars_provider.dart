import 'package:flutter/material.dart';
import 'car.dart';
import 'car_data_service.dart';

class CarsController extends ChangeNotifier {
  final CarDataService _service = CarDataService();

  List<Car> _cars = [];
  bool _isLoading = false;
  String? _error;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cars = await _service.getCars();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
