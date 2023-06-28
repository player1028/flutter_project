import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/widgets/drawer.dart';
import 'package:untitled/widgets/big_card.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/services/navigateToLogPage.dart';
import 'package:untitled/services/token_manager.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLiked = false;
  Icon icon = Icon(Icons.favorite_border);
  String pair = '';

  void newRandomWord() {
    WordPair randomWord = WordPair.random();
    setState(() {
      pair = randomWord.asLowerCase;
    });
  }

  void setFavoriteOutlined() {
    setState(() {
      icon = Icon(Icons.favorite_border);
      isLiked = false;
    });
  }


  @override
  void initState() {
    super.initState();
    newRandomWord();
  }




  void likeWord() {
    if(isLiked != true) {
      setState(() {
        icon = Icon(Icons.favorite);
        isLiked = true;
      });
    } else {
      setState(() {
        setFavoriteOutlined();
        isLiked = false;
      });
    }
  }


  void isLogged() {

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add page'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            navigateToAuthPage(context);
          }, icon: Icon(Icons.login))
        ],
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigCard(pair: pair,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: (){
                  likeWord();
                }, label: Text('Like'),
                icon: icon,),
                SizedBox(width: 20,),
                ElevatedButton(onPressed: () {
                  if(isLiked) {
                    postData(pair);
                  }
                  setFavoriteOutlined();
                  newRandomWord();
                }, child: Text('Next'))
              ],
            )
          ],
        ),
      ),
    );
  }



  Future<void> postData(String word) async {
    String? token = await TokenManager.getToken();

    final url = 'http://10.0.2.2:8000/api/def/';
    final uri = Uri.parse(url);
    final body = {
      'word': word
    };


    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      }
    );
    if(response.statusCode == 201){
      print('Success');
    } else {
      print('Error');
    }
  }
}

