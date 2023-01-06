import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
      primarySwatch: Colors.lightBlue,
    ),
    home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Age Calculator"),
        actions: const <Widget>[
          // overflow menu
        ],
      ),
      body: HomeScreen(),
    ),
  ));
}
