import 'package:flutter/material.dart';
import 'metro_models.dart';
import 'metro_service.dart';

class MetroController extends ChangeNotifier {
  final MetroService _service = MetroService();

  List<MetroLinia> linies = [];
  bool isLoading = false;
  String? error;
  String? codiEstacioActual;

  Future<void> fetchEstacio(String codisEstacions) async {
    isLoading = true;
    error = null;
    linies = [];
    codiEstacioActual = codisEstacions;
    notifyListeners();

    try {
      linies = await _service.getPrevisioEstacio(codisEstacions);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
