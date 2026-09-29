import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../core/utils/unit_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../../models/pomiar_punktowy.dart';
import '../../models/stanowisko.dart';
import '../../models/typ_punktu.dart';
import '../../services/persistence_service.dart';

class CreatePomiarScreen extends StatefulWidget {
  final Budowa budowa;
  final Stanowisko stanowisko;

  const CreatePomiarScreen({
    super.key,
    required this.budowa,
    required this.stanowisko,
  });

  @override
  State<CreatePomiarScreen> createState() =>
      _CreatePomiarScreenState();
}

class _CreatePomiarScreenState
    extends State<CreatePomiarScreen> {
  final kodController =
      TextEditingController();

  final opisController =
      TextEditingController();

  final odczytController =
      TextEditingController();

  Branza branza =
      Branza.kanalizacjaSanitarna;

  TypPunktu typ =
      TypPunktu.studnia;

  double rzedna = 0;

  List<TypPunktu> getDostepneTypy() {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
      case Branza.kanalizacjaDeszczowa:
        return [
          TypPunktu.studnia,
          TypPunktu.wpust,
          TypPunktu.punkt,
          TypPunktu.inne,
        ];

      case Branza.wodociag:
        return [
          TypPunktu.hydrant,
          TypPunktu.zasuwa,
          TypPunktu.punkt,
          TypPunktu.inne,
        ];

      case Branza.drogowa:
        return [
          TypPunktu.kraweznik,
          TypPunktu.chodnik,
          TypPunktu.punkt,
          TypPunktu.inne,
        ];

      case Branza.kabel:
        return [
          TypPunktu.punkt,
          TypPunktu.inne,
        ];

      case Branza.inne:
        return TypPunktu.values;
    }
  }

  void pokazBlad(
    String komunikat,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          komunikat,
        ),
        backgroundColor:
            Colors.red,
      ),
    );
  }

  bool waliduj() {
    if (kodController.text
        .trim()
        .isEmpty) {
      pokazBlad(
        'Podaj kod punktu',
      );
      return false;
    }

    final odczyt = double.tryParse(
      odczytController.text
          .replaceAll(',', '.'),
    );

    if (odczyt == null) {
      pokazBlad(
        'Podaj poprawny odczyt',
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
    final odczyt = double.tryParse(
          odczytController.text
              .replaceAll(',', '.'),
        ) ??
        0;

    setState(
      () {
        rzedna =
            widget.stanowisko.osCelowa -
                odczyt;
      },
    );
  }

  Future<void> zapisz() async {
    if (!waliduj()) {
      return;
    }

    final odczyt = double.parse(
      odczytController.text
          .replaceAll(',', '.'),
    );

    widget.budowa.pomiaryPunktowe.add(
      PomiarPunktowy(
        branza: branza,
        typ: typ,
        kod: kodController.text.trim(),
        opis: opisController.text.trim(),
        stanowisko:
            widget.stanowisko,
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nowy Pomiar',
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
                'Oś celowa',
              ),
              subtitle: Text(
                UnitFormatter.osCelowa(
                  widget
                      .stanowisko
                      .osCelowa,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<Branza>(
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
                          .nazwa(
                        e,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(
                () {
                  branza = value;
                  typ =
                      getDostepneTypy()
                          .first;
                },
              );
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
            items: getDostepneTypy()
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
              if (value == null) {
                return;
              }

              setState(
                () {
                  typ = value;
                },
              );
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                kodController,
            decoration:
                const InputDecoration(
              labelText:
                  'Kod punktu',
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

          TextField(
            controller:
                odczytController,
            keyboardType:
                const TextInputType.numberWithOptions(
            decimal: true,
            ),
            decoration:
                const InputDecoration(
              labelText:
                  'Odczyt [m]',
            ),
            onChanged: (_) =>
                przelicz(),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              title: const Text(
                'Rzędna punktu',
              ),
              subtitle: Text(
                UnitFormatter.rzedna(
                  rzedna,
                ),
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