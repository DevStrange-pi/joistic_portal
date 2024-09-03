import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userKey = 'user';
  static const String _appliedCompaniesKey = 'applied_companies';

  static final GlobalKey<ScaffoldState> scaffoldRiKey1 = GlobalKey<ScaffoldState>();
  static const tooltipRiKey2 = Key('__RIKEY2__');
  static const riKey3 = Key('__RIKEY3__');

  Future<void> saveUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user);
  }

  Future<String?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<void> saveAppliedCompanies(List<int> companyIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = companyIds.map((id) => id.toString()).toList();
    await prefs.setStringList(_appliedCompaniesKey, ids);
  }

  Future<List<int>> getAppliedCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? ids = prefs.getStringList(_appliedCompaniesKey);
    if (ids != null) {
      return ids.map((id) => int.parse(id)).toList();
    }
    return [];
  }
}
