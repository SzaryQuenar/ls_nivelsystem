import 'odcinek.dart';
import 'pomiar.dart';
import 'pomiar_punktowy.dart';
import 'reper.dart';
import 'stanowisko.dart';

class Budowa {
  final String numerBudowy;
  final String nazwa;
  final String miejscowosc;
  final String inwestor;
  final String opis;

  final List<Reper> repery;

  final List<Stanowisko>
      stanowiska;

  final List<Pomiar> pomiary;

  final List<PomiarPunktowy>
      pomiaryPunktowe;

  final List<Odcinek> odcinki;

  Budowa({
    required this.numerBudowy,
    required this.nazwa,
    required this.miejscowosc,
    required this.inwestor,
    required this.opis,
    List<Reper>? repery,
    List<Stanowisko>? stanowiska,
    List<Pomiar>? pomiary,
    List<PomiarPunktowy>?
        pomiaryPunktowe,
    List<Odcinek>? odcinki,
  }) : repery = repery ?? [],
       stanowiska =
           stanowiska ?? [],
       pomiary = pomiary ?? [],
       pomiaryPunktowe =
           pomiaryPunktowe ?? [],
       odcinki = odcinki ?? [];

  Map<String, dynamic> toJson() {
    return {
      'numerBudowy': numerBudowy,
      'nazwa': nazwa,
      'miejscowosc':
          miejscowosc,
      'inwestor': inwestor,
      'opis': opis,

      'repery':
          repery
              .map(
                (e) => e.toJson(),
              )
              .toList(),

      'stanowiska':
          stanowiska
              .map(
                (e) => e.toJson(),
              )
              .toList(),

      'pomiaryPunktowe':
          pomiaryPunktowe
              .map(
                (e) => e.toJson(),
              )
              .toList(),

      'odcinki':
          odcinki
              .map(
                (e) => e.toJson(),
              )
              .toList(),
    };
  }

  factory Budowa.fromJson(
    Map<String, dynamic> json,
  ) {
    return Budowa(
      numerBudowy:
          json['numerBudowy'],

      nazwa: json['nazwa'],

      miejscowosc:
          json['miejscowosc'],

      inwestor:
          json['inwestor'],

      opis: json['opis'],

      repery:
          (json['repery'] as List)
              .map(
                (e) => Reper.fromJson(
                  e,
                ),
              )
              .toList(),

      stanowiska:
          (json['stanowiska']
                  as List)
              .map(
                (e) =>
                    Stanowisko
                        .fromJson(
                  e,
                ),
              )
              .toList(),

      pomiaryPunktowe:
          (json['pomiaryPunktowe']
                  as List)
              .map(
                (e) =>
                    PomiarPunktowy
                        .fromJson(
                  e,
                ),
              )
              .toList(),

      odcinki:
          (json['odcinki'] as List)
              .map(
                (e) =>
                    Odcinek.fromJson(
                  e,
                ),
              )
              .toList(),
    );
  }
}