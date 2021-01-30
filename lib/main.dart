import 'package:flutter/material.dart';
import 'package:weatherapp/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'simple weather app',
      home: HomePage(),
      themeMode: ThemeMode.system,
    ),
  );
}
