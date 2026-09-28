import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../core/utils/kod_punktu_generator.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../../models/pomiar_punktowy.dart';
import '../../models/stanowisko.dart';
import '../../models/typ_punktu.dart';
import '../../services/persistence_service.dart';

class CreatePomiarPunktowyScreen
    extends StatefulWidget {
  final Budowa budowa;

  final Stanowisko stanowisko;

  const CreatePomiarPunktowyScreen({
    super.key,
    required this.budowa,
    required this.stanowisko,
  });

  @override
  State<CreatePomiarPunktowyScreen>
      createState() =>
          _CreatePomiarPunktowyScreenState();
}

class _CreatePomiarPunktowyScreenState
    extends State<CreatePomiarPunktowyScreen> {
  Branza branza =
      Branza.kanalizacjaDeszczowa;

  TypPunktu typ =
      TypPunktu.studnia;

  final numerController =
      TextEditingController();

  final opisController =
      TextEditingController();

  final odczytController =
      TextEditingController();

  final rzednaController =
      TextEditingController();

  bool trybOdczytNaRzedna = true;

  double wynik = 0;

  String get kod {
    final prefix =
        KodPunktuGenerator.prefix(
      branza,
      typ,
    );

    final numer =
        numerController.text.trim();

    if (numer.isEmpty) {
      return prefix;
    }

    return '$prefix$numer';
  }

  void przelicz() {
    final osCelowa =
        widget.stanowisko.osCelowa;

    if (trybOdczytNaRzedna) {
      final odczyt =
          double.tryParse(
                odczytController.text
                    .replaceAll(',', '.'),
              ) ??
              0;

      wynik = osCelowa - odczyt;
    } else {
      final rzedna =
          double.tryParse(
                rzednaController.text
                    .replaceAll(',', '.'),
              ) ??
              0;

      wynik = osCelowa - rzedna;
    }

    setState(() {});
  }

  Future<void> zapisz() async {
    if (kod.trim().isEmpty) {
      return;
    }

    final odczyt =
        trybOdczytNaRzedna
            ? double.tryParse(
                    odczytController.text
                        .replaceAll(',', '.'),
                  ) ??
                0
            : wynik;

    final rzedna =
        trybOdczytNaRzedna
            ? wynik
            : double.tryParse(
                    rzednaController.text
                        .replaceAll(',', '.'),
                  ) ??
                0;

    widget.budowa
        .pomiaryPunktowe
        .add(
      PomiarPunktowy(
        branza: branza,
        typ: typ,
        kod: kod,
        opis: opisController.text,
        stanowisko: widget.stanowisko,
        odczyt: odczyt,
        rzedna: rzedna,
        data: DateTime.now(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pomiar Punktowy',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Stanowisko',
              ),
              subtitle: Text(
                widget.stanowisko.numer,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              title: const Text(
                'Oś Celowa',
              ),
              subtitle: Text(
                widget.stanowisko
                    .osCelowa
                    .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<
              Branza>(
            initialValue: branza,
            decoration:
                const InputDecoration(
              labelText: 'Branża',
            ),
            items: Branza.values
                .map(
                  (e) =>
                      DropdownMenuItem(
                    value: e,
                    child: Text(
                      BranzaFormatter
                          .nazwa(e),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                branza = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<
              TypPunktu>(
            initialValue: typ,
            decoration:
                const InputDecoration(
              labelText:
                  'Typ punktu',
            ),
            items: TypPunktu.values
                .map(
                  (e) =>
                      DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                typ = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                numerController,
            decoration:
                const InputDecoration(
              labelText: 'Numer',
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              title:
                  const Text('Kod'),
              subtitle: Text(kod),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                opisController,
            decoration:
                const InputDecoration(
              labelText: 'Opis',
            ),
          ),

          const SizedBox(height: 16),

          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text(
                  'ODCZYT → RZĘDNA',
                ),
              ),
              ButtonSegment(
                value: false,
                label: Text(
                  'RZĘDNA → ODCZYT',
                ),
              ),
            ],
            selected: {
              trybOdczytNaRzedna,
            },
            onSelectionChanged:
                (value) {
              setState(() {
                trybOdczytNaRzedna =
                    value.first;
              });

              przelicz();
            },
          ),

          const SizedBox(height: 20),

          if (trybOdczytNaRzedna)
            TextField(
              controller:
                  odczytController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Odczyt [m]',
              ),
              onChanged: (_) =>
                  przelicz(),
            ),

          if (!trybOdczytNaRzedna)
            TextField(
              controller:
                  rzednaController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Rzędna [m n.p.m.]',
              ),
              onChanged: (_) =>
                  przelicz(),
            ),

          const SizedBox(height: 20),

          Card(
            color:
                Colors.green.shade50,
            child: ListTile(
              title: Text(
                trybOdczytNaRzedna
                    ? 'Rzędna'
                    : 'Odczyt',
              ),
              subtitle: Text(
                wynik
                    .toStringAsFixed(3),
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: zapisz,
            icon: const Icon(
              Icons.save,
            ),
            label: const Text(
              'ZAPISZ POMIAR',
            ),
          ),
        ],
      ),
    );
  }
}