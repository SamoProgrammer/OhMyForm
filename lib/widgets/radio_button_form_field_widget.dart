import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element.dart';

class RadioButtonFormFieldWidget extends StatefulWidget {
  final FormElement element;
  const RadioButtonFormFieldWidget({super.key, required this.element});

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.element.label,
          style: const TextStyle(fontSize: 16),
        ),
        if (widget.element.options.isNotEmpty)
          GridView.builder(
            gridDelegate: delegate,
            padding: const EdgeInsets.all(0),
            itemCount: widget.element.options.length,
            itemBuilder: (context, index) {
              return RadioListTile(
                groupValue: widget.element.value,
                title: Text(widget.element.options[index]),
                value: widget.element.options[index],
                onChanged: (newIndex) {
                  setState(() {
                    widget.element.value = newIndex;
                  });
                },
              );
            },
          )
      ],
    );
  }
}
