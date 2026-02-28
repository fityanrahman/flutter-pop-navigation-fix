import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> write<T>(String key, T value) async {
    if (_prefs == null) {
      throw StateError('SharedPreferences not initialized. Call init() first.');
    }
    
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported value type');
    }
  }

  Future<T?> read<T>(String key) async {
    if (_prefs == null) {
      throw StateError('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!.get(key) as T?;
  }

  Future<void> delete(String key) async {
    if (_prefs == null) {
      throw StateError('SharedPreferences not initialized. Call init() first.');
    }
    await _prefs!.remove(key);
  }

  Future<void> clear() async {
    if (_prefs == null) {
      throw StateError('SharedPreferences not initialized. Call init() first.');
    }
    await _prefs!.clear();
  }
}
