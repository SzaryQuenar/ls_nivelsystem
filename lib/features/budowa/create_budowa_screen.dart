import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/budowa.dart';
import '../../services/persistence_service.dart';

class CreateBudowaScreen extends StatefulWidget {
  const CreateBudowaScreen({super.key});

  @override
  State<CreateBudowaScreen> createState() =>
      _CreateBudowaScreenState();
}

class _CreateBudowaScreenState
    extends State<CreateBudowaScreen> {
  final numerController = TextEditingController();

  final nazwaController = TextEditingController();

  final miejscowoscController =
      TextEditingController();

  final inwestorController =
      TextEditingController();

  final opisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nowa Budowa'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: numerController,
            decoration: const InputDecoration(
              labelText: 'Numer budowy',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: nazwaController,
            decoration: const InputDecoration(
              labelText: 'Nazwa budowy',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: miejscowoscController,
            decoration: const InputDecoration(
              labelText: 'Miejscowość',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: inwestorController,
            decoration: const InputDecoration(
              labelText: 'Inwestor',
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: opisController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Opis',
            ),
          ),

          const SizedBox(height: 24),

          FilledButton(
            onPressed: () async {
              final budowa = Budowa(
                numerBudowy:
                    numerController.text,
                nazwa:
                    nazwaController.text,
                miejscowosc:
                    miejscowoscController.text,
                inwestor:
                    inwestorController.text,
                opis: opisController.text,
                repery: [],
              );

              AppData.budowy.add(budowa);

              await PersistenceService.save();

              if (!context.mounted) {
                return;
              }

              Navigator.pop(
                context,
                true,
              );
            },
            child: const Text('Zapisz'),
          ),
        ],
      ),
    );
  }
}