import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  int? token;


  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Login'),
            controller: loginController,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Password'),
            controller: passwordController,
          )
        ],
      ),
    );
  }

  Future<void> login() async {
    final login = loginController.text;
    final password = passwordController.text;
    final body = {
      'username': login,
      'password': password,
    };

    final url = 'http://10.0.2.2:8000/auth/token/login';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
    );

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map;
      final json = body['auth_token'];
      setState(() {
        token = json;
      });
      print('token');
    } else {
      print('Error');
    }
  }
}
