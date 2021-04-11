import 'package:flutter/material.dart';
import 'package:myrandomuser/homepage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Random User',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: HomePage(title: 'Random User'),
  ));
}
