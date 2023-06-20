import 'package:flutter/material.dart';
import 'package:untitled/style/text_style.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(5),
        children: [
          DrawerHeader(
            child: Text('Hello'),
          ),
          Card(
            child: ElevatedButton(
              child: ListTile(
                title: ElevatedButtonTextStyle(
                    'Home'
                ),
              ),
              onPressed: (){},
            ),
          ),
          Card(
            child: ElevatedButton(
              child: ListTile(
                title: ElevatedButtonTextStyle(
                    'todo'
                ),
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
    );
  }
}
