import 'package:flutter/material.dart';
import 'package:untitled/widgets/drawer.dart';
import 'package:untitled/widgets/big_card.dart';
import 'package:english_words/english_words.dart';
import 'package:untitled/style/text_style.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String pair = '';

  void newRandomWord() {
    WordPair randomWord = WordPair.random();
    setState(() {
      pair = randomWord.asLowerCase;
    });
  }

  @override
  void initState() {
    super.initState();
    newRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add page'),
        centerTitle: true,
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
                ElevatedButton(onPressed: () {
                  newRandomWord();
                }, child: Text('Next'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

