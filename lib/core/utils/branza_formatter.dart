import '../../models/branza.dart';

class BranzaFormatter {
  static String nazwa(
    Branza branza,
  ) {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
        return 'KANALIZACJA SANITARNA';

      case Branza.kanalizacjaDeszczowa:
        return 'KANALIZACJA DESZCZOWA';

      case Branza.wodociag:
        return 'WODOCIĄG';

      case Branza.kabel:
        return 'KABEL';

      case Branza.drogowa:
        return 'DROGOWA';

      case Branza.inne:
        return 'INNE';
    }
  }
}