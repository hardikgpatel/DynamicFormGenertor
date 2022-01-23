import 'package:dynamic_form_generator/FieldTypes.dart';
import 'package:dynamic_form_generator/modal/error_message_modal.dart';
import 'package:dynamic_form_generator/modal/field_modal.dart';
import 'package:dynamic_form_generator/widgets/common_text_field.dart';
import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  final List<FieldModal> data;
  final String? title;
  final String? subDescription;
  final String? image;

  const FormBuilder({
    Key? key,
    required this.data,
    this.title,
    this.subDescription,
    this.image,
  }) : super(key: key);

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {

  var result = {};
  var errors = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: [
          if(widget.image != null && widget.image!.isNotEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  widget.image ?? '',
                  height: 60,
                ),
              ),
            ),
          if(widget.title!= null && widget.title!.isNotEmpty)
            Center(
              child: Text(
                widget.title ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(
            height: 5,
          ),
          if(widget.subDescription != null && widget.subDescription!.isNotEmpty)
            Center(
              child: Text(
                widget.subDescription ?? '',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          SizedBox(
            height: 15,
          ),
          ...widget.data.map((e) {
            switch (e.type) {
              case FieldTypes.TEXT:
                return CommonTextFieldWidget(
                  hintText: e.placeholder.isEmpty
                      ? 'Please enter ${e.label}'
                      : e.placeholder,
                  onTextChange: (value) {
                    result[e.key] = value;
                  },
                  isPassword: e.type == FieldTypes.PASSWORD,
                  error: errors[e.key],
                  textInputType: e.textInputType,
                  maxLength: e.maxLength,
                );
              case FieldTypes.PASSWORD:
                return CommonTextFieldWidget(
                  hintText: e.placeholder.isEmpty
                      ? 'Please enter ${e.label}'
                      : e.placeholder,
                  onTextChange: (value) {
                    result[e.key] = value;
                  },
                  isPassword: true,
                  error: errors[e.key],
                  isMultiLine: false,
                  textInputType: e.textInputType,
                  maxLength: e.maxLength,
                );
              case FieldTypes.MULTILINE:
                return CommonTextFieldWidget(
                  hintText: e.placeholder.isEmpty
                      ? 'Please enter ${e.label}'
                      : e.placeholder,
                  onTextChange: (value) {
                    result[e.key] = value;
                  },
                  isMultiLine: true,
                  error: errors[e.key],
                  textInputType: e.textInputType,
                  maxLength: e.maxLength,
                );
              default:
                return Container();
            }
          }),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.data.forEach((e) {
                  print('is ${e.label} is required => ${result[e.key]}');
                  if (e.isRequired) {
                    if (result[e.key] == null ||
                        result[e.key].toString().isEmpty) {
                      var msg = e.errorMessage?.emptyMessage ??
                          'Please enter ${e.label}';
                      errors[e.key] = msg;
                    } else if (e.regEx != null && e.regEx!.isNotEmpty) {
                      RegExp regEx = RegExp(e.regEx ?? '');
                      if(!regEx.hasMatch(result[e.key])) {
                        var msg = e.errorMessage?.invalidData ??
                            'Please enter valid ${e.label}';
                        errors[e.key] = msg;
                      }else {
                        errors[e.key] = '';
                      }
                    } else {
                      errors[e.key] = '';
                    }
                  }
                });
                setState(() {});
                print('final response of form  ==> $result');
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
