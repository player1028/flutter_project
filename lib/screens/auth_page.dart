import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/services/token_manager.dart';


String token = '';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool _isObscure = true;
  Icon icon = Icon(Icons.visibility_off);

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
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Login'),
            controller: loginController,
          ),
          TextField(
            obscureText: _isObscure,
            obscuringCharacter: '*',
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password', suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              child: _isObscure ? Icon(Icons.visibility_off, color: Colors.grey,) :
              Icon(Icons.visibility, color: Colors.grey,),
            )
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            login();
          }, child: Text('Log in'))
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

    final url = 'http://10.0.2.2:8000/auth/token/login/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map;
      final json = body['auth_token'];
      setState(() {
        token = json;
      });
      print('$token');
      await TokenManager.saveToken(token);
      print('Ok');
    } else {
      print('Error');
    }
  }
}
