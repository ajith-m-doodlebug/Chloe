import 'package:flutter/material.dart';
import '../Colors/colors.dart';

class LongButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const LongButton({
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  _LongButtonState createState() => _LongButtonState();
}

class _LongButtonState extends State<LongButton> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.disabled,
      };
      if (states.any(interactiveStates.contains)) {
        return mainColorDisabled;
      }
      return mainColor;
    }

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 75.0,
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        onPressed: widget.onPressed,
        child: widget.loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
      ),
    );
  }
}
