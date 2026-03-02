import 'package:flutter/material.dart';
import 'joke_controller.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final JokeController _controller = JokeController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.fetchJoke();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Acudits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: _controller.isLoading
              ? const CircularProgressIndicator()
              : _controller.error != null
                  ? Text('Error: ${_controller.error}',
                      style: const TextStyle(color: Colors.red))
                  : _controller.joke == null
                      ? const Text('Prem el botó per a un acudit!')
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _controller.joke!.setup,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _controller.joke!.punchline,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.deepPurple),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _controller.fetchJoke,
        icon: const Icon(Icons.refresh),
        label: const Text('Nou acudit'),
      ),
    );
  }
}
