class Discipline {
  String name;
  String icon;
  int numberOfContents;
  Discipline({
    required this.name,
    required this.icon,
    this.numberOfContents = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon,
      'numberOfContents': numberOfContents,
    };
  }

  factory Discipline.fromMap(Map<String, dynamic> map) {
    return Discipline(
      name: map['name'] as String,
      icon: map['icon'] as String,
      numberOfContents: map['numberOfContents'] as int,
    );
  }
}
