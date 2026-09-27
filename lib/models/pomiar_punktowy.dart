import 'branza.dart';
import 'typ_punktu.dart';
import 'stanowisko.dart';

class PomiarPunktowy {
  final Branza branza;
  final TypPunktu typ;
  final String kod;
  final String opis;
  final Stanowisko stanowisko;
  final double odczyt;
  final double rzedna;
  final DateTime data;

  PomiarPunktowy({
    required this.branza,
    required this.typ,
    required this.kod,
    required this.opis,
    required this.stanowisko,
    required this.odczyt,
    required this.rzedna,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'branza': branza.name,
      'typ': typ.name,
      'kod': kod,
      'opis': opis,
      'stanowisko':
          stanowisko.toJson(),
      'odczyt': odczyt,
      'rzedna': rzedna,
      'data':
          data.toIso8601String(),
    };
  }

  factory PomiarPunktowy.fromJson(
    Map<String, dynamic> json,
  ) {
    return PomiarPunktowy(
      branza: Branza.values.firstWhere(
        (e) =>
            e.name ==
            json['branza'],
      ),

      typ: TypPunktu.values.firstWhere(
        (e) =>
            e.name ==
            json['typ'],
      ),

      kod: json['kod'],

      opis: json['opis'] ?? '',

      stanowisko:
          Stanowisko.fromJson(
        json['stanowisko'],
      ),

      odczyt:
          (json['odczyt'] as num)
              .toDouble(),

      rzedna:
          (json['rzedna'] as num)
              .toDouble(),

      data: DateTime.parse(
        json['data'],
      ),
    );
  }
}