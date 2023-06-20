import 'package:flutter/material.dart';


class BigCard extends StatelessWidget {
  final String pair;

  const BigCard({
    super.key,
    required this.pair
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple,
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Text(pair, style: TextStyle(
          color: Colors.white,
          fontSize: 40
        ),)
      ),
    );
  }
}
