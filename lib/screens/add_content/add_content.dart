import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/day_of_week.dart';
import 'package:agenda_de_estudos/model/form_validation.dart';
import 'package:agenda_de_estudos/model/list_of_disciplines.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/components/time_input.dart';
import 'package:agenda_de_estudos/shared/find_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  var discipline = list_of_disciplines[0];
  var contentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var initialHourInput = TimeInput(title: "Inicia ás");
  var endHourInput = TimeInput(title: "Termina ás");
  var checkboxs = [
    DayOfWeek(title: "Seg"),
    DayOfWeek(title: "Ter"),
    DayOfWeek(title: "Qua"),
    DayOfWeek(title: "Qui"),
    DayOfWeek(title: "Sex"),
    DayOfWeek(title: "Sab"),
    DayOfWeek(title: "Dom"),
  ];
  var icon = findIcon(list_of_disciplines[0]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo conteúdo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(16),
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
                  key: formKey,
                  controller: contentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Nome do conteúdo"),
                  ),
                  validator: ((value) {
                    return validateContentName(value!);
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text("Disciplina"),
              ),
              const SizedBox(
                height: 8,
              ),
              DropdownButton(
                value: discipline,
                isExpanded: true,
                items: list_of_disciplines.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/${findIcon(item)}.svg",
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(item),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    discipline = newValue!;
                    icon = findIcon(newValue);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: initialHourInput,
              ),
              endHourInput,
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text("Dias da semana"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var content = Content(
            title: contentController.text,
            days: prepareDaysOfWeek(checkboxs),
            initialHour: initialHourInput.inputController.text,
            endHour: endHourInput.inputController.text,
            discipline: discipline,
          );

          try {
            ContentRepository.insertContent(content.toMap(), discipline);
            var snack = const SnackBar(
                content: Text("Conteúdo registrado com sucesso!!!"));
            ScaffoldMessenger.of(context).showSnackBar(snack);
          } catch (exception) {
            var snack =
                const SnackBar(content: Text("Houve um erro inesperado!!!"));
            ScaffoldMessenger.of(context).showSnackBar(snack);
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
