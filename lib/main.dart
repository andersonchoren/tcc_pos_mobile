import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agenda de estudos",
      home: Home(
        
      ),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: secondary,
          onSecondary: Colors.white,
        ),
        toggleableActiveColor: secondary,
      ),
    ),
  );
}
