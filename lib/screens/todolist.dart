import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/screens/add_page.dart';
import 'package:http/http.dart' as http;


class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List items = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              final item = items[index];
              final id = item['_id'];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}'),),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if(value == 'edit') {

                    } else if(value == 'delete') {
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 'delete',
                      )
                    ];
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateAddPage(context);
          },
          label: Text('Add todo')
      ),
    );
  }

  void navigateAddPage(context) {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map;
      final result = body['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }




  Future<void> deleteById(id) async {
    final url = 'http://api.nstack.in/v1/todos/${id}';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200) {
      final filtrated = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtrated;
      });
    } else {
      showErrorMessage('Unable to delete');
    }
  }


  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(
        color: Colors.white,
      ),),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
