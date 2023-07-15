import 'package:flutter/material.dart';
import 'package:safelane/Screens/GoogleMapsScreens/map.dart';
import 'package:safelane/Screens/AuthenticationScreens/signin.dart';
import 'package:safelane/Screens/AuthenticationScreens/signup.dart';
import 'package:safelane/Screens/GoogleMapsScreens/search.dart';

import '../Screens/GoogleMapsScreens/filter.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/map': (context) => MapScreen(),
    '/signin': (context) => SignInScreen(),
    '/signup': (context) => SignUpScreen(),
    '/search': (context) => AutocompleteSearchScreen(),
    '/filter': (context) => FilterScreen(),
  };
}