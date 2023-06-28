import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/widgets/drawer.dart';
import 'package:untitled/style/text_style.dart';
import 'package:untitled/screens/auth_page.dart';
import 'package:untitled/services/token_manager.dart';




class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List items = [];

  @override
  void initState() {
    super.initState();
    fetchRandword();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite words'),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: fetchRandword,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index){
            final item = items[index];
            final id = item['id'];
            return ListTile(
              title: Container(
                child: Row(
                  children: [
                    Expanded(child: TopTextStyle(item['word'])),
                    IconButton(onPressed: (){
                      deleteByID(id);
                      fetchRandword();
                    }, icon: Icon(Icons.delete, color: Colors.white70,),
                    )
                  ],
                ),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
            );
          },
        ),
      )
    );
  }

  Future<void> deleteByID(int id) async {
    String? token = await TokenManager.getToken();
    final url = 'http://10.0.2.2:8000/api/del/${id}/';
    final uri = Uri.parse(url);
    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Token $token'
      }
    );

    if(response.statusCode==204) {
      List filtrated = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtrated;
      });
    } else {
      showErrorMessage('Can\'t delete');
    }
  }


  Future<void> fetchRandword() async {
    String? token = await TokenManager.getToken();
    final url = 'http://10.0.2.2:8000/api/def/';
    final uri = Uri.parse(url);
    final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Token $token',
        }
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      setState(() {
        items = body;
      });
    } else {
      print('Error');
    }
  }



  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
