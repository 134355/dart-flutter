import 'package:flutter/material.dart';

class AppNavigator {
  static pushNamed(BuildContext context, String routeName, { Object arguments }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // 替换
  static pushReplacementNamed(BuildContext context, String routeName, { Object result, Object arguments }){
    Navigator.pushReplacementNamed(context, routeName, result: result, arguments: arguments);
  }

  // 替换
  static popAndPushNamed(BuildContext context, String routeName, { Object result, Object arguments }){
    Navigator.popAndPushNamed(context, routeName, result: result, arguments: arguments);
  }

  /// 回退到指定页面
  static popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.popUntil(context, predicate);
  }

  // 添加并删除部分页面
  static pushNamedAndRemoveUntil(BuildContext context, String newRouteName, RoutePredicate predicate, { Object arguments }) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate, arguments: arguments);
  }
}



typedef Widget HandlerFunc(BuildContext context, dynamic parameters);
class Handler {
  HandlerFunc handlerFunc;
  Handler({this.handlerFunc});
}


class TextNavigator {
  static Map _routes = Map();
  static get routes {
    return _routes;
  }

  static define(String routeName, Handler handler) {
    _routes[routeName] = _handlerFunc(handler);
  }

  static _handlerFunc(Handler handler) {
    return (dynamic arguments) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return handler.handlerFunc(context, arguments);
        }
      );
    };
  }

  Route<dynamic> generator(RouteSettings routeSettings) {
    return _routes[routeSettings.name](routeSettings.arguments);
  }
}