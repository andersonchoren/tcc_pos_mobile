// ignore_for_file: public_member_api_docs, sort_constructors_first

class Discipline {
  int? id;
  String name;
  String icon;
  int numberOfContents;
  Discipline({
    this.id,
    required this.name,
    required this.icon,
    this.numberOfContents = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'numberOfContents': numberOfContents,
    };
  }

  factory Discipline.fromMap(Map<String, dynamic> map) {
    return Discipline(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      icon: map['icon'] as String,
      numberOfContents: map['numberOfContents'] as int,
    );
  }
}
