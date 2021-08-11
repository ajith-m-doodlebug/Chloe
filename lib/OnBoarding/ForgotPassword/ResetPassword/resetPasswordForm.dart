import 'package:fin_tech_app/CreatedWidgets/inputPassword.dart';
import 'package:fin_tech_app/CreatedWidgets/longButton.dart';
import 'package:fin_tech_app/OnBoarding/LogIn/logIn.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class ResetPasswordForm extends StatefulWidget {
  final String name;
  final String email;
  final String userID;

  ResetPasswordForm({
    required this.name,
    required this.email,
    required this.userID,
  });

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _password1C = TextEditingController();
  final _password2C = TextEditingController();

  bool _loading = false;

  static final RegExp _password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  _resetPassword() async {
    usersInstance.doc(widget.userID).update({
      'password': _password1C.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputPassword(
            controller: _password1C,
            hintText: 'Enter new password',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the password';
              }
              if (!_password.hasMatch(value)) {
                return 'Password must be at least 8 characters. \n'
                    'With minimum one uppercase, one lowercase, \n'
                    'one number and one special character.';
              }
              return null;
            },
          ),
          InputPassword(
            controller: _password2C,
            hintText: 'Confirm Password',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please retype the password';
              }
              if (value != _password1C.text) {
                return 'Please retype the password correctly';
              }
              return null;
            },
          ),
          LongButton(
            text: 'Reset password',
            loading: _loading,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _loading = true;
                });
                await _resetPassword();
                setState(() {
                  _loading = false;
                });
                Navigator.pushAndRemoveUntil(
                    context, RightSlide(page: LogIn()), (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
