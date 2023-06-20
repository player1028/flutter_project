import 'package:flutter/material.dart';
import 'package:untitled/widgets/drawer.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add page'),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: Text('hello'),
    );
  }
}
