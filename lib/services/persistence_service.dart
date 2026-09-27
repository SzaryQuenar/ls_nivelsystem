import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_data.dart';
import '../models/budowa.dart';

class PersistenceService {
  static const _key = 'ls_budowy';

  static Future<void> save() async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonData =
        AppData.budowy
            .map(
              (e) => e.toJson(),
            )
            .toList();

    await prefs.setString(
      _key,
      jsonEncode(jsonData),
    );
  }

  static Future<void> load() async {
    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        prefs.getString(_key);

    if (jsonString == null) {
      return;
    }

    final data =
        jsonDecode(jsonString) as List;

    AppData.budowy =
        data
            .map(
              (e) => Budowa.fromJson(e),
            )
            .toList();
  }
}