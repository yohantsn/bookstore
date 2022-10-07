import 'package:shared_preferences/shared_preferences.dart';

abstract class IBookStorePersistence {
  String? read({required String key});
  Future<void> write({required String key, required String data});
  Future<void> delete({required String key});
}

class BookStorePersistence implements IBookStorePersistence {
  late final SharedPreferences _persistence;

  BookStorePersistence({SharedPreferences? persistence}) {
    if (persistence == null) {
      SharedPreferences.getInstance().then((prefs) => _persistence = prefs);
    } else {
      _persistence = persistence;
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _persistence.remove(key);
    } on Object catch (_) {
      rethrow;
    }
  }

  @override
  String? read({required String key}) {
    try {
      final data = _persistence.getString(key);
      return data ?? "";
    } on Object catch (_) {
      return null;
    }
  }

  @override
  Future<void> write({required String key, required String data}) async {
    try {
      _persistence.setString(key, data);
    } on Object catch (_) {
      rethrow;
    }
  }
}
