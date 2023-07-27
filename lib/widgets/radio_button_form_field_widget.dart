import 'package:flutter/material.dart';

class RadioButtonFormFieldWidget extends StatefulWidget {
  final List<String> options;
  final String lable;
  int? value;
  RadioButtonFormFieldWidget({
    super.key,
    required this.options,
    required this.lable,
  });

  @override
  State<RadioButtonFormFieldWidget> createState() =>
      _RadioButtonFormFieldWidgetState();
}

class _RadioButtonFormFieldWidgetState
    extends State<RadioButtonFormFieldWidget> {
  final SliverGridDelegate delegate =
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.lable,
          style: const TextStyle(fontSize: 16),
        ),
        GridView.builder(
          gridDelegate: delegate,
          padding: const EdgeInsets.all(0),
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              groupValue: widget.value,
              title: Text(widget.options[index]),
              value: index,
              onChanged: (newIndex) {
                setState(() {
                  widget.value = newIndex;
                });
              },
            );
          },
        )
      ],
    );
  }
}
