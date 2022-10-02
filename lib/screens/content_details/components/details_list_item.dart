import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
                              title: Text(
                                translate(
                                  "details_list_item.alert.title",
                                ),
                              ),
                              content: Text(
                                translate(
                                  "details_list_item.alert.content",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    skip = false;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    translate(
                                      "details_list_item.alert.button.yes",
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    translate(
                                      "details_list_item.alert.button.no",
                                    ),
                                  ),
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
                        await removeDialog(context);
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
                      "${translate(
                        "details_list_item.time.first",
                      )} ${content.initialHour} ${translate(
                        "details_list_item.time.last",
                      )} ${content.endHour}",
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

  Future<void> removeDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            translate(
              "remove_alert.title",
            ),
          ),
          content: Text(
            translate(
              "remove_alert.content",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                translate(
                  "remove_alert.cancel_button",
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                translate(
                  "remove_alert.confirm_button",
                ),
              ),
              onPressed: () async {
                int result = await removeContent();
                if (result != 0) {
                  var snack = SnackBar(
                    content: Text(
                      translate(
                        "details_list_item.content_remove_success",
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                } else {
                  var snack = SnackBar(
                    content: Text(
                      translate(
                        "details_list_item.content_remove_fail",
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> removeContent() async {
    return await ContentRepository.removeContent(
      content.id!,
      discipline.name,
    );
  }

  void setAlarm({
    required String title,
    required int hour,
    required int minute,
    required bool skip,
  }) {
    FlutterAlarmClock.createAlarm(
      title: "${translate(
        "details_list_item.alarm_title",
      )}: $title",
      hour,
      minute,
      skipUi: skip,
    );
  }
}
