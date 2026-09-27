import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/branza_formatter.dart';
import '../../models/pomiar_punktowy.dart';

class PomiarPunktowyDetailsScreen
    extends StatelessWidget {
  final PomiarPunktowy pomiar;

  const PomiarPunktowyDetailsScreen({
    super.key,
    required this.pomiar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pomiar.kod,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Kod punktu',
              ),
              subtitle: Text(
                pomiar.kod,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Branża',
              ),
              subtitle: Text(
                BranzaFormatter.nazwa(
                  pomiar.branza,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Typ punktu',
              ),
              subtitle: Text(
                pomiar.typ.name,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Opis',
              ),
              subtitle: Text(
                pomiar.opis.isEmpty
                    ? '-'
                    : pomiar.opis,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Stanowisko',
              ),
              subtitle: Text(
                pomiar.stanowisko.numer,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.straighten,
              ),
              title: const Text(
                'Odczyt',
              ),
              subtitle: Text(
                pomiar.odczyt
                    .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.height,
              ),
              title: const Text(
                'Rzędna',
              ),
              subtitle: Text(
                pomiar.rzedna
                    .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Data',
              ),
              subtitle: Text(
                DateFormat(
                  'dd.MM.yyyy HH:mm',
                ).format(
                  pomiar.data,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}