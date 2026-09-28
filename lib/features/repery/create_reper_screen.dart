import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../../models/reper.dart';
import '../../services/persistence_service.dart';

class CreateReperScreen extends StatefulWidget {
  final Budowa budowa;

  const CreateReperScreen({
    super.key,
    required this.budowa,
  });

  @override
  State<CreateReperScreen> createState() =>
      _CreateReperScreenState();
}

class _CreateReperScreenState
    extends State<CreateReperScreen> {
  final rzednaController =
      TextEditingController();

  final opisController =
      TextEditingController();

  ReperTyp typ = ReperTyp.rg;

  String getNextNumber() {
  final prefix =
      typ == ReperTyp.rg ? 'RG' : 'RR';

  int maxNumer = 0;

  for (final reper in widget.budowa.repery) {
    if (reper.typ != typ) continue;

    final match =
        RegExp(r'(\d+)$')
            .firstMatch(reper.numer);

    if (match == null) continue;

    final numer =
        int.tryParse(match.group(1)!) ?? 0;

    if (numer > maxNumer) {
      maxNumer = numer;
    }
  }

  return '$prefix${maxNumer + 1}';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nowy Reper'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Numer repera'),
              subtitle: Text(
                getNextNumber(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<ReperTyp>(
            initialValue: typ,
            decoration: const InputDecoration(
              labelText: 'Typ repera',
            ),
            items: const [
              DropdownMenuItem(
                value: ReperTyp.rg,
                child: Text(
                  'Reper Geodety',
                ),
              ),
              DropdownMenuItem(
                value: ReperTyp.rr,
                child: Text(
                  'Reper Roboczy',
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                typ = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: rzednaController,
            keyboardType:
                TextInputType.number,
            decoration:
                const InputDecoration(
              labelText: 'Rzędna [m n.p.m.]',
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: opisController,
            decoration:
                const InputDecoration(
              labelText: 'Opis',
            ),
          ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: () async {
              widget.budowa.repery.add(
                Reper(
                  numer: getNextNumber(),
                  typ: typ,
                  rzedna:
                      double.tryParse(
                            rzednaController.text
                                .replaceAll(',', '.'),
                          ) ??
                          0,
                  opis: opisController.text,
                ),
              );

              await PersistenceService.save();

              if (!context.mounted) {
                return;
              }

              Navigator.pop(
                context,
                true,
              );
            },
            child: const Text(
              'Zapisz',
            ),
          ),
        ],
      ),
    );
  }
}