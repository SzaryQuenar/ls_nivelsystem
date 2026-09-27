import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../../models/reper.dart';
import 'create_reper_screen.dart';
import '../../core/utils/unit_formatter.dart';

class ReperyScreen extends StatefulWidget {
  final Budowa budowa;
  
  const ReperyScreen({
    super.key,
    required this.budowa,
  });
    
  @override
  State<ReperyScreen> createState() =>
    _ReperyScreenState();
  }

class _ReperyScreenState
    extends State<ReperyScreen> {
  Future<void> _dodajReper() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateReperScreen(
          budowa: widget.budowa,
        ),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final rg =
        widget.budowa.repery
            .where(
              (r) => r.typ == ReperTyp.rg,
            )
            .toList();

    final rr =
        widget.budowa.repery
            .where(
              (r) => r.typ == ReperTyp.rr,
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repery'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: _dodajReper,
            icon: const Icon(Icons.add),
            label: const Text(
              'Dodaj Reper',
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Repery Geodety',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ...rg.map(
            (reper) => Card(
              child: ListTile(
                title: Text(reper.numer),
                subtitle: Text(
                  '${reper.rzedna.toStringAsFixed(3)} m n.p.m.',
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Repery Robocze',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ...rr.map(
            (reper) => Card(
              child: ListTile(
                title: Text(reper.numer),
                subtitle: Text(
                  UnitFormatter.rzedna(
                    reper.rzedna,
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