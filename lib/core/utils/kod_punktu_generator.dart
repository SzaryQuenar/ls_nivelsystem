import '../../models/branza.dart';
import '../../models/typ_punktu.dart';

class KodPunktuGenerator {
  static String prefix(
    Branza branza,
    TypPunktu typ,
  ) {
    switch (typ) {
      case TypPunktu.studnia:
        switch (branza) {
          case Branza.kanalizacjaSanitarna:
            return 'S';

          case Branza.kanalizacjaDeszczowa:
            return 'D';

          default:
            return 'P';
        }

      case TypPunktu.wpust:
        return 'WP';

      case TypPunktu.hydrant:
        return 'HZ';

      case TypPunktu.zasuwa:
        return 'Z';

      case TypPunktu.kraweznik:
        return 'K';

      case TypPunktu.chodnik:
        return 'CH';

      case TypPunktu.punkt:
        return 'P';

      case TypPunktu.inne:
        return 'I';
    }
  }
}