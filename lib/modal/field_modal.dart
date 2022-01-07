import 'package:dynamic_form_generator/FieldTypes.dart';
import 'package:dynamic_form_generator/modal/error_message_modal.dart';
import 'package:flutter/material.dart';

class FieldModal {
  final String key;
  final String label;
  final String placeholder;
  final FieldTypes type;
  final bool isRequired;
  final ErrorMessageModal? errorMessage;
  final TextInputType textInputType;
  final int? maxLength;
  final int? minLength;
  final String? regEx;

  FieldModal({
    required this.key,
    required this.label,
    this.placeholder = '',
    this.type = FieldTypes.TEXT,
    this.isRequired = false,
    this.errorMessage,
    this.textInputType = TextInputType.text,
    this.maxLength,
    this.minLength,
    this.regEx,
  });
}
