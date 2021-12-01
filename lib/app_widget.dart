import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nasa App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
    ).modular(); //added by extension
  }
}
