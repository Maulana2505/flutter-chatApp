import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  setid(String id) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("id", id);
  }

  setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  getToken() async {
    final pref = await SharedPreferences.getInstance();
    final data =pref.getString("token");
    return data;
  }

  getid() async {
    final pref = await SharedPreferences.getInstance();
    pref.getString("id");
  }

  Future<bool> constantKey(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }

  Future delete() async {
    final pref = await SharedPreferences.getInstance();
    return await pref.clear();
  }
}
