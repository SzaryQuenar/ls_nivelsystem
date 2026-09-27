import 'package:flutter/material.dart';

import '../../core/utils/branza_colors.dart';
import '../../core/utils/branza_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../odcinki/odcinki_screen.dart';

class NiwelacjaScreen extends StatelessWidget {
  final Budowa budowa;

  const NiwelacjaScreen({
    super.key,
    required this.budowa,
  });

  IconData ikonaBranzy(
    Branza branza,
  ) {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
        return Icons.water_damage;

      case Branza.kanalizacjaDeszczowa:
        return Icons.grass;

      case Branza.wodociag:
        return Icons.water_drop;

      case Branza.drogowa:
        return Icons.add_road;

      case Branza.kabel:
        return Icons.cable;

      case Branza.inne:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Niwelacja',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...Branza.values.map(
            (branza) => Card(
              color: BranzaColors.tlo(
                branza
              ),
              child: ListTile(
                leading: Icon(
                  ikonaBranzy(
                    branza,
                  ),
                  color: BranzaColors.kolor(
                    branza,
                  ),
                  size: 32,
                ),
                title: Text(
                  BranzaFormatter.nazwa(
                    branza,
                  ),
                  style: TextStyle(
                    color: BranzaColors.kolor(
                      branza,
                    ),
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OdcinkiScreen(
                        budowa: budowa,
                        branza: branza,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}