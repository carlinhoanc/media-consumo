import 'package:flutter/material.dart';
import 'package:mediaconsumo/screens/dashborad/dashborad.dart';
import 'package:mediaconsumo/screens/posto/posto_lista.dart';

void main() {
  runApp(MediaConsumo());
}

class MediaConsumo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blue[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[700],
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}