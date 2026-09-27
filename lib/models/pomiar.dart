import 'stanowisko.dart';

class Pomiar {
  final String kodPunktu;

  final String opis;

  final Stanowisko stanowisko;

  final double odczyt;

  final double rzedna;

  final DateTime data;

  final String? odcinek;

  Pomiar({
    required this.kodPunktu,
    required this.opis,
    required this.stanowisko,
    required this.odczyt,
    required this.rzedna,
    required this.data,
    this.odcinek,
  });
}