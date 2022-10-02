import 'package:agenda_de_estudos/model/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TimeInput extends StatefulWidget {
  String title;
  final inputController = MaskedTextController(mask: "00:00");
  TimeInput({
    super.key,
    required this.title,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.inputController,
                validator: (value) => validateTimeInput(
                  value!,
                  translate("form.time_input"),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.schedule),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  var hour = (time.hour < 9) ? "0${time.hour}" : time.hour;
                  var minutes =
                      (time.minute < 9) ? "0${time.minute}" : time.minute;
                  widget.inputController.text = "$hour:$minutes";
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
