import 'package:flutter/material.dart';

import '../../utils/storageLocal.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          TextButton(
            child: const Text(
              'Log off',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              StorageLocal.clearUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('News'),
            onTap: () {
              Navigator.pushNamed(context, '/news-admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('User'),
            onTap: () {
              Navigator.pushNamed(context, '/user-admin');
            },
          ),
        ],
      ),
    );
  }
}
