import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:safelane/Shared/components/constants.dart';
import 'package:safelane/Screens/AuthenticationScreens/manageCredentials.dart';

class OutboudRequests {

  static final Map<String, String> headers = {'Content-Type': 'application/json'};
  
  static Future<bool> requestSignUp(String username, String email, String password) async {
    try {
      final Uri url = Uri.parse(baseURL);
      final Map<String, String> body = {
        'username': username,
        'email': email,
        'password': password,
        'type': "User"
      };

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return json.decode(response.body);
    }
    catch(Exception) {return false;}
  }
  
  static Future<String> requestSignIn(BuildContext context, String email, String password) async {
    try {
      final Uri url = Uri.parse(baseURL+"/user/login");
      final Map<String, String> body = {
        'email' : email,
        'password' : password
      };

      final http.Response response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if(response.body == "\"SUCCESS\"")
        requestCredentials(context, email);
      return response.body;
    }
    catch (Exception) {return "ERROR";}
  }

  static Future<String> requestCredentials(BuildContext context, String email) async {
    try {
      final Uri url = Uri.parse(baseURL+"/email/$email");
      final http.Response response = await http.get(
        url,
        headers: headers,
      );

      final Map<String, dynamic> parsedData = json.decode(response.body);
      final userCredentials = UserCredentials(
        id: parsedData['id'],
        username: parsedData['username'],
        email: parsedData['email'],
        password: parsedData['password'],
      );

      final userCredentialsProvider = Provider.of<UserCredentialsProvider>(context, listen: false);
      userCredentialsProvider.setUserCredentials(userCredentials);
      return "SUCCESS";
    }
    catch(Exception) {return "ERROR";}
  }

  static Future<String> requestSignOut(String email, String password) async {
    try{
      final Uri url = Uri.parse(baseURL+"/logout");
      final Map<String, String> body = {
        'email' : email,
        'password' : password
      };

      final http.Response response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response.body;
    }
    catch(Exception) {return "ERROR";}
  }
}