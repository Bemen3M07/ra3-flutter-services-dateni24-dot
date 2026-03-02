import 'package:flutter/material.dart';
import 'car_data_service.dart';
import 'car.dart';
import 'joke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JokeScreen(),
    );
  }
}

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final CarDataService _service = CarDataService();
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = _service.getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Car Data'),
      ),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final cars = snapshot.data ?? [];
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    '${car.year ?? '?'}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                title: Text('${car.make} ${car.model}'),
                subtitle: Text('Tipus: ${car.type ?? 'Desconegut'}'),
              );
            },
          );
        },
      ),
    );
  }
}
