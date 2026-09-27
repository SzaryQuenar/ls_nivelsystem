import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/rura.dart';

class RuraDetailsScreen extends StatelessWidget {
  final Rura rura;

  const RuraDetailsScreen({
    super.key,
    required this.rura,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          rura.nazwa,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Nazwa rury',
              ),
              subtitle: Text(
                rura.nazwa,
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
                '${rura.dlugosc.toStringAsFixed(2)} m',
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
                '${rura.projektowanySpadek.toStringAsFixed(3)} %',
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Odczyt początkowy',
              ),
              subtitle: Text(
                rura.odczytPoczatek == null
                    ? '-'
                    : rura.odczytPoczatek!
                        .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Odczyt końcowy',
              ),
              subtitle: Text(
                rura.odczytKoniec == null
                    ? '-'
                    : rura.odczytKoniec!
                        .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (rura.spadekRzeczywisty != null)
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.trending_down,
                ),
                title: const Text(
                  'Spadek rzeczywisty',
                ),
                subtitle: Text(
                  '${rura.spadekRzeczywisty!.toStringAsFixed(3)} %',
                ),
              ),
            ),

          const SizedBox(height: 12),

          if (rura.odchylkaSpadku != null)
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.compare_arrows,
                ),
                title: const Text(
                  'Odchyłka od projektu',
                ),
                subtitle: Text(
                  '${rura.odchylkaSpadku!.toStringAsFixed(3)} %',
                ),
              ),
            ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Data pomiaru',
              ),
              subtitle: Text(
                DateFormat(
                  'dd.MM.yyyy HH:mm',
                ).format(
                  rura.data,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}