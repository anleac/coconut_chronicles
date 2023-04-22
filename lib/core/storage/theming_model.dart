import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemingModel extends Model {
  static ThemingModel of(BuildContext context) => ScopedModel.of<ThemingModel>(context);

  static const darkModeKey = "_asdgnj123b";

  late bool _darkMode = _sharedPreferences.getBool(darkModeKey) ?? false;
  bool get darkMode => _darkMode;

  final SharedPreferences _sharedPreferences;

  ThemingModel(this._sharedPreferences);

  void setDarkMode(bool newValue) {
    if (_darkMode == newValue) return;

    _darkMode = newValue;
    _sharedPreferences.setBool(darkModeKey, _darkMode);

    notifyListeners();
  }
}
