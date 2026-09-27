class Rura {
  final String nazwa;

  final double dlugosc;

  final double projektowanySpadek;

  final double? odczytPoczatek;

  final double? odczytKoniec;

  final DateTime data;

  Rura({
    required this.nazwa,
    required this.dlugosc,
    required this.projektowanySpadek,
    this.odczytPoczatek,
    this.odczytKoniec,
    required this.data,
  });

  double? get spadekRzeczywisty {
    if (odczytPoczatek == null ||
        odczytKoniec == null ||
        dlugosc <= 0) {
      return null;
    }

    return ((odczytKoniec! -
                odczytPoczatek!) /
            dlugosc) *
        100;
  }

  double? get odchylkaSpadku {
    if (spadekRzeczywisty == null) {
      return null;
    }

    return spadekRzeczywisty! -
        projektowanySpadek;
  }

  Map<String, dynamic> toJson() {
    return {
      'nazwa': nazwa,
      'dlugosc': dlugosc,
      'projektowanySpadek':
          projektowanySpadek,
      'odczytPoczatek':
          odczytPoczatek,
      'odczytKoniec':
          odczytKoniec,
      'data': data.toIso8601String(),
    };
  }

  factory Rura.fromJson(
    Map<String, dynamic> json,
  ) {
    return Rura(
      nazwa: json['nazwa'],
      dlugosc:
          (json['dlugosc'] as num)
              .toDouble(),
      projektowanySpadek:
          (json['projektowanySpadek']
                  as num)
              .toDouble(),
      odczytPoczatek:
          json['odczytPoczatek'] ==
                  null
              ? null
              : (json['odczytPoczatek']
                      as num)
                  .toDouble(),
      odczytKoniec:
          json['odczytKoniec'] ==
                  null
              ? null
              : (json['odczytKoniec']
                      as num)
                  .toDouble(),
      data: DateTime.parse(
        json['data'],
      ),
    );
  }
}