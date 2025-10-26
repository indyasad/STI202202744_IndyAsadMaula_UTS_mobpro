import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/event_model.dart';

class FileManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.json');
  }

  static Future<List<Event>> readEvents() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        await file.create();
        return [];
      }
      final contents = await file.readAsString();
      if (contents.isEmpty) return [];
      List data = jsonDecode(contents);
      return data.map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      print('Error readEvents: $e');
      return [];
    }
  }

  static Future<void> writeEvents(List<Event> events) async {
    try {
      final file = await _localFile;
      List data = events.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Error writeEvents: $e');
    }
  }
}
