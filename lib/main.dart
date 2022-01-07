import 'package:dynamic_form_generator/FieldTypes.dart';
import 'package:dynamic_form_generator/form_generator.dart';
import 'package:dynamic_form_generator/modal/error_message_modal.dart';
import 'package:dynamic_form_generator/modal/field_modal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic form generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Form builder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final data = [
    FieldModal(
      key: 'userName',
      label: 'User Name',
    ),
    FieldModal(
      key: 'email',
      label: 'Email address',
      regEx: "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      isRequired: true,
    ),
    FieldModal(
      key: 'password',
      label: 'Password',
      type: FieldTypes.PASSWORD,
      isRequired: true,
      errorMessage: ErrorMessageModal(
        emptyMessage: 'Please enter Password hase',
        invalidData: 'Please enter valid password',
      ),
    ),
    FieldModal(
      key: 'address',
      label: 'Address',
      type: FieldTypes.MULTILINE,
      isRequired: true,
      errorMessage: ErrorMessageModal(
        emptyMessage: 'Please enter Password hase',
        invalidData: 'Please enter valid password',
      ),
    ),
    FieldModal(
      key: 'phone',
      label: 'phone',
      isRequired: true,
      errorMessage: ErrorMessageModal(
        emptyMessage: 'Please enter Password hase',
        invalidData: 'Please enter valid password',
      ),
      textInputType: TextInputType.number,
      maxLength: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FormBuilder(
          data: data,
          title: 'Registration',
          subDescription: 'Please provide your information to continue',
          image:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Google_Images_2015_logo.svg/1200px-Google_Images_2015_logo.svg.png',
        ),
      ),
    );
  }
}
