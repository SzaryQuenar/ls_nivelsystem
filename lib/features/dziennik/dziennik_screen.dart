import 'package:flutter/material.dart';

import '../../core/utils/branza_colors.dart';
import '../../core/utils/branza_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import '../../models/odcinek.dart';
import '../../models/pomiar_punktowy.dart';
import '../../models/rura.dart';
import '../../models/stanowisko.dart';
import 'package:printing/printing.dart';
import 'dziennik_pdf_service.dart';

class DziennikScreen extends StatelessWidget {
  final Budowa budowa;

  const DziennikScreen({
    super.key,
    required this.budowa,
  });

  IconData ikonaBranzy(
    Branza branza,
  ) {
    switch (branza) {
      case Branza.kanalizacjaSanitarna:
        return Icons.water_drop;

      case Branza.kanalizacjaDeszczowa:
        return Icons.eco;

      case Branza.wodociag:
        return Icons.opacity;

      case Branza.drogowa:
        return Icons.alt_route;

      case Branza.kabel:
        return Icons.electrical_services;

      case Branza.inne:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dziennik Niwelacji',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.picture_as_pdf,
            ),
            onPressed: () async {
              final file =
                  await DziennikPdfService
                      .generujPdf(
                budowa,
              );

              await Printing.sharePdf(
                bytes:
                    await file.readAsBytes(),
                filename:
                    file.path.split('/').last,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (budowa.stanowiska.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Brak stanowisk',
                ),
              ),
            ),

          ...budowa.stanowiska.map(
            (Stanowisko stanowisko) {
              return Card(
                margin: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  leading: const Icon(
                    Icons.straighten,
                  ),
                  title: Text(
                    stanowisko.numer,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Reper: ${stanowisko.reper.numer}\n'
                    'OC: ${stanowisko.osCelowa.toStringAsFixed(3)}',
                  ),
                  children: [
                    ...Branza.values.map(
                      (Branza branza) {
                        final pomiaryBranzy =
                            budowa.pomiaryPunktowe.where(
                          (p) =>
                              p.stanowisko.numer ==
                                  stanowisko.numer && 
                              p.branza ==
                                  branza,
                        ).toList();

                        final odcinkiBranzy =
                            budowa.odcinki.where(
                          (o) =>
                              o.stanowisko.numer ==
                                  stanowisko.numer && 
                              o.branza ==
                                  branza,
                        ).toList();

                        if (pomiaryBranzy.isEmpty &&
                            odcinkiBranzy.isEmpty) {
                          return const SizedBox
                              .shrink();
                        }

                        return Container(
                          margin:
                              const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                  ? const Color(0xFF232323)
                                  : BranzaColors.tlo(
                                        branza,
                                      ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                            border: Border.all(
                              color:
                                  BranzaColors
                                      .kolor(
                                branza,
                              ),
                              width: 2,
                            ),
                          ),
                          child: ExpansionTile(
                            leading: Icon(
                              ikonaBranzy(
                                branza,
                              ),
                              color:
                                  BranzaColors
                                      .kolor(
                                branza,
                              ),
                            ),
                            title: Text(
                              BranzaFormatter
                                  .nazwa(
                                branza,
                              ),
                              style: TextStyle(
                                color:
                                    BranzaColors
                                        .kolor(
                                  branza,
                                ),
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            children: [
                              if (pomiaryBranzy
                                  .isNotEmpty)
                                const ListTile(
                                  title: Text(
                                    'PUNKTY',
                                    style:
                                        TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),

                              ...pomiaryBranzy.map(
                                (
                                  PomiarPunktowy
                                      pomiar,
                                ) =>
                                    ListTile(
                                  leading:
                                      const Icon(
                                    Icons
                                        .location_on,
                                  ),
                                  title: Text(
                                    pomiar.kod,
                                  ),
                                  subtitle: Text(
                                    '${pomiar.typ.name}\n'
                                    'Odczyt: ${pomiar.odczyt.toStringAsFixed(3)} m\n'
                                    'Rzędna: ${pomiar.rzedna.toStringAsFixed(3)} m n.p.m.\n'
                                    'OC: ${pomiar.stanowisko.osCelowa.toStringAsFixed(3)} m',
                                  ),
                                ),
                              ),

                              if (odcinkiBranzy
                                  .isNotEmpty)
                                const ListTile(
                                  title: Text(
                                    'ODCINKI',
                                    style:
                                        TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),

                              ...odcinkiBranzy.map(
                                (
                                  Odcinek
                                      odcinek,
                                ) =>
                                    ExpansionTile(
                                  leading:
                                      const Icon(
                                    Icons
                                        .timeline,
                                  ),
                                  title: Text(
                                    odcinek.nazwa,
                                  ),
                                  subtitle: Text(
                                    'Spadek: '
                                    '${odcinek.projektowanySpadek.toStringAsFixed(2)} %\n'
                                    'Rur: ${odcinek.rury.length}',
                                  ),
                                  children: [
                                    if (odcinek
                                        .rury
                                        .isEmpty)
                                      const ListTile(
                                        title:
                                            Text(
                                          'Brak rur',
                                        ),
                                      ),

                                    ...odcinek
                                        .rury
                                        .map(
                                      (
                                        Rura
                                            rura,
                                      ) =>
                                          ListTile(
                                        leading:
                                            const Icon(
                                          Icons
                                              .linear_scale,
                                        ),
                                        title:
                                            Text(
                                          rura.nazwa,
                                        ),
                                        subtitle: Text(
                                          'Długość: ${rura.dlugosc.toStringAsFixed(2)} m\n'
                                          'Projekt: ${rura.projektowanySpadek.toStringAsFixed(2)} %\n'
                                          'Odczyt pocz.: ${rura.odczytPoczatek?.toStringAsFixed(3) ?? '-'}\n'
                                          'Rzędna pocz.: ${rura.rzednaPoczatek?.toStringAsFixed(3) ?? '-'}\n'
                                          'Odczyt końc.: ${rura.odczytKoniec?.toStringAsFixed(3) ?? '-'}\n'
                                          'Rzędna końc.: ${rura.rzednaKoniec?.toStringAsFixed(3) ?? '-'}',
                                        ),
                                        trailing: rura.spadekRzeczywisty != null
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'RZECZ.',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${rura.spadekRzeczywisty!.toStringAsFixed(2)}%',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}