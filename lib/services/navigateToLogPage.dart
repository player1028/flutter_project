import 'package:flutter/material.dart';
import 'package:untitled/screens/auth_page.dart';



void navigateToAuthPage(context) {
  final route = MaterialPageRoute(builder: (context) => AuthPage());
  Navigator.push(context, route);
}