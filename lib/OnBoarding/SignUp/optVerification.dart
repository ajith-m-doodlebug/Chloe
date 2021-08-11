import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'optVerificationForm.dart';

class OtpVerification extends StatefulWidget {
  final String email;
  final String name;
  final String password;

  const OtpVerification({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        title: Text(
          'Budget',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: 200.0,
              child: Center(
                  child: Text(
                'Otp Verification',
                style: TextStyle(fontSize: 50.0, color: mainColor),
              )),
            ),
            OtpVerificationForm(
              name: widget.name,
              email: widget.email,
              password: widget.password,
            ),
          ],
        ),
      ),
    );
  }
}
