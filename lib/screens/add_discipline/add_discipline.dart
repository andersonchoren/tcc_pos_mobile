import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/discipline_repository.dart';
import 'package:agenda_de_estudos/utils/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../model/form_validation.dart';

class AddDiscipline extends StatefulWidget {
  const AddDiscipline({super.key});

  @override
  State<AddDiscipline> createState() => _AddDisciplineState();
}

class _AddDisciplineState extends State<AddDiscipline> {
  var discipline = list_of_icons[0];
  var disciplineController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var icon = list_of_icons[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("add_discipline.appbar.title")),
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
                    controller: disciplineController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        translate("add_discipline.subject_name"),
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
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    translate("add_discipline.icon"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton(
                  value: discipline,
                  isExpanded: true,
                  items: list_of_icons.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/$item.svg",
                            height: 24,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      discipline = newValue!;
                      icon = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var discipline =
                Discipline(name: disciplineController.text, icon: icon);

            try {
              DisciplineRepository.insert(discipline.toMap());
              var snack = SnackBar(
                content: Text(
                  translate("add_discipline.discipline_save_success"),
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
