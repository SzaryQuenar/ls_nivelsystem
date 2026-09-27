import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/app_data.dart';
import '../models/budowa.dart';

class BackupService {
  static Future<void> eksportujJson() async {
    final jsonData = {
      'wersja': 1,
      'dataEksportu':
          DateTime.now().toIso8601String(),
      'budowy': AppData.budowy
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    };

    final directory =
        await getTemporaryDirectory();

    final file = File(
      '${directory.path}/ls_backup.json',
    );

    await file.writeAsString(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(
        jsonData,
      ),
    );

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            file.path,
          ),
        ],
        subject:
            'LS NivelSystem Backup',
        text:
            'Kopia zapasowa LS NivelSystem',
      ),
    );
  }

  static Future<void> importujJson() async {
    final result =
        await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      return;
    }

    final path =
        result.files.single.path;

    if (path == null) {
      return;
    }

    final file = File(path);

    final jsonString =
        await file.readAsString();

    final jsonData =
        jsonDecode(jsonString);

    final budowy =
        (jsonData['budowy'] as List)
            .map(
              (e) =>
                  Budowa.fromJson(
                e,
              ),
            )
            .toList();

    AppData.budowy
      ..clear()
      ..addAll(budowy);
  }

  static Future<bool> backupIstnieje() async {
    try {
      final directory =
          await getTemporaryDirectory();

      final file = File(
        '${directory.path}/ls_backup.json',
      );

      return await file.exists();
    } catch (_) {
      return false;
    }
  }

  static Future<String?> odczytajBackup() async {
    try {
      final directory =
          await getTemporaryDirectory();

      final file = File(
        '${directory.path}/ls_backup.json',
      );

      if (!await file.exists()) {
        return null;
      }

      return await file.readAsString();
    } catch (_) {
      return null;
    }
  }
}