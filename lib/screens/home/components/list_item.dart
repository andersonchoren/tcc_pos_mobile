import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/screens/content_details/content_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ListItem extends StatelessWidget {
  Discipline discipline;
  ListItem({
    super.key,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/${discipline.icon}.svg"),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discipline.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Chip(
                        label: Text(
                          (discipline.numberOfContents != 1)
                              ? "${discipline.numberOfContents} ${translate("home.list_item.contents")}"
                              : "${discipline.numberOfContents} ${translate("home.list_item.content")}",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return ContentDetails(
                          discipline: discipline,
                        );
                      }),
                    ),
                  );
                },
                icon: Icon(
                  Icons.chevron_right,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String convertNumber(int number) {
  if (number < 9) {
    return "0$number";
  }
  return number.toString();
}
