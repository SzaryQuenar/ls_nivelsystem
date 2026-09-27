import '../../models/typ_odcinka.dart';

class OdcinekFormatter {
  static String nazwaTypu(
    TypOdcinka typ,
  ) {
    switch (typ) {
      case TypOdcinka.kanalizacja:
        return 'KANALIZACJA';

      case TypOdcinka.deszczowka:
        return 'DESZCZÓWKA';

      case TypOdcinka.wodociag:
        return 'WODOCIĄG';

      case TypOdcinka.kabel:
        return 'KABEL';

      case TypOdcinka.kraweznik:
        return 'KRAWĘŻNIK';

      case TypOdcinka.inne:
        return 'INNE';
    }
  }
}