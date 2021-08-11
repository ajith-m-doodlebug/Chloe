import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';

class SubExpenditureTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double total;

  SubExpenditureTile({
    required this.text,
    required this.icon,
    required this.color,
    required this.total,
  });

  @override
  _SubExpenditureTileState createState() => _SubExpenditureTileState();
}

class _SubExpenditureTileState extends State<SubExpenditureTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.icon,
          color: widget.color,
          size: 40.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: widget.color,
                fontSize: 20.0,
              ),
            ),
            Text(
              'Spend: ${widget.total}',
              style: TextStyle(
                color: kWhite,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
