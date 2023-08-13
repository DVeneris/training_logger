import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_tracker/DTOS/user-dto.dart';
import 'package:training_tracker/DTOS/user_profile_dto.dart';
import 'package:training_tracker/models/user.dart';
import 'package:training_tracker/services/auth.dart';
import 'package:training_tracker/services/user-service.dart';

class AuthProvider with ChangeNotifier {
  late final AuthService _authService;

  AuthProvider(AuthService authService) {
    _authService = authService;
  }

  Future<void> signOut(VoidCallback onSuccess) async {
    await _authService.signOut();
    onSuccess.call();
  }
}
