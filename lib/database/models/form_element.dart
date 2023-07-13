import 'package:hive_flutter/hive_flutter.dart';

part 'form_element.g.dart';

@HiveType(typeId: 1)
class FormElement extends HiveObject {
  @HiveField(0)
  late String label;

  @HiveField(1)
  late Type type;

  FormElement({required this.label, required this.type});
}


