import 'package:hive_flutter/hive_flutter.dart';
part 'form_element_type.g.dart';

@HiveType(typeId: 2)
enum FormElementType {
  @HiveField(0)
  description,
  @HiveField(1)
  shortText,
  @HiveField(2)
  multiLineText,
  @HiveField(3)
  radioButton,
  @HiveField(4)
  checkBox
}
