import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../pomiary_punktowe/pomiary_punktowe_screen.dart';
import '../odcinki/odcinki_screen.dart';

class BranzaDetailsScreen extends StatelessWidget {
  final Branza branza;

  final Budowa budowa;

  const BranzaDetailsScreen({
    super.key,
    required this.branza,
    required this.budowa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BranzaFormatter.nazwa(
            branza,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.location_on,
              ),
              title: const Text(
                'Pomiary Punktowe',
              ),
              subtitle: const Text(
                'Studnie, wpusty, hydranty, zasuwy, krawężniki itd.',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PomiaryPunktoweScreen(
                      branza: branza,
                      pomiary:
                          budowa.pomiaryPunktowe,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.timeline,
              ),
              title: const Text(
                'Odcinki',
              ),
              subtitle: const Text(
                'Odcinki i rury',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.calculate,
              ),
              title: const Text(
                'Kalkulatory',
              ),
              subtitle: const Text(
                'Rzędna ↔ Odczyt, Rury, Spadki',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.history,
              ),
              title: const Text(
                'Historia Branży',
              ),
              subtitle: const Text(
                'Pomiary i odcinki dla wybranej branży',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OdcinkiScreen(
                      budowa: budowa,
                      branza: branza,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}