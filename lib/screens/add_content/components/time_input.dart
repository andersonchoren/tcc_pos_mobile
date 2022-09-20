import 'package:flutter/material.dart';

class TimeInput extends StatefulWidget {
  String title;
  final inputController = TextEditingController();
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
                  widget.inputController.text = "${time.hour}:${time.minute}";
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
