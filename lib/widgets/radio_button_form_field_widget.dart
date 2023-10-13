import 'package:flutter/material.dart';
import 'package:form_generator/models/form_element_model.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';

class RadioButtonFormFieldWidget extends StatefulWidget {
  final FormElementModel element;
  TextEditingController? controller;
  RadioButtonFormFieldWidget(
      {super.key, required this.element, this.controller});

  @override
  State<RadioButtonFormFieldWidget> createState() =>
      _RadioButtonFormFieldWidgetState();
}

class _RadioButtonFormFieldWidgetState
    extends State<RadioButtonFormFieldWidget> {
  // final SliverGridDelegate delegate =
  //     const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
  String groupValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.element.label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        if (widget.element.options.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.element.options.split(",").length,
            itemBuilder: (BuildContext context, int index) {
              final value = widget.element.options.split(",")[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    GFRadio(
                      size: GFSize.MEDIUM,
                      value: value, // Use the value from element.values
                      groupValue: groupValue,
                      onChanged: (newValue) {
                        setState(() {
                          groupValue = newValue;
                          widget.controller!.text = groupValue;
                          print(widget.controller!.text);
                        });
                      },
                      inactiveIcon: null,
                      activeBorderColor: GFColors.SUCCESS,
                      radioColor: GFColors.SUCCESS,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

        // SizedBox(
        //   height: MediaQuery.of(context).size.height / 8,
        //   child: GridView.builder(
        //     gridDelegate: delegate,
        //     padding: const EdgeInsets.all(0),
        //     itemCount: widget.element.options.length,
        //     itemBuilder: (context, index) {
        //       return RadioListTile(
        //         groupValue: widget.controller!.text,
        //         title: Text(widget.element.options[index]),
        //         value: widget.element.options[index],
        //         onChanged: (newIndex) {
        //           setState(() {
        //             widget.controller!.text = newIndex!;
        //           });
        //         },
        //       );
        //     },
        //   ),
        // )