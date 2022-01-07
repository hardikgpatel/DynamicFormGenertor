import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonTextFieldWidget extends StatefulWidget {
  const CommonTextFieldWidget({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    required this.onTextChange,
    this.error,
    this.isMultiLine = false,
    this.maxLength,
  }) : super(key: key);

  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final ValueChanged<String> onTextChange;
  final String? error;
  final bool isMultiLine;
  final int? maxLength;

  @override
  _CommonTextFieldWidgetState createState() => _CommonTextFieldWidgetState();
}

class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPassword) {
      _obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: _obscureText,
                  keyboardType: widget.textInputType,
                  onChanged: widget.onTextChange,
                  obscuringCharacter: '*',
                  minLines: widget.isMultiLine ? 5 : 1,
                  maxLines: widget.isMultiLine ? 5 : 1,
                  maxLength: widget.maxLength,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                  ),
                ),
              ),
              Visibility(
                visible: widget.isPassword,
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/${_obscureText ? 'ic_eye_open' : 'ic_eye_closed'}.svg',
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.error != null && widget.error!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                widget.error ?? '',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
