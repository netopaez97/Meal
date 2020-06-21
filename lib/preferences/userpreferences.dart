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
    return _prefs.getString('phone') ?? '';
  }

  set phone(String value) {
    _prefs.setString('phone', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get date {
    return _prefs.getString('date') ?? '';
  }

  set date(String value) {
    _prefs.setString('date', value);
  }

  get uid {
    return _prefs.getString('uid') ?? '';
  }

  set uid(String value) {
    _prefs.setString('uid', value);
  }
}
