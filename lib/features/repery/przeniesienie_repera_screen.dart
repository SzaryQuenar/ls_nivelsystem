import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../../models/reper.dart';
import '../../core/utils/unit_formatter.dart';
import '../../widgets/geo_numeric_keyboard.dart';

class PrzeniesienieReperaScreen
    extends StatefulWidget {
  final Budowa budowa;

  const PrzeniesienieReperaScreen({
    super.key,
    required this.budowa,
  });

  @override
  State<PrzeniesienieReperaScreen>
      createState() =>
          _PrzeniesienieReperaScreenState();
}

class _PrzeniesienieReperaScreenState
    extends State<PrzeniesienieReperaScreen> {
  Reper? selectedReper;

  final odczytWsteczController =
      TextEditingController();

  final odczytWPrzodController =
      TextEditingController();

  double osCelowa = 0;

  double nowyReper = 0;

  bool pokazKlawiature = false;

  TextEditingController? aktywnyController;

  @override
  void initState() {
    super.initState();

    final rg = widget.budowa.repery
        .where((r) => r.typ == ReperTyp.rg)
        .toList();

    if (rg.isNotEmpty) {
      selectedReper = rg.first;
    }
  }

  @override
  void dispose() {
    odczytWsteczController.dispose();
    odczytWPrzodController.dispose();
    super.dispose();
  }

  void przelicz() {
    if (selectedReper == null) {
      return;
    }

    final wstecz =
        double.tryParse(
              odczytWsteczController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    final przod =
        double.tryParse(
              odczytWPrzodController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    osCelowa =
        selectedReper!.rzedna + wstecz;

    nowyReper = osCelowa - przod;

    setState(() {});
  }

  String generateRRNumber() {
    int maxNumer = 0;

    for (final reper
        in widget.budowa.repery) {
      if (reper.typ != ReperTyp.rr) {
        continue;
      }

      final match =
          RegExp(r'(\d+)$')
              .firstMatch(reper.numer);

      if (match == null) {
        continue;
      }

      final numer =
          int.tryParse(
                match.group(1)!,
              ) ??
              0;

      if (numer > maxNumer) {
        maxNumer = numer;
      }
    }

    return 'RR${maxNumer + 1}';
  }

  void zapisz() {
    if (selectedReper == null) {
      return;
    }

    widget.budowa.repery.add(
      Reper(
        numer: generateRRNumber(),
        typ: ReperTyp.rr,
        rzedna: nowyReper,
        opis:
            'Przeniesiony z ${selectedReper!.numer}',
      ),
    );

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rg = widget.budowa.repery
        .where((r) => r.typ == ReperTyp.rg)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Przeniesienie Repera',
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
              labelText:
                  'Reper źródłowy',
            ),
            items: rg
                .map(
                  (r) =>
                      DropdownMenuItem(
                    value: r,
                    child: Text(
                      '${r.numer} (${UnitFormatter.rzedna(r.rzedna)})',
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
                aktywnyController =
                    odczytWsteczController;
                pokazKlawiature = true;
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

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              title: const Text(
                'Nowy reper',
              ),
              subtitle: Text(
                generateRRNumber(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                odczytWPrzodController,
            readOnly: true,
            showCursor: true,
            onTap: () {
              setState(() {
                aktywnyController =
                    odczytWPrzodController;
                pokazKlawiature = true;
              });
            },
            decoration:
                const InputDecoration(
              labelText:
                  'Odczyt w przód [m]',
              suffixIcon: Icon(
                Icons.calculate,
              ),
            ),
          ),

          const SizedBox(height: 16),

          if (pokazKlawiature &&
              aktywnyController != null)
            GeoNumericKeyboard(
              controller:
                  aktywnyController!,
              onDone: () {
                przelicz();

                setState(() {
                  pokazKlawiature = false;
                  aktywnyController = null;
                });
              },
            ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              title: const Text(
                'Rzędna nowego repera',
              ),
              subtitle: Text(
                UnitFormatter.rzedna(
                  nowyReper,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: zapisz,
            child: Text(
              'Zapisz ${generateRRNumber()}',
            ),
          ),
        ],
      ),
    );
  }
}