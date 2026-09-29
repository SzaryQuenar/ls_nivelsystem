import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../core/utils/odcinek_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../../models/odcinek.dart';
import '../../models/stanowisko.dart';
import '../../models/typ_odcinka.dart';
import '../../services/persistence_service.dart';

class CreateOdcinekScreen extends StatefulWidget {
  final Budowa budowa;

  const CreateOdcinekScreen({
    super.key,
    required this.budowa,
  });

  @override
  State<CreateOdcinekScreen> createState() =>
      _CreateOdcinekScreenState();
}

class _CreateOdcinekScreenState
    extends State<CreateOdcinekScreen> {
  final nazwaController =
      TextEditingController();

  final startController =
      TextEditingController();

  final koniecController =
      TextEditingController();

  final dlugoscController =
      TextEditingController();

  final spadekController =
      TextEditingController();

  TypOdcinka typ =
      TypOdcinka.kanalizacja;

  Branza branza =
      Branza.kanalizacjaSanitarna;

  Stanowisko? stanowisko;

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
    if (stanowisko == null) {
      pokazBlad(
        'Wybierz stanowisko',
      );
      return false;
    }

    if (nazwaController.text
        .trim()
        .isEmpty) {
      pokazBlad(
        'Podaj nazwę odcinka',
      );
      return false;
    }

    if (startController.text
        .trim()
        .isEmpty) {
      pokazBlad(
        'Podaj punkt początkowy',
      );
      return false;
    }

    if (koniecController.text
        .trim()
        .isEmpty) {
      pokazBlad(
        'Podaj punkt końcowy',
      );
      return false;
    }

    final dlugosc =
        double.tryParse(
      dlugoscController.text
          .replaceAll(',', '.'),
    );

    if (dlugosc == null ||
        dlugosc <= 0) {
      pokazBlad(
        'Podaj poprawną długość',
      );
      return false;
    }

    final spadek =
        double.tryParse(
      spadekController.text
          .replaceAll(',', '.'),
    );

    if (spadek == null) {
      pokazBlad(
        'Podaj spadek',
      );
      return false;
    }

    return true;
  }

  Future<void> zapisz() async {
    if (!waliduj()) {
      return;
    }

    widget.budowa.odcinki.add(
      Odcinek(
        branza: branza,
        stanowisko: stanowisko!,
        nazwa: nazwaController.text,
        typ: typ,
        punktStart:
            startController.text,
        punktKoniec:
            koniecController.text,
        dlugosc: double.parse(
          dlugoscController.text
              .replaceAll(',', '.'),
        ),
        projektowanySpadek:
            double.parse(
          spadekController.text
              .replaceAll(',', '.'),
        ),
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
          'Nowy Odcinek',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<
              Branza>(
            initialValue: branza,
            decoration:
                const InputDecoration(
              labelText:
                  'Branża',
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
              Stanowisko>(
            decoration:
                const InputDecoration(
              labelText:
                  'Stanowisko',
            ),
            items: widget
                .budowa.stanowiska
                .map(
              (s) =>
                  DropdownMenuItem(
                value: s,
                child: Text(
                  s.numer,
                ),
              ),
            ).toList(),
            onChanged: (value) {
              setState(() {
                stanowisko =
                    value;
              });
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                nazwaController,
            decoration:
                const InputDecoration(
              labelText:
                  'Nazwa odcinka',
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<
              TypOdcinka>(
            initialValue: typ,
            decoration:
                const InputDecoration(
              labelText: 'Typ',
            ),
            items: TypOdcinka.values
                .map(
                  (t) =>
                      DropdownMenuItem(
                    value: t,
                    child: Text(
                      OdcinekFormatter
                          .nazwaTypu(
                        t,
                      ),
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
                startController,
            decoration:
                const InputDecoration(
              labelText:
                  'Punkt początkowy',
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                koniecController,
            decoration:
                const InputDecoration(
              labelText:
                  'Punkt końcowy',
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                dlugoscController,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
              ),
            decoration:
                const InputDecoration(
              labelText:
                  'Długość [m]',
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller:
                spadekController,
            keyboardType:
                const TextInputType.numberWithOptions(
            decimal: true,
            ),
            decoration:
                const InputDecoration(
              labelText:
                  'Projektowany spadek [%]',
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: zapisz,
            icon: const Icon(
              Icons.save,
            ),
            label: const Text(
              'ZAPISZ ODCINEK',
            ),
          ),
        ],
      ),
    );
  }
}