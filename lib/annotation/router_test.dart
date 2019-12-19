import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

class AppRouter {
  const AppRouter();
}

class PushRouter {
  final String url;
  final String name;
  final List<String> params; 
  const PushRouter({this.url, this.name, this.params});
}

class RouterInfo {
  final String import;
  final String constant;
  final String className;
  final List<String> params;
  final String url;
  final String name;

  RouterInfo({this.import, this.constant, this.className, this.params, this.url, this.name});
}

class PushRouterGenerator extends GeneratorForAnnotation<PushRouter> {
  static List<RouterInfo> routes = List();

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    String url = annotation.peek('url')?.stringValue;
    String name = annotation.peek('name')?.stringValue;
    final List<String> params = annotation.peek('params')?.listValue?.map((name) {
      return name.toStringValue();
    })?.toList();

    final className = element.displayName;
    final path = buildStep.inputId.path;
    final package = buildStep.inputId.package;
    final filePath = '${path.replaceFirst('lib/', '')}';
    final routerPath = filePath.replaceFirst('.dart', '');

    if (url == null) {
      url = routerPath;
    }

    if (name == null) {
      name = className.toUpperCase();
    }

    final import = 'import \'package:$package/$filePath\';';
    final constant = 'static const String ${name.toUpperCase()} = \'$url\';';

    routes.add(RouterInfo(import: import, constant: constant, className: className, params: params, url: url, name: name));

    return null;
  }
}

class AppRouterGenerator extends GeneratorForAnnotation<AppRouter> {

  List<RouterInfo> getRouterInfoList() {
    return PushRouterGenerator.routes;
  }

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final className = element.displayName;
    final List<RouterInfo> routerInfoList = getRouterInfoList();

    final Set<String> importContent = Set(); 
    final Set<String> constContent = Set();
    final Set<String> mapContent = Set();
    final Set<String> funcContent = Set();

    routerInfoList.forEach((RouterInfo routerInfo) {
      importContent.add(routerInfo.import);
      constContent.add(routerInfo.constant);
      mapContent.add(createMap(routerInfo.url, routerInfo.className, routerInfo.params));
      funcContent.add(createFun(routerInfo.className, routerInfo.name));
    });

    return '''
      import 'package:flutter/material.dart';
      ${importContent.join('\n')}
      class $className {
        ${constContent.join('\n')}
        static final Map<String, RouteFactory> _appRouterMap = {
          ${mapContent.join('\n')}
        };

        static RouteFactory onGenerateRoute = (settings) => _appRouterMap[settings.name](settings.arguments);

        ${funcContent.join('\n')}
      }''';
  }
}

String createFun(name, url) {
  return '''
    static Future<T> go${name}page<T extends Object>(context, {Object arguments}) {
      return Navigator.pushNamed<T>(context, ${url.toUpperCase()}, arguments: arguments);
    }''';
}

String arguments(params) {
  if (params.isEmpty) {
    return '';
  } else {
    final StringBuffer buffer = StringBuffer();
    params.forEach((name) {
      buffer.write("$name : arguments['$name'],");
    });
    return buffer.toString();
  }
}

String createMap(url, widget, params) {
  if (params == null) {
    return'''
    '$url': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => $widget(),
    ),''';
  } else {
    String param = arguments(params);
    return'''
    '$url': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) {
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return $widget($param);
      },
    ),''';
  }
  
}

Builder pushRouterBuilder(BuilderOptions options) => LibraryBuilder(PushRouterGenerator(), generatedExtension: '.routes.dart');
Builder appRouterBuilder(BuilderOptions options) => LibraryBuilder(AppRouterGenerator(), generatedExtension: '.router.dart');
