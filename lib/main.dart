import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/discipline_repository.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var disciplines = await DisciplineRepository.findAll();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agenda de estudos",
      home: Home(
        disciplines: disciplines
            .map(
              (e) => Discipline.fromMap(e),
            )
            .toList(),
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
