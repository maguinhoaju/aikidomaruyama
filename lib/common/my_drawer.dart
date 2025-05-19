import 'package:flutter/material.dart';

//futura implementacao

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context); // Fechar o Drawer
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context); // Fechar o Drawer
            },
          ),
        ],
      ),
    );
  }
}
