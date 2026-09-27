import 'package:flutter/material.dart';

import '../../core/utils/odcinek_formatter.dart';
import '../../models/budowa.dart';
import '../../models/typ_odcinka.dart';
import 'create_odcinek_screen.dart';
import 'odcinek_details_screen.dart';
import '../../models/branza.dart';

class OdcinkiScreen extends StatefulWidget {
  final Budowa budowa;

  final Branza branza;

  const OdcinkiScreen({
    super.key,
    required this.budowa,
    required this.branza,
  });

  @override
  State<OdcinkiScreen> createState() =>
      _OdcinkiScreenState();
}

class _OdcinkiScreenState
    extends State<OdcinkiScreen> {
  TypOdcinka? filtr;

  @override
  Widget build(BuildContext context) {
    final odcinkiBranzy =
    widget.budowa.odcinki
        .where(
          (o) => o.branza == widget.branza,
        )
        .toList();

     final odcinki =
        filtr == null
            ? odcinkiBranzy
            : odcinkiBranzy
                .where(
                  (o) => o.typ == filtr,
                )
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Odcinki',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () async {
              final result =
                await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CreateOdcinekScreen(
                  budowa: widget.budowa,
                  ),
                ),
              );
              
              if (result == true) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'Nowy Odcinek',
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<
              TypOdcinka?>(
            initialValue: filtr,
            decoration:
                const InputDecoration(
              labelText:
                  'Filtr typów odcinków',
            ),
            items: [
              const DropdownMenuItem<
                  TypOdcinka?>(
                value: null,
                child: Text(
                  'WSZYSTKIE',
                ),
              ),

              ...TypOdcinka.values.map(
                (typ) =>
                    DropdownMenuItem<
                        TypOdcinka?>(
                  value: typ,
                  child: Text(
                    OdcinekFormatter
                        .nazwaTypu(
                      typ,
                    ),
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                filtr = value;
              });
            },
          ),

          const SizedBox(height: 20),

          if (odcinki.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'Brak odcinków',
                ),
              ),
            ),

          ...odcinki.map(
            (odcinek) => Card(
              child: ListTile(
                leading: const Icon(
                  Icons.timeline,
                ),
                title: Text(
                  odcinek.nazwa,
                ),
                subtitle: Text(
                  '${OdcinekFormatter.nazwaTypu(odcinek.typ)}\n'
                  '${odcinek.punktStart} → ${odcinek.punktKoniec}\n'
                  'Długość: ${odcinek.dlugosc.toStringAsFixed(2)} m\n'
                  'Spadek: ${odcinek.projektowanySpadek.toStringAsFixed(2)} %',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OdcinekDetailsScreen(
                        odcinek: odcinek,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}