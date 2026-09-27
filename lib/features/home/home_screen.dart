import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../services/persistence_service.dart';
import '../budowa/budowa_screen.dart';
import '../budowa/create_budowa_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  Future<void> _openCreateBudowa() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CreateBudowaScreen(),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final budowy =
        AppData.budowy.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Niwelacja Terenu',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: _openCreateBudowa,
            icon: const Icon(
              Icons.add,
            ),
            label: const Text(
              'Nowa Budowa',
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Moje Budowy',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (budowy.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(
                  16,
                ),
                child: Text(
                  'Brak zapisanych budów',
                ),
              ),
            ),

          ...budowy.map(
            (budowa) => Card(
              child: ListTile(
                title: Text(
                  budowa.numerBudowy,
                ),
                subtitle: Text(
                  budowa.nazwa,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          BudowaScreen(
                        budowa: budowa,
                      ),
                    ),
                  );
                },
                onLongPress: () async {
                  final usun =
                      await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Usuń budowę',
                        ),
                        content: Text(
                          'Czy na pewno usunąć budowę "${budowa.numerBudowy}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                false,
                              );
                            },
                            child: const Text(
                              'ANULUJ',
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                true,
                              );
                            },
                            child: const Text(
                              'USUŃ',
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (usun == true) {
                    AppData.budowy.remove(
                      budowa,
                    );

                    await PersistenceService
                        .save();

                    if (!mounted) {
                      return;
                    }

                    setState(() {});

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Budowa została usunięta',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}