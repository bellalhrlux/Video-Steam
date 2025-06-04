import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class Env {
  static final Map<String, String> _env = {};

  static Future<void> load() async {
    try {
      // Load the .env file content from assets
      final envString = await rootBundle.loadString('assets/.env');
      final lines = envString.split('\n');
      for (var line in lines) {
        if (line.trim().isEmpty || line.startsWith('#')) continue; // Skip empty lines and comments
        final index = line.indexOf('=');
        if (index == -1) continue; // Skip lines that do not contain '='
        final key = line.substring(0, index).trim();
        final value = line.substring(index + 1).trim();
        _env[key] = value;
      }

      print('Env variables loaded successfully.');

    } catch (e) {
      print('Failed to load .env file: $e');
    }
  }
  static String? get(String key) {
    return _env[key];
  }
}
