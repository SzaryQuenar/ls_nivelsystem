import 'package:flutter/material.dart';

import '../../core/utils/branza_formatter.dart';
import '../../models/branza.dart';
import '../../models/budowa.dart';
import 'branza_details_screen.dart';

class BranzaScreen extends StatelessWidget {
  final Budowa budowa;

  const BranzaScreen({
    super.key,
    required this.budowa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Branże',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: Branza.values.map(
          (branza) {
            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_tree,
                ),
                title: Text(
                  BranzaFormatter.nazwa(
                    branza,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BranzaDetailsScreen(
                        branza: branza,
                        budowa: budowa,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}