import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../../models/reper.dart';
import '../../models/stanowisko.dart';
import '../../core/utils/unit_formatter.dart';
import '../../services/persistence_service.dart';
import '../../widgets/geo_numeric_keyboard.dart';

class CreateStanowiskoScreen extends StatefulWidget {
  final Budowa budowa;

  const CreateStanowiskoScreen({
    super.key,
    required this.budowa,
  });

  @override
  State<CreateStanowiskoScreen> createState() =>
      _CreateStanowiskoScreenState();
}

class _CreateStanowiskoScreenState
    extends State<CreateStanowiskoScreen> {
  Reper? selectedReper;

  final odczytWsteczController =
      TextEditingController();

  double osCelowa = 0;

  bool pokazKlawiature = false;

  @override
  void initState() {
    super.initState();

    if (widget.budowa.repery.isNotEmpty) {
      selectedReper =
          widget.budowa.repery.first;
    }
  }

  @override
  void dispose() {
    odczytWsteczController.dispose();
    super.dispose();
  }

  void pokazBlad(
    String komunikat,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(komunikat),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool walidujOdczytWstecz() {
    final odczyt = double.tryParse(
      odczytWsteczController.text
          .replaceAll(',', '.'),
    );

    if (odczyt == null) {
      pokazBlad(
        'Podaj poprawny odczyt wstecz',
      );
      return false;
    }

    if (odczyt <= 0) {
      pokazBlad(
        'Odczyt musi być większy od 0',
      );
      return false;
    }

    if (odczyt > 5) {
      pokazBlad(
        'Odczyt wygląda na nieprawidłowy',
      );
      return false;
    }

    return true;
  }

  void przelicz() {
    if (selectedReper == null) {
      return;
    }

    final odczyt = double.tryParse(
          odczytWsteczController.text
              .replaceAll(',', '.'),
        ) ??
        0;

    setState(() {
      osCelowa =
          selectedReper!.rzedna +
              odczyt;
    });
  }

  String nextStanowiskoNumber() {
    return 'S${widget.budowa.stanowiska.length + 1}';
  }

  Future<void> zapisz() async {
    if (!walidujOdczytWstecz()) {
      return;
    }

    final odczyt = double.parse(
      odczytWsteczController.text
          .replaceAll(',', '.'),
    );

    widget.budowa.stanowiska.add(
      Stanowisko(
        numer: nextStanowiskoNumber(),
        reper: selectedReper!,
        odczytWstecz: odczyt,
        osCelowa: osCelowa,
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
          'Nowe Stanowisko',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Reper>(
            initialValue: selectedReper,
            decoration:
                const InputDecoration(
              labelText: 'Reper',
            ),
            items: widget.budowa.repery
                .map(
                  (reper) =>
                      DropdownMenuItem(
                    value: reper,
                    child: Text(
                      '${reper.numer} (${UnitFormatter.rzedna(reper.rzedna)})',
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedReper = value;
              });

              przelicz();
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                odczytWsteczController,
            readOnly: true,
            showCursor: true,
            onTap: () {
              setState(() {
                pokazKlawiature =
                    true;
              });
            },
            decoration:
                const InputDecoration(
              labelText:
                  'Odczyt wstecz [m]',
              suffixIcon: Icon(
                Icons.calculate,
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (pokazKlawiature)
            GeoNumericKeyboard(
              controller:
                  odczytWsteczController,
              onDone: () {
                przelicz();

                setState(() {
                  pokazKlawiature =
                      false;
                });
              },
            ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              title: const Text(
                'Oś celowa',
              ),
              subtitle: Text(
                UnitFormatter.osCelowa(
                  osCelowa,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: zapisz,
            child: Text(
              'Utwórz ${nextStanowiskoNumber()}',
            ),
          ),
        ],
      ),
    );
  }
}