import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import 'create_stanowisko_screen.dart';
import '../../core/utils/unit_formatter.dart';
import '../pomiary/pomiary_screen.dart';

class StanowiskaScreen extends StatefulWidget {
  final Budowa budowa;

  const StanowiskaScreen({
    super.key,
    required this.budowa,
  });

  @override
  State<StanowiskaScreen> createState() =>
      _StanowiskaScreenState();
}

class _StanowiskaScreenState
    extends State<StanowiskaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stanowiska',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () async {
              final result =
                  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CreateStanowiskoScreen(
                    budowa: widget.budowa,
                  ),
                ),
              );

              if (result == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'Nowe Stanowisko',
            ),
          ),

          const SizedBox(height: 24),

          if (widget.budowa.stanowiska.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Brak stanowisk',
                ),
              ),
            ),

          ...widget.budowa.stanowiska.map(
            (stanowisko) => Card(
              child: ListTile(
                leading: const Icon(
                  Icons.straighten,
                ),
                title: Text(
                  stanowisko.numer,
                ),
                subtitle: Text(
                  'Reper: ${stanowisko.reper.numer}\n'
                  'Oś celowa: ${UnitFormatter.osCelowa(stanowisko.osCelowa)}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PomiaryScreen(
                        budowa: widget.budowa,
                        stanowisko: stanowisko,
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