import 'package:flutter/material.dart';
import 'metro_controller.dart';
import 'metro_models.dart';

class MetroScreen extends StatefulWidget {
  const MetroScreen({super.key});

  @override
  State<MetroScreen> createState() => _MetroScreenState();
}

class _MetroScreenState extends State<MetroScreen> {
  final MetroController _controller = MetroController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  Color _hexColor(String hex) {
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003189),
        foregroundColor: Colors.white,
        title: const Text('Metro Barcelona - Temps de pas'),
      ),
      body: Column(
        children: [
          // Cercador d'estació
          Container(
            color: const Color(0xFF003189),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: 'Introdueix codi estació (ex: 122)',
                      hintStyle: const TextStyle(color: Colors.white60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final codi = _textController.text.trim();
                    if (codi.isNotEmpty) {
                      _controller.fetchEstacio(codi);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF003189),
                  ),
                  child: const Text('Consultar'),
                ),
              ],
            ),
          ),

          // Contingut
          Expanded(
            child: Builder(
              builder: (_) {
                if (_controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_controller.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Error: ${_controller.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                if (_controller.linies.isEmpty) {
                  return const Center(
                    child: Text(
                      'Introdueix un codi d\'estació per veure els propers trens.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _controller.linies.length,
                  itemBuilder: (context, i) {
                    final linia = _controller.linies[i];
                    final color = _hexColor(linia.colorLinia);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: color, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Capçalera de la línia
                          Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  linia.nomLinia,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Vies i trajectes
                          ...linia.estacions.map((via) => _buildVia(via, color)),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVia(MetroVia via, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Via ${via.codVia} — ${via.sentit}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          ...via.liniesTrajectes.map((t) => _buildTrajecte(t)),
        ],
      ),
    );
  }

  Widget _buildTrajecte(MetroTrajecte trajecte) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '→ ${trajecte.destiTrajecte}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          if (trajecte.propersTrens.isEmpty)
            const Text('  No hi ha trens disponibles',
                style: TextStyle(color: Colors.grey))
          else
            Wrap(
              spacing: 8,
              children: trajecte.propersTrens.map((tren) {
                final mins = tren.minutsRestants;
                return Chip(
                  label: Text(
                    mins <= 0 ? 'Ara' : '$mins min',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: mins <= 1 ? Colors.red : Colors.green[700],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
