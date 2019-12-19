// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppRouterGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:yele_app/home.dart';

class AppRouters {
  static const String HOME = 'home';
  static final Map<String, RouteFactory> _appRouterMap = {
    'home': (RouteSettings settings) => MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
  };

  static RouteFactory onGenerateRoute =
      (settings) => _appRouterMap[settings.name](settings.arguments);

  static Future<T> goHomepage<T extends Object>(context, {Object arguments}) {
    return Navigator.pushNamed<T>(context, HOME, arguments: arguments);
  }
}
