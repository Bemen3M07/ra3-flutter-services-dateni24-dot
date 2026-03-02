class Joke {
  final int id;
  final String setup;
  final String punchline;

  Joke({required this.id, required this.setup, required this.punchline});

  factory Joke.fromMap(Map<String, dynamic> map) {
    return Joke(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()) ?? 0,
      setup: map['setup'] as String? ?? '',
      punchline: map['punchline'] as String? ?? '',
    );
  }
}
