import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }
  SharedPreferences prefs;
  UserPreferences._internal();

  initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  get phone {
    return prefs.getString('phone') ?? '';
  }

  set phone(String value) {
    prefs.setString('phone', value);
  }

  get name {
    return prefs.getString('name') ?? '';
  }

  set name(String value) {
    prefs.setString('name', value);
  }

  get send {
    return prefs.getBool('send') ?? false;
  }

  set send(bool value) {
    prefs.setBool('send', value);
  }

  get guest {
    return prefs.getString('guest') ?? '';
  }

  set guest(String value) {
    prefs.setString('guest', value);
  }

  get host {
    return prefs.getString('host') ?? '';
  }

  set host(String value) {
    prefs.setString('host', value);
  }

  get guest1 {
    return prefs.getString('guest1') ?? '';
  }

  set guest1(String value) {
    prefs.setString('guest1', value);
  }

  get uidguest1 {
    return prefs.getString('uidguest1') ?? '';
  }

  set uidguest1(String value) {
    prefs.setString('uidguest1', value);
  }

  get guest2 {
    return prefs.getString('guest2') ?? '';
  }

  set guest2(String value) {
    prefs.setString('guest2', value);
  }

  get uidguest2 {
    return prefs.getString('uidguest2') ?? '';
  }

  set uidguest2(String value) {
    prefs.setString('uidguest2', value);
  }

  get guest3 {
    return prefs.getString('guest3') ?? '';
  }

  set guest3(String value) {
    prefs.setString('guest3', value);
  }

  get uidguest3 {
    return prefs.getString('uidguest3') ?? '';
  }

  set uidguest3(String value) {
    prefs.setString('uidguest3', value);
  }

  get date {
    return prefs.getString('date') ?? '';
  }

  set date(String value) {
    prefs.setString('date', value);
  }

  get uid {
    return prefs.getString('uid') ?? '';
  }

  set uid(String value) {
    prefs.setString('uid', value);
  }

  set channelName(String value) {
    prefs.setString('channelName', value);
  }

  get channelName {
    return prefs.getString('channelName') ?? '';
  }

  get tokenFCM {
    return prefs.getString('tokenFCM') ?? '';
  }

  set tokenFCM(String value) {
    prefs.setString('tokenFCM', value);
  }

  get rol {
    return prefs.getString('rol') ?? '';
  }

  set rol(String value) {
    prefs.setString('rol', value);
  }

  get pickup {
    return prefs.getString('pickup') ?? '';
  }

  set pickup(String value) {
    prefs.setString('pickup', value);
  }

  get menu {
    return prefs.getString('menu') ?? '';
  }

  set menu(String value) {
    prefs.setString('menu', value);
  }

  get payment {
    return prefs.getString('payment') ?? '';
  }

  set payment(String value) {
    prefs.setString('payment', value);
  }
}
