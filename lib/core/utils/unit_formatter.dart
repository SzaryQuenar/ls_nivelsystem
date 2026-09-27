class UnitFormatter {
  /// Rzędne
  static String rzedna(
    double value,
  ) {
    return '${value.toStringAsFixed(3)} m n.p.m.';
  }

  /// Oś celowa
  static String osCelowa(
    double value,
  ) {
    return '${value.toStringAsFixed(3)} m n.p.m.';
  }

  /// Odczyty z łaty
  static String odczyt(
    double value,
  ) {
    return '${value.toStringAsFixed(3)} m';
  }

  /// Długości
  static String dlugosc(
    double value,
  ) {
    return '${value.toStringAsFixed(2)} m';
  }

  /// Spadki
  static String spadek(
    double value,
  ) {
    return '${value.toStringAsFixed(2)} %';
  }

  /// Kodowany zapis liczbowy bez jednostki
  static String liczba3(double value) {
    return value.toStringAsFixed(3);
  }

}