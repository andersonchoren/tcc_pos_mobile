import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_svg/svg.dart';

class DetailsListItem extends StatelessWidget {
  Discipline discipline;
  Content content;
  DetailsListItem({
    super.key,
    required this.discipline,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/${discipline.icon}.svg"),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      content.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: primary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        var time = content.initialHour.split(":");
                        bool skip = true;
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Configuração do alerta",
                              ),
                              content: const Text(
                                "Você deseja configurar seu alarme?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    skip = false;
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Sim"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Não"),
                                )
                              ],
                            );
                          },
                        );

                        setAlarm(
                          title: content.title,
                          hour: int.parse(time[0]),
                          minute: int.parse(time[1]),
                          skip: skip,
                        );
                      },
                      icon: Icon(
                        Icons.add_alert,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    IconButton(
                      onPressed: () async {
                        var result = await ContentRepository.removeContent(
                          content.id!,
                          discipline.name,
                        );
                        if (result != 0) {
                          var snack = SnackBar(
                            content: const Text(
                              "Conteúdo removido com sucesso!!!",
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        } else {
                          var snack = const SnackBar(
                            content: Text(
                                "Lamento, não foi possível remover o conteúdo!!!"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      content.days,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Das ${content.initialHour} até às ${content.endHour} ",
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setAlarm({
    required String title,
    required int hour,
    required int minute,
    required bool skip,
  }) {
    FlutterAlarmClock.createAlarm(
      title: "Rotina de estudos: $title",
      hour,
      minute,
      skipUi: skip,
    );
  }
}
