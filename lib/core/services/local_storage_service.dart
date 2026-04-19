import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;
  LocalStorageService(this._prefs);

  static const String _firstTimeKey = 'is_first_time';

  bool isFirstTime() {
    return _prefs.getBool(_firstTimeKey) ?? true;
  }

  Future<void> setNotFirstTime() async {
    await _prefs.setBool(_firstTimeKey, false);
  }
}
