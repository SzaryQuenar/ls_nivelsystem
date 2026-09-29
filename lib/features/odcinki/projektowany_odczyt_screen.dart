import 'package:flutter/material.dart';

import '../../core/utils/unit_formatter.dart';
import '../../models/odcinek.dart';
import '../../widgets/geo_numeric_keyboard.dart';

class ProjektowanyOdczytScreen
    extends StatefulWidget {
  final Odcinek odcinek;

  const ProjektowanyOdczytScreen({
    super.key,
    required this.odcinek,
  });

  @override
  State<ProjektowanyOdczytScreen>
      createState() =>
          _ProjektowanyOdczytScreenState();
}

class _ProjektowanyOdczytScreenState
    extends State<ProjektowanyOdczytScreen> {
  final odczytStartController =
      TextEditingController();

  double roznica = 0;

  double odczytKoniec = 0;

  bool spadekMalejacy = true;

  void przelicz() {
    final odczytStart =
        double.tryParse(
              odczytStartController.text
                  .replaceAll(',', '.'),
            ) ??
            0;

    roznica =
        widget.odcinek.dlugosc *
        (widget.odcinek
                .projektowanySpadek /
            100);

    if (spadekMalejacy) {
      odczytKoniec =
          odczytStart + roznica;
    } else {
      odczytKoniec =
          odczytStart - roznica;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Odczyt Projektowany',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Odcinek',
              ),
              subtitle: Text(
                widget.odcinek.nazwa,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              title: const Text(
                'Długość',
              ),
              subtitle: Text(
                UnitFormatter.dlugosc(
                  widget.odcinek.dlugosc,
                ),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Projektowany spadek',
              ),
              subtitle: Text(
                UnitFormatter.spadek(
                  widget.odcinek
                      .projektowanySpadek,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

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

          Card(
            child: Column(
              children: [
                RadioListTile<bool>(
                  title: const Text(
                    'Spadek malejący',
                  ),
                  subtitle: const Text(
                    'Odczyt końcowy większy od początkowego',
                  ),
                  value: true,
                  groupValue:
                      spadekMalejacy,
                  onChanged: (value) {
                    setState(() {
                      spadekMalejacy =
                          value!;
                    });

                    przelicz();
                  },
                ),

                RadioListTile<bool>(
                  title: const Text(
                    'Spadek rosnący',
                  ),
                  subtitle: const Text(
                    'Odczyt końcowy mniejszy od początkowego',
                  ),
                  value: false,
                  groupValue:
                      spadekMalejacy,
                  onChanged: (value) {
                    setState(() {
                      spadekMalejacy =
                          value!;
                    });

                    przelicz();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              title: const Text(
                'Różnica wysokości',
              ),
              subtitle: Text(
                '${roznica.toStringAsFixed(3)} m',
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Docelowy odczyt końcowy',
              ),
              subtitle: Text(
                '${odczytKoniec.toStringAsFixed(3)} m',
                style:
                    const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Różnica wysokości [mm]',
              ),
              subtitle: Text(
                '${(roznica * 1000).toStringAsFixed(0)} mm',
              ),
            ),
          ),
        ],
      ),
    );
  }
}