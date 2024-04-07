import 'dart:convert';
import 'dart:io';

class JsonManager {
  static Map<String, dynamic> getJson({required String path}) {
    final file = File(path);
    final json = jsonDecode(file.readAsStringSync());
    return json;
  }

  static List<Map<String, dynamic>> getJsonList({required String path}) {
    final file = File(path);
    final json = jsonDecode(file.readAsStringSync());
    return List<Map<String, dynamic>>.from(json);
  }
}
