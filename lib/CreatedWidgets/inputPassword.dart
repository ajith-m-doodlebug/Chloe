import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final Function validator;

  const InputPassword({
    required this.controller,
    required this.hintText,
    this.onChanged,
    required this.validator,
  });

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool showPassword = true;
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
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: val == null ? null : val,
        enableSuggestions: false,
        autocorrect: false,
        obscureText: showPassword,
        cursorColor: mainColor,
        style: TextStyle(color: kWhite),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kHintTextColor),
          filled: true,
          fillColor: kTextFieldColor,
          errorStyle: TextStyle(color: errorColor),
          suffixIcon: showPassword
              ? IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: kHintTextColor,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: mainColor,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = true;
                    });
                  },
                ),
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
