import 'package:flutter/material.dart';

import '../../models/odcinek.dart';
import '../../models/rura.dart';
import 'create_rura_screen.dart';
import 'rura_details_screen.dart';

class RuryScreen extends StatefulWidget {
  final Odcinek odcinek;

  const RuryScreen({
    super.key,
    required this.odcinek,
  });

  @override
  State<RuryScreen> createState() =>
      _RuryScreenState();
}

class _RuryScreenState
    extends State<RuryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rury - ${widget.odcinek.nazwa}',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Początek odcinka',
              ),
              subtitle: Text(
                widget.odcinek.punktStart,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Koniec odcinka',
              ),
              subtitle: Text(
                widget.odcinek.punktKoniec,
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
                '${widget.odcinek.projektowanySpadek.toStringAsFixed(2)} %',
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
                      CreateRuraScreen(
                    odcinek: widget.odcinek,
                  ),
                ),
              );

              if (result == true) {
                setState(() {});
              }
            },
            icon: const Icon(
              Icons.add,
            ),
            label: const Text(
              'NOWA RURA',
            ),
          ),

          const SizedBox(height: 24),

          if (widget.odcinek.rury.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'Brak rur na odcinku',
                ),
              ),
            ),

          ...widget.odcinek.rury.map(
            (Rura rura) => Card(
              child: ListTile(
                leading: const Icon(
                  Icons.linear_scale,
                ),
                title: Text(
                  rura.nazwa,
                ),
                subtitle: Text(
                  'Długość: ${rura.dlugosc.toStringAsFixed(2)} m\n'
                  'Projektowany spadek: ${rura.projektowanySpadek.toStringAsFixed(2)} %',
                ),
                trailing: rura.spadekRzeczywisty !=
                        null
                    ? Text(
                        '${rura.spadekRzeczywisty!.toStringAsFixed(2)} %',
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RuraDetailsScreen(
                        rura: rura,
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