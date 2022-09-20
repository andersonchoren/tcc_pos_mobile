import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';

final List<Discipline> disciplines = [
  Discipline(
    name: "Química",
    icon: "chemistry",
    contents: [
      Content(
        title: "Tipos de ligação",
        days: "Segundas e Quartas",
        initialHour: "15:00",
        endHour: "15:00",
      ),
      Content(
        title: "Gases nobres",
        days: "Terças e Quintas",
        initialHour: "15:00",
        endHour: "15:00",
      ),
    ],
  ),
];
