import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_generator/database/models/form_element_type.dart';
import 'package:form_generator/widgets/select_field_widget.dart';

class EditFormPage extends StatefulWidget {
  const EditFormPage({super.key});

  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final List<SelectFieldWidget> selectFieldWidgets = <SelectFieldWidget>[
    const SelectFieldWidget(
        elementType: FormElementType.description,
        elementTypeIcon: FontAwesomeIcons.info,
        elementTypeName: 'توضیحات'),
    const SelectFieldWidget(
        elementType: FormElementType.multiChoice,
        elementTypeIcon: FontAwesomeIcons.listCheck,
        elementTypeName: 'چند گزینه ای'),
    const SelectFieldWidget(
        elementType: FormElementType.shortText,
        elementTypeIcon: Icons.short_text,
        elementTypeName: 'متن کوتاه'),
    const SelectFieldWidget(
        elementType: FormElementType.multiLineText,
        elementTypeIcon: Icons.text_increase,
        elementTypeName: 'متن بلند'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(left: BorderSide(width: 1, color: Colors.black))),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: const Color.fromARGB(255, 165, 207, 246),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'افزودن فیلد',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: selectFieldWidgets,
                    ),
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height,
              child: Column()),
        ],
      ),
    );
  }
}
