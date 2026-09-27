import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../models/branza.dart';
import '../../models/pomiar_punktowy.dart';
import 'pomiar_punktowy_details_screen.dart';

class PomiaryPunktoweScreen extends StatefulWidget {
  final Branza branza;

  final List<PomiarPunktowy> pomiary;

  const PomiaryPunktoweScreen({
    super.key,
    required this.branza,
    required this.pomiary,
  });

  @override
  State<PomiaryPunktoweScreen> createState() =>
      _PomiaryPunktoweScreenState();
}

class _PomiaryPunktoweScreenState
    extends State<PomiaryPunktoweScreen> {
  @override
  Widget build(BuildContext context) {
    final pomiaryBranzy =
        widget.pomiary.where(
      (p) => p.branza == widget.branza,
    ).toList();

    pomiaryBranzy.sort(
      (a, b) => a.kod.compareTo(b.kod),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          BranzaFormatter.nazwa(
            widget.branza,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              onPressed: () {
                // TODO:
                // CreatePomiarPunktowyScreen
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Nowy Pomiar Punktowy',
              ),
            ),
          ),

          Expanded(
            child: pomiaryBranzy.isEmpty
                ? const Center(
                    child: Text(
                      'Brak pomiarów',
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        pomiaryBranzy.length,
                    itemBuilder:
                        (context, index) {
                      final pomiar =
                          pomiaryBranzy[
                              index];

                      return Card(
                        margin:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on,
                          ),
                          title: Text(
                            pomiar.kod,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${pomiar.typ.name}\n'
                            'Odczyt: ${pomiar.odczyt.toStringAsFixed(3)}\n'
                            'Rzędna: ${pomiar.rzedna.toStringAsFixed(3)}',
                          ),
                          trailing:
                              const Icon(
                            Icons.chevron_right,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PomiarPunktowyDetailsScreen(
                                  pomiar: pomiar,
                                ),
                              ),
                            );
                          },
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