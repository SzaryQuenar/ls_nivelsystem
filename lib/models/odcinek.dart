import 'branza.dart';
import 'rura.dart';
import 'stanowisko.dart';
import 'typ_odcinka.dart';

class Odcinek {
  final Branza branza;
  final String nazwa;
  final TypOdcinka typ;
  final String punktStart;
  final String punktKoniec;
  final double dlugosc;
  final double projektowanySpadek;
  final List<Rura> rury;
  final Stanowisko stanowisko;

  Odcinek({
    required this.branza,
    required this.stanowisko,
    required this.nazwa,
    required this.typ,
    required this.punktStart,
    required this.punktKoniec,
    required this.dlugosc,
    required this.projektowanySpadek,
    List<Rura>? rury,
  }) : rury = rury ?? [];

  Map<String, dynamic> toJson() {
    return {
      'branza': branza.name,
      'stanowisko': stanowisko.toJson(),
      'nazwa': nazwa,
      'typ': typ.name,
      'punktStart': punktStart,
      'punktKoniec': punktKoniec,
      'dlugosc': dlugosc,
      'projektowanySpadek':
          projektowanySpadek,
      'rury':
          rury
              .map(
                (e) => e.toJson(),
              )
              .toList(),
    };
  }

  factory Odcinek.fromJson(
    Map<String, dynamic> json,
  ) {
    return Odcinek(
      branza: Branza.values.firstWhere(
        (e) =>
            e.name ==
            json['branza'],
      ),

      stanowisko:
          Stanowisko.fromJson(
        json['stanowisko'],
      ),

      nazwa: json['nazwa'],

      typ: TypOdcinka.values.firstWhere(
        (e) =>
            e.name ==
            json['typ'],
      ),

      punktStart:
          json['punktStart'],

      punktKoniec:
          json['punktKoniec'],

      dlugosc:
          (json['dlugosc'] as num)
              .toDouble(),

      projektowanySpadek:
          (json['projektowanySpadek']
                  as num)
              .toDouble(),

      rury:
          (json['rury'] as List)
              .map(
                (e) => Rura.fromJson(
                  e,
                ),
              )
              .toList(),
    );
  }
}