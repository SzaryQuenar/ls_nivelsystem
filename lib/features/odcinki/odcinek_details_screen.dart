import 'package:flutter/material.dart';

import '../../core/utils/odcinek_formatter.dart';
import '../../core/utils/unit_formatter.dart';
import '../../models/odcinek.dart';
import '../rury/rury_screen.dart';
import 'projektowany_odczyt_screen.dart';

class OdcinekDetailsScreen extends StatelessWidget {
  final Odcinek odcinek;

  const OdcinekDetailsScreen({
    super.key,
    required this.odcinek,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          odcinek.nazwa,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Typ',
              ),
              subtitle: Text(
                OdcinekFormatter.nazwaTypu(
                  odcinek.typ,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Punkty',
              ),
              subtitle: Text(
                '${odcinek.punktStart} → ${odcinek.punktKoniec}',
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Długość',
              ),
              subtitle: Text(
                UnitFormatter.dlugosc(
                  odcinek.dlugosc,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Projektowany spadek',
              ),
              subtitle: Text(
                UnitFormatter.spadek(
                  odcinek.projektowanySpadek,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProjektowanyOdczytScreen(
                    odcinek: odcinek,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.calculate,
            ),
            label: const Text(
              'ODCZYT PROJEKTOWANY',
            ),
          ),

          const SizedBox(height: 12),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RuryScreen(
                    odcinek: odcinek,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.linear_scale,
            ),
            label: const Text(
              'RURY',
            ),
          ),
        ],
      ),
    );
  }
}