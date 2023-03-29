import 'package:EMO/common/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefsService {
  static PrefsService get to => AppInjector.injector<PrefsService>();

  Future<PrefsService> init();

  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> setList(String key, List<String> value);

  String getString(String key);

  bool getBool(String key);

  List<String> getList(String key);

  Future<bool> remove(String key);

  Future<bool> clear();

  Map<String, dynamic> get allPrefs;
}

class PrefsServiceImpl implements PrefsService {
  late final SharedPreferences _prefs;

  @override
  Future<PrefsServiceImpl> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> setList(String key, List<String> value) => _prefs.setStringList(key, value);

  @override
  String getString(String key) => _prefs.getString(key) ?? '';

  @override
  bool getBool(String key) => _prefs.getBool(key) ?? false;

  @override
  List<String> getList(String key) => _prefs.getStringList(key) ?? [];

  @override
  Future<bool> remove(String key) => _prefs.remove(key);

  @override
  Future<bool> clear() => _prefs.clear();

  @override
  Map<String, dynamic> get allPrefs => _prefs.getKeys().fold<Map<String, dynamic>>(
        {},
        (Map<String, dynamic> previousValue, String element) {
          previousValue[element] = _prefs.get(element);
          return previousValue;
        },
      );
}
