// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_element_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormElementTypeAdapter extends TypeAdapter<FormElementType> {
  @override
  final int typeId = 2;

  @override
  FormElementType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FormElementType.description;
      case 1:
        return FormElementType.shortText;
      case 2:
        return FormElementType.multiLineText;
      case 3:
        return FormElementType.multiChoice;
      default:
        return FormElementType.description;
    }
  }

  @override
  void write(BinaryWriter writer, FormElementType obj) {
    switch (obj) {
      case FormElementType.description:
        writer.writeByte(0);
        break;
      case FormElementType.shortText:
        writer.writeByte(1);
        break;
      case FormElementType.multiLineText:
        writer.writeByte(2);
        break;
      case FormElementType.multiChoice:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormElementTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
