import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';


Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fluro demo'),
      ),
      body: Text('data'),
    );
  }
);