import 'package:flutter/material.dart';

import '../../models/odcinek.dart';
import '../../models/rura.dart';
import '../../services/persistence_service.dart';

class CreateRuraScreen extends StatefulWidget {
  final Odcinek odcinek;

  const CreateRuraScreen({
    super.key,
    required this.odcinek,
  });

  @override
  State<CreateRuraScreen> createState() =>
      _CreateRuraScreenState();
}

class _CreateRuraScreenState
    extends State<CreateRuraScreen> {
  bool trybUkladanie = true;

  bool spadekMalejacy = true;

  final nazwaController =
      TextEditingController();

  final dlugoscController =
      TextEditingController();

  final spadekController =
      TextEditingController();

  final odczytStartController =
      TextEditingController();

  final odczytKoniecController =
      TextEditingController();

  double wynikSpadku = 0;

  double wynikOdczytu = 0;

  double roznicaWysokosci = 0;

  double rzednaPoczatku = 0;

  double rzednaKonca = 0;

  void przelicz() {
    final dlugosc =
        double.tryParse(
              dlugoscController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    final spadek =
        double.tryParse(
              spadekController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    final odczytStart =
        double.tryParse(
              odczytStartController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    final osCelowa =
        widget.odcinek.stanowisko.osCelowa;

    rzednaPoczatku =
        osCelowa - odczytStart;

    if (trybUkladanie) {
      roznicaWysokosci =
          dlugosc * (spadek / 100);

      if (spadekMalejacy) {
        wynikOdczytu =
            odczytStart +
                roznicaWysokosci;
      } else {
        wynikOdczytu =
            odczytStart -
                roznicaWysokosci;
      }

      rzednaKonca =
          osCelowa - wynikOdczytu;
    } else {
      final odczytKoniec =
          double.tryParse(
                odczytKoniecController.text
                    .replaceAll(',', '.'),
              ) ??
              0;

      if (dlugosc > 0) {
        wynikSpadku =
            ((odczytKoniec -
                        odczytStart) /
                    dlugosc) *
                100;
      }

      rzednaKonca =
          osCelowa - odczytKoniec;

      roznicaWysokosci =
          rzednaPoczatku -
              rzednaKonca;
    }

    setState(() {});
  }

  Future<void> zapisz() async {
    final dlugosc =
        double.tryParse(
              dlugoscController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    if (dlugosc <= 0) {
      return;
    }

    final spadek =
        double.tryParse(
              spadekController.text
                  .replaceAll(',', '.'),
            ) ??
            widget.odcinek.projektowanySpadek;

    widget.odcinek.rury.add(
      Rura(
        nazwa:
            nazwaController.text.trim().isEmpty
                ? 'Rura ${widget.odcinek.rury.length + 1}'
                : nazwaController.text,
        dlugosc: dlugosc,
        projektowanySpadek: spadek,
        odczytPoczatek: double.tryParse(
          odczytStartController.text
              .replaceAll(',', '.'),
        ),
        odczytKoniec: trybUkladanie
            ? wynikOdczytu
            : double.tryParse(
                odczytKoniecController.text
                    .replaceAll(',', '.'),
              ),
        rzednaPoczatek:
            rzednaPoczatku,
        rzednaKoniec:
            rzednaKonca,
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
          'Nowa Rura',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          TextField(
            controller:
                nazwaController,
            decoration:
                const InputDecoration(
              labelText:
                  'Nazwa rury',
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                dlugoscController,
            keyboardType: TextInputType.text,
            decoration:
                const InputDecoration(
              labelText:
                  'Długość rury [m]',
            ),
            onChanged: (_) =>
                przelicz(),
          ),

          const SizedBox(height: 16),

          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label:
                    Text('UKŁADANIE'),
              ),
              ButtonSegment(
                value: false,
                label:
                    Text('KONTROLA'),
              ),
            ],
            selected: {
              trybUkladanie,
            },
            onSelectionChanged:
                (value) {
              setState(() {
                trybUkladanie =
                    value.first;
              });

              przelicz();
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                odczytStartController,
            keyboardType: TextInputType.text,
            decoration:
                const InputDecoration(
              labelText:
                  'Odczyt początkowy [m]',
            ),
            onChanged: (_) =>
                przelicz(),
          ),

          const SizedBox(height: 16),

          if (trybUkladanie)
            TextField(
              controller:
                  spadekController,
              keyboardType: TextInputType.text,
              decoration:
                  const InputDecoration(
                labelText:
                    'Projektowany spadek [%]',
              ),
              onChanged: (_) =>
                  przelicz(),
            ),

          if (!trybUkladanie)
            TextField(
              controller:
                  odczytKoniecController,
              keyboardType: TextInputType.text,
              decoration:
                  const InputDecoration(
                labelText:
                    'Odczyt końcowy [m]',
              ),
              onChanged: (_) =>
                  przelicz(),
            ),

          const SizedBox(height: 16),

          if (trybUkladanie)
            SwitchListTile(
              value: spadekMalejacy,
              title: Text(
                spadekMalejacy
                    ? 'Spadek malejący'
                    : 'Spadek rosnący',
              ),
              onChanged: (value) {
                setState(() {
                  spadekMalejacy =
                      value;
                });

                przelicz();
              },
            ),

          const SizedBox(height: 24),

          if (trybUkladanie)
            Card(
               child: ListTile(
                title: const Text(
                  'Wymagany odczyt końcowy',
                ),
                subtitle: Text(
                  wynikOdczytu
                      .toStringAsFixed(3),
                ),
              ),
            ),

          if (trybUkladanie)
            Card(
              child: ListTile(
                title: const Text(
                  'Różnica wysokości',
                ),
                subtitle: Text(
                  '${roznicaWysokosci.toStringAsFixed(3)} m',
                ),
              ),
            ),

          if (!trybUkladanie)
            Card(
              child: ListTile(
                title: const Text(
                  'Spadek rzeczywisty',
                ),
                subtitle: Text(
                  '${wynikSpadku.toStringAsFixed(3)} %',
                ),
              ),
            ),

          const SizedBox(height: 24),

          Card(
            child: ListTile(
              title: const Text(
                'Oś celowa',
              ),
              subtitle: Text(
                widget.odcinek.stanowisko.osCelowa
                    .toStringAsFixed(3),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Rzędna początku',
              ),
              subtitle: Text(
                '${rzednaPoczatku.toStringAsFixed(3)} m n.p.m.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Rzędna końca',
              ),
              subtitle: Text(
                '${rzednaKonca.toStringAsFixed(3)} m n.p.m.',
              ),
            ),
          ),

          FilledButton.icon(
            onPressed: zapisz,
            icon: const Icon(
              Icons.save,
            ),
            label: const Text(
              'ZAPISZ RURĘ',
            ),
          ),
        ],
      ),
    );
  }
}