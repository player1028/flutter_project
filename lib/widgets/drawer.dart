import 'package:flutter/material.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/style/text_style.dart';
import 'package:untitled/main.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
        padding: EdgeInsets.all(5),
        children: [
          DrawerHeader(
            child: CircleAvatar(
              child: Image.asset('images/account.png', height: 170, width: 170,),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            title: Align(child: Text('Omarbek Nurkut')),
          ),
          Card(
            child: ElevatedButton(
              child: ListTile(
                title: TopTextStyle(
                    'Home'
                ),
              ),
              onPressed: (){
                final route = MaterialPageRoute(builder: (context) => HomePage());
                Navigator.push(context, route);
              },
            ),
          ),
          Card(
            child: ElevatedButton(
              child: ListTile(
                title: TopTextStyle(
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
