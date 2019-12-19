import 'package:flutter/material.dart';
import 'router.router.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      onGenerateRoute: AppRouters.onGenerateRoute,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: InkWell(
            child: Text('data'),
            onTap: () {
              AppRouters.goHomepage(context);
            },
          ),
        ),
      ),
    );
  }
}