import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/utils/branza_formatter.dart';
import '../../models/budowa.dart';
import '../../models/branza.dart';

class DziennikPdfService {
  static Future<File> generujPdf(
    Budowa budowa,
  ) async {
    final regularFont =
        await rootBundle.load(
      'assets/fonts/NotoSans-Regular.ttf',
    );

    final boldFont =
        await rootBundle.load(
      'assets/fonts/NotoSans-Bold.ttf',
    );

    final pdf = pw.Document();

    final regular = pw.Font.ttf(
      regularFont,
    );

    final bold = pw.Font.ttf(
      boldFont,
    );

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: regular,
          bold: bold,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Container(
              padding:
                  const pw.EdgeInsets.all(
                12,
              ),
              color: PdfColors.blueGrey100,
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment
                        .start,
                children: [
                  pw.Text(
                    'DZIENNIK NIWELACJI',
                    style: pw.TextStyle(
                      font: bold,
                      fontSize: 22,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Budowa: ${budowa.numerBudowy}',
                  ),
                  pw.Text(
                    budowa.nazwa,
                  ),
                  pw.Text(
                    budowa.miejscowosc,
                  ),
                  pw.Text(
                    'Data raportu: ${DateFormat("dd.MM.yyyy HH:mm").format(DateTime.now())}',
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            ...budowa.stanowiska.map(
              (stanowisko) {
                final pomiary =
                    budowa
                        .pomiaryPunktowe
                        .where(
                          (p) =>
                              p.stanowisko.numer ==
                              stanowisko.numer,
                        )
                        .toList();

                final odcinki =
                    budowa.odcinki
                        .where(
                          (o) =>
                              o.stanowisko.numer ==
                              stanowisko.numer,
                        )
                        .toList();

                return pw.Container(
                  margin:
                      const pw.EdgeInsets.only(
                    bottom: 16,
                  ),
                  padding:
                      const pw.EdgeInsets.all(
                    10,
                  ),
                  decoration:
                      pw.BoxDecoration(
                    border: pw.Border.all(),
                  ),
                  child: pw.Column(
                    crossAxisAlignment:
                        pw.CrossAxisAlignment
                            .start,
                    children: [
                      pw.Text(
                        'STANOWISKO ${stanowisko.numer}',
                        style: pw.TextStyle(
                          font: bold,
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Reper: ${stanowisko.reper.numer}',
                      ),
                      pw.Text(
                        'Oś celowa: ${stanowisko.osCelowa.toStringAsFixed(3)}',
                      ),
                      pw.SizedBox(height: 10),

                      ...Branza.values.map(
                          (branza) {
                            final pomiaryBranzy =
                                pomiary
                                    .where(
                                      (p) =>
                                          p.branza ==
                                          branza,
                                    )
                                    .toList();

                            final odcinkiBranzy =
                                odcinki
                                    .where(
                                      (o) =>
                                          o.branza ==
                                          branza,
                                    )
                                    .toList();

                            if (pomiaryBranzy
                                    .isEmpty &&
                                odcinkiBranzy
                                    .isEmpty) {
                              return pw.SizedBox();
                            }

                            return pw.Container(
                              margin:
                                  const pw.EdgeInsets.only(
                                top: 10,
                              ),
                              padding:
                                  const pw.EdgeInsets.all(
                                8,
                              ),
                              decoration:
                                  pw.BoxDecoration(
                                border:
                                    pw.Border.all(),
                              ),
                              child: pw.Column(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment
                                        .start,
                                children: [
                                  pw.Text(
                                    BranzaFormatter
                                        .nazwa(
                                      branza,
                                    ),
                                    style:
                                        pw.TextStyle(
                                      font:
                                          bold,
                                      fontSize:
                                          14,
                                    ),
                                  ),

                                  if (pomiaryBranzy
                                      .isNotEmpty)
                                    pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(
                                        top: 6,
                                      ),
                                      child: pw.Text(
                                        'PUNKTY',
                                        style:
                                            pw.TextStyle(
                                          font:
                                              bold,
                                        ),
                                      ),
                                    ),

                                  ...pomiaryBranzy.map(
                                  (pomiar) => pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        '• ${pomiar.kod}',
                                      ),

                                      pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: pw.Text(
                                          'Typ: ${pomiar.typ.name}',
                                        ),
                                      ),

                                      pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: pw.Text(
                                          'Odczyt: ${pomiar.odczyt.toStringAsFixed(3)} m',
                                        ),
                                      ),

                                      pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: pw.Text(
                                          'Rzędna: ${pomiar.rzedna.toStringAsFixed(3)} m n.p.m.',
                                        ),
                                      ),

                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),

                                if (odcinkiBranzy
                                    .isNotEmpty)
                                  pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(
                                      top: 8,
                                    ),
                                    child: pw.Text(
                                      'ODCINKI',
                                      style:
                                          pw.TextStyle(
                                        font:
                                            bold,
                                      ),
                                    ),
                                  ),

                                ...odcinkiBranzy.map(
                                  (odcinek) =>
                                      pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment
                                            .start,
                                    children: [
                                      pw.SizedBox(
                                        height:
                                            4,
                                      ),
                                      pw.Text(
                                        '${odcinek.nazwa} | spadek ${odcinek.projektowanySpadek.toStringAsFixed(2)}%',
                                      ),

                                      ...odcinek
                                          .rury
                                          .map(
                                        (
                                          rura,
                                        ) =>
                                            pw.Padding(
                                          padding:
                                              const pw.EdgeInsets.only(
                                            left:
                                                15,
                                          ),
                                          child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                '- ${rura.nazwa}',
                                                style: pw.TextStyle(
                                                  font: bold,
                                                ),
                                              ),

                                              pw.Text(
                                                'Długość: ${rura.dlugosc.toStringAsFixed(2)} m',
                                              ),

                                              pw.Text(
                                                'Projektowany spadek: ${rura.projektowanySpadek.toStringAsFixed(2)} %',
                                              ),

                                              if (rura.spadekRzeczywisty != null)
                                                pw.Text(
                                                  'Spadek rzeczywisty: ${rura.spadekRzeczywisty!.toStringAsFixed(2)} %',
                                                ),

                                              if (rura.odczytPoczatek != null)
                                                pw.Text(
                                                  'Odczyt początkowy: ${rura.odczytPoczatek!.toStringAsFixed(3)}',
                                                ),

                                              if (rura.rzednaPoczatek != null)
                                                pw.Text(
                                                  'Rzędna początkowa: ${rura.rzednaPoczatek!.toStringAsFixed(3)}',
                                                ),

                                              if (rura.odczytKoniec != null)
                                                pw.Text(
                                                  'Odczyt końcowy: ${rura.odczytKoniec!.toStringAsFixed(3)}',
                                                ),

                                              if (rura.rzednaKoniec != null)
                                                pw.Text(
                                                  'Rzędna końcowa: ${rura.rzednaKoniec!.toStringAsFixed(3)}',
                                                ),

                                              pw.SizedBox(height: 5),
                                            ],
                                          ),
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
          ];
        },
      ),
    );

    final directory =
        await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/dziennik_${DateFormat("yyyyMMdd_HHmmss").format(DateTime.now())}.pdf',
    );

    await file.writeAsBytes(
      await pdf.save(),
    );

    return file;
  }
}