import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/backup_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ustawienia',
        ),
      ),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeModeNotifier,
        builder: (
          context,
          mode,
          child,
        ) {
          return ListView(
            children: [
              const ListTile(
                leading: Icon(
                  Icons.palette,
                ),
                title: Text(
                  'Wygląd',
                ),
              ),

              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: mode,
                title: const Text(
                  'Systemowy',
                ),
                onChanged: (value) {
                  themeModeNotifier.value =
                      value!;
                },
              ),

              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: mode,
                title: const Text(
                  'Jasny',
                ),
                onChanged: (value) {
                  themeModeNotifier.value =
                      value!;
                },
              ),

              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: mode,
                title: const Text(
                  'Ciemny',
                ),
                onChanged: (value) {
                  themeModeNotifier.value =
                      value!;
                },
              ),

              const Divider(),

              const ListTile(
                leading: Icon(
                  Icons.backup,
                ),
                title: Text(
                  'Kopia zapasowa',
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.upload_file,
                ),
                title: const Text(
                  'Eksport danych',
                ),
                subtitle: const Text(
                  'JSON',
                ),
                onTap: () async {
                  try {
                    await BackupService
                        .eksportujJson();

                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Backup został utworzony',
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Błąd eksportu: $e',
                        ),
                      ),
                    );
                  }
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.download,
                ),
                title: const Text(
                  'Import danych',
                ),
                subtitle: const Text(
                  'JSON',
                ),
                onTap: () async {
                  try {
                    await BackupService
                        .importujJson();

                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Backup został zaimportowany',
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Błąd importu: $e',
                        ),
                      ),
                    );
                  }
                },
              ),

              const Divider(),

              const AboutListTile(
                icon: Icon(
                  Icons.info,
                ),
                applicationName:
                    'LS NivelSystem',
                applicationVersion:
                    '1.0.0',
                applicationLegalese:
                    '© Łukasz Sołuch',
              ),
            ],
          );
        },
      ),
    );
  }
}