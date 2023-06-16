import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/todolist.dart';
import 'package:untitled/screens/todolist.dart';


class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController describeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Describe'),
            keyboardType: TextInputType.multiline,
            controller: describeController,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            postData();
          }, child: Text('Submit'))
        ],
      ),
    );
  }



  Future<void> postData() async {
    final title = titleController.text;
    final description = describeController.text;
    final body = {
      'title': title,
      'description': description,
      'is_completed': false,
    };

    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json'
        }
    );


    void showSuccessMessage(String message) {
      titleController.text = '';
      describeController.text = '';
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    void showErrorMessage(String message) {
      final snackBar = SnackBar(content: Text(message,
        style: TextStyle(color: Colors.white),
      ), backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    if(response.statusCode == 201) {
      showSuccessMessage('Success');
    } else {
      showErrorMessage('Error');
    }


  }
}
