import 'package:flutter/material.dart';

import '../../models/branza.dart';

class BranzaColors {
  static Color kolor(
    Branza branza,
  ) {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
        return const Color(
          0xFF5D4037,
        );

      case Branza.kanalizacjaDeszczowa:
        return Colors.green;

      case Branza.wodociag:
        return Colors.blue;

      case Branza.drogowa:
        return Colors.orange;

      case Branza.kabel:
        return Colors.deepPurple;

      case Branza.inne:
        return Colors.grey;
    }
  }

  static Color tlo(
    Branza branza,
  ) {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
        return const Color(0xFF3E2723);

      case Branza.kanalizacjaDeszczowa:
        return const Color(0xFF1B5E20);

      case Branza.wodociag:
        return const Color(0xFF0D47A1);

      case Branza.drogowa:
        return const Color(0xFFE65100);

      case Branza.kabel:
        return const Color(0xFF4A148C);

      case Branza.inne:
        return const Color(0xFF424242);
    }
  }
}