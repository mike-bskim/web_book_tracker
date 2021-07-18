import 'package:flutter/material.dart';
import 'package:flutter_web_book_tracker/src/constants/constants.dart';

class TwoSidedRoundeButton extends StatelessWidget {
  final String text;
  final double radius;
  final VoidCallback press; //Function
  final Color color;

  const TwoSidedRoundeButton(
      {Key?key,
        required this.text,
        this.radius = 30,
        required this.press,
        this.color = kBlackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius))),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ));
  }
}
