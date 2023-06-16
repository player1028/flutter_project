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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = items[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}'),),
              title: Text(item['title']),
              subtitle: Text(item['description']),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateAddPage(context);
        },
        label: Text('Add todo'),
      ),
    );
  }

  void navigateAddPage(context) {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    Navigator.push(context, route);
  }

  Future<void> fetchData() async {
    final url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map;
      var result = json['items'];
      setState(() {
        items = result;
      });
    }
  }
}
