import 'package:flutter/material.dart';

class FormValidators {
  static String? validateEmail(String providedEmail) {
      if(providedEmail.isEmpty) {return "Email required";}
                      
      bool validRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(providedEmail);
      if(!validRegex) {return "Invalid email provided";}
      return null;
  }

  static String? validatePassword(String providedPassword, TextEditingController passwordController) {
    if(providedPassword.isEmpty) {return "Password required";}
    
    if(passwordController.text.length < 8) {return "Minimum length must be atleast 8 characters";}
    return null;
  }

  static String? validateUsername(String providedUsername) {
    if(providedUsername.isEmpty) {return "Username required";}
    return null;
  }

  static String? validateMatchingPwds(TextEditingController confirmPController, TextEditingController passwordController) {
    if(confirmPController.text.isEmpty) {return "Password required";}
    if(confirmPController.text != passwordController.text) {return "Passwords dont match. Re-enter your passwords";}
    return null;
  }
}