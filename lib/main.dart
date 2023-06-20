import 'package:flutter/material.dart';
import 'package:untitled/screens/home_page.dart';


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple
        )
      ),
      home: HomePage(),
    );
  }
}
