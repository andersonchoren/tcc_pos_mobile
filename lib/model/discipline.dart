// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agenda_de_estudos/model/content.dart';

class Discipline {
  String name;
  String icon;
  List<Content> contents;
  Discipline({
    required this.name,
    required this.contents,
    this.icon = "other",
  });
}
