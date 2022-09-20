// ignore_for_file: public_member_api_docs, sort_constructors_first
class Content {
  String title;
  String days;
  String initialHour;
  String endHour;
  String discipline;
  Content({
    required this.title,
    required this.days,
    required this.initialHour,
    required this.endHour,
    required this.discipline,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'days': days,
      'initialHour': initialHour,
      'endHour': endHour,
      'discipline': discipline,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      title: map['title'] as String,
      days: map['days'] as String,
      initialHour: map['initialHour'] as String,
      endHour: map['endHour'] as String,
      discipline: map['discipline'] as String,
    );
  }
}
