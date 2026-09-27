import 'package:flutter/material.dart';

import '../../core/utils/unit_formatter.dart';
import '../../models/budowa.dart';
import '../../models/pomiar.dart';
import '../../models/stanowisko.dart';

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

  double rzedna = 0;

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

  bool waliduj() {
    if (kodController.text.trim().isEmpty) {
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

    setState(() {
      rzedna =
          widget.stanowisko.osCelowa -
          odczyt;
    });
  }

  void zapisz() {
    if (!waliduj()) return;

    final odczyt = double.parse(
      odczytController.text
          .replaceAll(',', '.'),
    );

    widget.budowa.pomiary.add(
      Pomiar(
        kodPunktu: kodController.text,
        opis: opisController.text,
        stanowisko: widget.stanowisko,
        odczyt: odczyt,
        rzedna: rzedna,
        data: DateTime.now(),
        odcinek: null,
      ),
    );

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
          'Nowy Pomiar',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
                  widget.stanowisko.osCelowa,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: kodController,
            decoration:
                const InputDecoration(
              labelText:
                  'Kod punktu (K1, W1, S1...)',
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

          const SizedBox(height: 16),

          TextField(
            controller: odczytController,
            keyboardType:
                TextInputType.number,
            decoration:
                const InputDecoration(
              labelText: 'Odczyt [m]',
            ),
            onChanged: (_) => przelicz(),
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

          FilledButton(
            onPressed: zapisz,
            child: const Text(
              'Zapisz pomiar',
            ),
          ),
        ],
      ),
    );
  }
}