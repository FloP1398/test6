import 'package:flutter/material.dart';

class MainFlatButton extends StatelessWidget {
  const MainFlatButton(
      {this.title, this.color, this.textColor, @required this.onPressed});

  final Color textColor;
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Material(
        elevation: 10.0,
        child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 30.0,
                fontFamily: 'Lobster',
              ),
            ),
          ),
        ),
        color: color,
      ),
    );
  }
}
