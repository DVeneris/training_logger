import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

class UserProvider with ChangeNotifier {
  UserDTO? _user;
  UserDTO? get user => _user;
  bool? _userExists;
  bool? get userExists => _userExists;

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  Future<void> anonLoginUser() async {
    await _authService.anonLogin();
    var userName = "user_${getRandomString(6)}";
    var authUser = await _userService.createUser(userName);
    notifyListeners();
  }

  Future<void> checkIfUserExist(String username) async {
    var userExists = await _userService.checkIfUserExists(username);
    _userExists = userExists;
    notifyListeners();
  }

  String getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
