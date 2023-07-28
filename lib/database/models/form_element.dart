import 'package:form_generator/database/models/form_element_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'form_element.g.dart';

@HiveType(typeId: 1)
class FormElement extends HiveObject {
  @HiveField(0)
  String label;

  @HiveField(1)
  FormElementType type;

  @HiveField(2)
  List<String>? options = [];

  @HiveField(3)
  String? value;

  FormElement({
    required this.label,
    required this.type,
    this.value,
    this.options,
  });
}
