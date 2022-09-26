import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/day_of_week.dart';
import 'package:agenda_de_estudos/model/form_validation.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/components/time_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AddContent extends StatefulWidget {
  String discipline;
  AddContent({
    super.key,
    required this.discipline,
  });

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  var contentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var initialHourInput = TimeInput(
    title: translate("add_content.starts_ace"),
  );
  var endHourInput = TimeInput(
    title: translate("add_content.end_ace"),
  );
  var checkboxs = [
    DayOfWeek(title: translate("days_of_week.mon")),
    DayOfWeek(title: translate("days_of_week.tue")),
    DayOfWeek(title: translate("days_of_week.wed")),
    DayOfWeek(title: translate("days_of_week.thu")),
    DayOfWeek(title: translate("days_of_week.fri")),
    DayOfWeek(title: translate("days_of_week.sat")),
    DayOfWeek(title: translate("days_of_week.sun")),
  ];
  var icon = "book";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate("add_content.appbar.title"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    height: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        translate("add_content.content_name_label"),
                      ),
                    ),
                    validator: ((value) {
                      return validateContentEmpty(
                        value!,
                        translate("form.empty_input"),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: initialHourInput,
                ),
                endHourInput,
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    translate("add_content.days_of_week_label"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Checkbox(
                              value: checkboxs[index].isActive,
                              onChanged: (value) {
                                setState(() {
                                  checkboxs[index].isActive = value!;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkboxs[index].isActive =
                                      !checkboxs[index].isActive;
                                });
                              },
                              child: Text(checkboxs[index].title),
                            ),
                          ],
                        );
                      },
                      itemCount: checkboxs.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var content = Content(
              title: contentController.text,
              days: prepareDaysOfWeek(checkboxs),
              initialHour: initialHourInput.inputController.text,
              endHour: endHourInput.inputController.text,
              discipline: widget.discipline,
            );

            try {
              ContentRepository.insertContent(
                  content.toMap(), widget.discipline);
              var snack = SnackBar(
                content: Text(
                  translate("add_content.content_save_success"),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
            } catch (exception) {
              var snack = SnackBar(
                content: Text(
                  translate("error"),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
            }
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

String prepareDaysOfWeek(List<DayOfWeek> daysOfWeek) {
  return daysOfWeek
      .where((day) => day.isActive)
      .map((e) => e.title)
      .toString()
      .replaceAll("(", "")
      .replaceAll(")", "");
}
