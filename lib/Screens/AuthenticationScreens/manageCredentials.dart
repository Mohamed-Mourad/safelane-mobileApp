import 'package:flutter/material.dart';

class UserCredentials {
  final String id;
  final String username;
  final String email;
  final String password;

  UserCredentials({required this.id, required this.username, required this.email, required this.password});
}

class UserCredentialsProvider extends ChangeNotifier {
  UserCredentials? _userCredentials;

  UserCredentials? get userCredentials => _userCredentials;

  void setUserCredentials(UserCredentials credentials) {
    _userCredentials = credentials;
    notifyListeners();
  }
}