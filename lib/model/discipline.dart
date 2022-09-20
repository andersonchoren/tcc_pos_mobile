import 'package:agenda_de_estudos/model/content.dart';

class Discipline {
  String name;
  String icon;
  List<Content>? contents;
  Discipline({
    required this.name,
    this.icon = "other",
    this.contents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon,
    };
  }

  factory Discipline.fromMap(Map<String, dynamic> map) {
    return Discipline(
      name: map['name'] as String,
      icon: map['icon'] as String,
    );
  }
}
