import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'route_path.dart';
import 'route_handlers.dart';

class AppRouter {
  static Router _router;
  static get router {
    if (_router == null) {
      _router = new Router();
      configureRoutes(_router);
    }
    return _router;
  }

  static navigateTo(BuildContext context, String path,
    { bool replace = false,
      bool clearStack = false,
      TransitionType transition = TransitionType.fadeIn,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder }) {
    router.navigateTo(context, path, replace: replace, clearStack: clearStack,
      transition: transition, transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder);
  }
}

configureRoutes(Router router) {
  router.define(RoutePath.index1, handler: homeHandler);
}