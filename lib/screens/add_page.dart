import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



class AddTodoPage extends StatefulWidget {

  final Map? todo;

  const AddTodoPage({
    super.key,
    this.todo,
  });



  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;


  @override
  void initState() {
    super.initState();
    if(widget.todo != null) {
      isEdit = true;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit todo' : 'Add todo'
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Decoration'),
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                isEdit ? updateData() : postData();
              },
              child: Text(
               isEdit ? 'Edit' : 'Submit'
              ))
        ],
      ),
    );
  }


  Future<void> updateData() async {
    final todo = widget.todo;
    if(todo == null){
      print('Null object');
      return;
    }
    final title = titleController.text;
    final description = descriptionController.text;
    final id = todo['_id'];
    final isCompleted = todo['is_completed'];
    final body = {
      'title': title,
      'description': description,
      'is_completed': isCompleted
    };


    final url = 'http://api.nstack.in/v1/todos/${id}';
    final uri = Uri.parse(url);
    final response = await http.put(uri);
    if(response.statusCode == 200) {
      showSuccessMessage('Success');
    } else {
      showErrorMessage('Error');
    }
  }



  Future<void> postData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      'title': title,
      'description': description,
      'is_completed': false
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

    if(response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Success');
    } else{
      showErrorMessage('Can not save that');
    }
  }


  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
