import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../../models/stanowisko.dart';
import 'create_pomiar_screen.dart';
import '../../core/utils/unit_formatter.dart';

class PomiaryScreen extends StatelessWidget {
  final Budowa budowa;
  final Stanowisko stanowisko;

  const PomiaryScreen({
    super.key,
    required this.budowa,
    required this.stanowisko,
  });

  @override
  Widget build(BuildContext context) {
    final pomiary = budowa.pomiary
        .where(
          (p) => p.stanowisko == stanowisko,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          stanowisko.numer,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Oś celowa',
              ),
              subtitle: Text(
                UnitFormatter.osCelowa(
                  stanowisko.osCelowa,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () async {
              final result =
                  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                    CreatePomiarScreen(
                  budowa: budowa,
                  stanowisko: stanowisko,
                ),
              ),
            );
              
            if (result == true) {
              (context as Element).markNeedsBuild();
            }
          },
            icon: const Icon(Icons.add),
            label: const Text(
              'Nowy Pomiar',
            ),
          ),

          const SizedBox(height: 20),

          if (pomiary.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Brak pomiarów',
                ),
              ),
            ),

          ...pomiary.map(
            (pomiar) => Card(
              child: ListTile(
                title: Text(
                  pomiar.kodPunktu,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    UnitFormatter.rzedna(
                      pomiar.rzedna,
                    ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}