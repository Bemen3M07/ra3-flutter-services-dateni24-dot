import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cars_provider.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega les dades quan s'inicia la pantalla
    Future.microtask(
      () => context.read<CarsController>().fetchCars(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CarsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Car Data'),
      ),
      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          if (provider.cars.isEmpty) {
            return const Center(child: Text('No hi ha cotxes'));
          }
          return ListView.builder(
            itemCount: provider.cars.length,
            itemBuilder: (context, index) {
              final car = provider.cars[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${car.year ?? '?'}')),
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
