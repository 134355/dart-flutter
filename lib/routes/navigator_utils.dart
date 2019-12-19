import 'package:flutter/material.dart';
import 'app_router.dart';
import 'route_path.dart';

class NavigatorUtils {
  static void goIndexPage(BuildContext context) {
    AppRouter.navigateTo(context, RoutePath.index1);
  }
}