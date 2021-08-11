import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final Function? validator;
  final bool enable;
  final TextInputType? keyboardType;

  const InputField({
    required this.controller,
    this.hintText,
    this.onChanged,
    required this.validator,
    this.enable = true,
    this.keyboardType = TextInputType.emailAddress,
  });
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  var val;
  @override
  void initState() {
    val = widget.validator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: TextFormField(
        enabled: widget.enable,
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: val == null ? null : val,
        keyboardType: widget.keyboardType,
        cursorColor: mainColor,
        style: TextStyle(color: kWhite),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kHintTextColor),
          filled: true,
          fillColor: kTextFieldColor,
          errorStyle: TextStyle(color: errorColor),
          //No Error
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kTextFieldColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.0),
          ),
          //Error
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor, width: 1.0),
          ),
        ),
      ),
    );
  }
}
