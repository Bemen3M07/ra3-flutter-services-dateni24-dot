// Model per a un tren que arribarà
class MetroTren {
  final String codiServei;
  final int tempsArribada; // timestamp en ms

  MetroTren({required this.codiServei, required this.tempsArribada});

 
  int get minutsRestants {
    final ara = DateTime.now().millisecondsSinceEpoch;
    return ((tempsArribada - ara) / 60000).round();
  }

  factory MetroTren.fromMap(Map<String, dynamic> map) {
    return MetroTren(
      codiServei: map['codi_servei']?.toString() ?? '',
      tempsArribada: map['temps_arribada'] as int? ?? 0,
    );
  }
}


class MetroTrajecte {
  final String nomLinia;
  final String codiTrajecte;
  final String destiTrajecte;
  final String colorLinia;
  final List<MetroTren> propersTrens;

  MetroTrajecte({
    required this.nomLinia,
    required this.codiTrajecte,
    required this.destiTrajecte,
    required this.colorLinia,
    required this.propersTrens,
  });

  factory MetroTrajecte.fromMap(Map<String, dynamic> map) {
    final trens = (map['propers_trens'] as List<dynamic>? ?? [])
        .map((t) => MetroTren.fromMap(t))
        .toList();
    return MetroTrajecte(
      nomLinia: map['nom_linia']?.toString() ?? '',
      codiTrajecte: map['codi_trajecte']?.toString() ?? '',
      destiTrajecte: map['desti_trajecte']?.toString() ?? '',
      colorLinia: map['color_linia']?.toString() ?? 'AAAAAA',
      propersTrens: trens,
    );
  }
}

// Model per a una via/sentit dins d'una estació
class MetroVia {
  final int codVia;
  final int idSentit; // 1=Anada, 2=Tornada
  final int codiEstacio;
  final List<MetroTrajecte> liniesTrajectes;

  MetroVia({
    required this.codVia,
    required this.idSentit,
    required this.codiEstacio,
    required this.liniesTrajectes,
  });

  String get sentit => idSentit == 1 ? 'Anada' : 'Tornada';

  factory MetroVia.fromMap(Map<String, dynamic> map) {
    final trajectes = (map['linies_trajectes'] as List<dynamic>? ?? [])
        .map((t) => MetroTrajecte.fromMap(t))
        .toList();
    return MetroVia(
      codVia: map['codi_via'] as int? ?? 0,
      idSentit: map['id_sentit'] as int? ?? 0,
      codiEstacio: map['codi_estacio'] as int? ?? 0,
      liniesTrajectes: trajectes,
    );
  }
}

// Model per a una línia de metro
class MetroLinia {
  final int codiLinia;
  final String nomLinia;
  final String colorLinia;
  final List<MetroVia> estacions;

  MetroLinia({
    required this.codiLinia,
    required this.nomLinia,
    required this.colorLinia,
    required this.estacions,
  });

  factory MetroLinia.fromMap(Map<String, dynamic> map) {
    final estacions = (map['estacions'] as List<dynamic>? ?? [])
        .map((e) => MetroVia.fromMap(e))
        .toList();
    return MetroLinia(
      codiLinia: map['codi_linia'] as int? ?? 0,
      nomLinia: map['nom_linia']?.toString() ?? '',
      colorLinia: map['color_linia']?.toString() ?? 'AAAAAA',
      estacions: estacions,
    );
  }
}
