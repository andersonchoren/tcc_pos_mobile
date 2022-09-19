import 'package:flutter/material.dart';

class TimeInput extends StatefulWidget {
  String title;
  TimeInput({
    super.key,
    required this.title,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  final inputController = TextEditingController();
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
                controller: inputController,
                enabled: false,
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
                  inputController.text = "${time.hour}:${time.minute}";
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
