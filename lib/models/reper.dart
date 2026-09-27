enum ReperTyp {
  rg,
  rr,
}

class Reper {
  final String numer;
  final ReperTyp typ;
  final double rzedna;
  final String opis;

  Reper({
    required this.numer,
    required this.typ,
    required this.rzedna,
    required this.opis,
  });

  Map<String, dynamic> toJson() {
    return {
      'numer': numer,
      'typ': typ.name,
      'rzedna': rzedna,
      'opis': opis,
    };
  }

  factory Reper.fromJson(
    Map<String, dynamic> json,
  ) {
    return Reper(
      numer: json['numer'],
      typ: ReperTyp.values.firstWhere(
        (e) => e.name == json['typ'],
      ),
      rzedna: (json['rzedna'] as num)
          .toDouble(),
      opis: json['opis'] ?? '',
    );
  }
}