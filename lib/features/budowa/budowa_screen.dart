import 'package:flutter/material.dart';

import '../../models/budowa.dart';
import '../repery/repery_screen.dart';
import '../repery/przeniesienie_repera_screen.dart';
import '../stanowiska/stanowiska_screen.dart';
import '../dziennik/dziennik_screen.dart';
import '../niwelacja/niwelacja_screen.dart';
import '../settings/settings_screen.dart';

class BudowaScreen extends StatelessWidget {
  final Budowa budowa;

  const BudowaScreen({
    super.key,
    required this.budowa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          budowa.numerBudowy,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            budowa.nazwa,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.place),
              title: const Text('REPERY'),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReperyScreen(
                      budowa: budowa,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.straighten),
              title: const Text(
                'STANOWISKA',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StanowiskaScreen(
                      budowa: budowa,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text(
                'PRZENIESIENIE REPERA',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PrzeniesienieReperaScreen(
                      budowa: budowa,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.straighten,
              ),
              title: const Text(
                'NIWELACJA',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NiwelacjaScreen(
                      budowa: budowa,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.history,
              ),
              title: const Text(
                'DZIENNIK NIWELACJI',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DziennikScreen(
                      budowa: budowa,
                    ),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'USTAWIENIA',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}