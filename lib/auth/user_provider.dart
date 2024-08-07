import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  SharedPreferences? sharedPreferences;

  UserModel? currentUser;

  void updateUser(UserModel user) {
    currentUser = user;
    saveUser(currentUser!);
    notifyListeners();
  }

  Future<void> saveUser(UserModel user) async {
  await sharedPreferences!.setStringList('user',[
    user.email,
    user.id,
    user.name
  ]);

  }

  List? getUser() {
    return sharedPreferences!.getStringList('user');

  }

  Future<void> loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List? oldUser = getUser();
    if (oldUser != null) {
      currentUser = UserModel(id: oldUser[1], name: oldUser[2], email: oldUser[0]);
      notifyListeners();
    }
  }
  Future<void> logout() async {
   sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.remove('user');

  }
}