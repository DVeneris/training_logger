import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/media-item-dto.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/models/media_item.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

class UserProvider with ChangeNotifier {
  late final AuthService _authService;
  late final UserService _userService;
  UserProvider(AuthService authService, UserService userService) {
    _authService = authService;
    _userService = userService;
  }

  late UserDTO _user;
  UserDTO get user => _user;
  set user(UserDTO newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setMediaItem(MediaItemDTO mediaItem) {
    _userProfile.mediaItem = mediaItem;
    notifyListeners();
  }

  late UserProfileDTO _userProfile;
  UserProfileDTO get userProfile => _userProfile;
  set userProfile(UserProfileDTO newUser) {
    _userProfile = newUser;
    notifyListeners();
  }

  late bool _userExists;
  bool get userExists => _userExists;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  set isSaving(bool result) {
    _isSaving = result;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool result) {
    _isLoading = result;
    notifyListeners();
  }

  Future<void> anonLoginUser() async {
    await _authService.anonLogin();
    var userName = "user_${getRandomString(6)}";
    var authUser =
        await _userService.createUser(userName); //check for empty user
    _user = authUser!;
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

  Future<void> updateUser() async {
    isSaving = true;
    await _userService.updateUser(userProfile);
    isSaving = false;
  }

  Future<UserDTO> getCurrentUser() async {
    user = await _userService.getCurrentUser();
    return user;
  }

  Stream<User?> getUserStream() {
    return _authService.getUserStream();
  }
}
