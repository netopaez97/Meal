import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }
  SharedPreferences _prefs;
  UserPreferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get phone {
    return _prefs.getInt('phone') ?? '';
  }

  set phone(int value) {
    _prefs.setInt('phone', value);
  }
}