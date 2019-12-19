import 'package:flutter/material.dart';
import 'annotation/router_test.dart';

@PushRouter()
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: Text('data'),
    );
  }
}