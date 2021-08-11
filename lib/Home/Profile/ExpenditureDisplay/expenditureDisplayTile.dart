import 'package:fin_tech_app/Colors/colors.dart';
import 'package:fin_tech_app/Home/Categories/AddItem/addItem.dart';
import 'package:fin_tech_app/PageTransition/rightSlide.dart';
import 'package:flutter/material.dart';

class ExpenditureTile extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String category;

  ExpenditureTile({
    required this.text,
    required this.icon,
    required this.color,
    required this.category,
  });

  @override
  _ExpenditureTileState createState() => _ExpenditureTileState();
}

class _ExpenditureTileState extends State<ExpenditureTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: backgroundColor,
      highlightColor: backgroundColor,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: () {
        Navigator.push(
          context,
          RightSlide(
            page: AddItem(category: widget.category),
          ),
        );
      },
      child: Ink(
        height: 150.0,
        width: 150.0,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              widget.icon,
              color: widget.color,
              size: 50.0,
            ),
            Text(
              widget.text,
              style: TextStyle(fontSize: 15.0, color: widget.color),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
