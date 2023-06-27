import 'package:flutter/material.dart';



class TopTextStyle extends StatelessWidget {
  final String text;

  const TopTextStyle(
   this.text
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white
      ),
    );
  }
}








