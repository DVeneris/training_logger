import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

class UserProvider with ChangeNotifier {
  late UserDTO? _user;

  UserDTO? get user => _user;

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  Future<void> anonLoginUser(String username) async {
    await _authService.anonLogin();
    var authUser = _authService.getUser();
    var user = await _userService.checkIfUserExistsandCreateUser(username);
    _user = user;
    notifyListeners();
  }
}
