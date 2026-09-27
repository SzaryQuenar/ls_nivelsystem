import 'reper.dart';

class Stanowisko {
  final String numer;
  final Reper reper;
  final double odczytWstecz;
  final double osCelowa;
  final DateTime data;

  Stanowisko({
    required this.numer,
    required this.reper,
    required this.odczytWstecz,
    required this.osCelowa,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'numer': numer,
      'reper': reper.toJson(),
      'odczytWstecz': odczytWstecz,
      'osCelowa': osCelowa,
      'data': data.toIso8601String(),
    };
  }

  factory Stanowisko.fromJson(
    Map<String, dynamic> json,
  ) {
    return Stanowisko(
      numer: json['numer'],
      reper: Reper.fromJson(
        json['reper'],
      ),
      odczytWstecz:
          (json['odczytWstecz'] as num)
              .toDouble(),
      osCelowa:
          (json['osCelowa'] as num)
              .toDouble(),
      data: DateTime.parse(
        json['data'],
      ),
    );
  }
}