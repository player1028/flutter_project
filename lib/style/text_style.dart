import 'package:flutter/material.dart';



class ElevatedButtonTextStyle extends StatelessWidget {
  final String text;

  const ElevatedButtonTextStyle(
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

