import 'package:flutter/material.dart';
import 'package:untitled/screens/favorites_page.dart';
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
              child: Text('hello'),
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
                    'Favorites'
                ),
              ),
              onPressed: (){
                final route = MaterialPageRoute(builder: (context) => FavoritesPage());
                Navigator.push(context, route);
              },
            ),
          ),
        ],
      ),
    );
  }
}
