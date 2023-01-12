import 'package:flutter/material.dart';

import '../../utils/storageLocal.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              StorageLocal.clearUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
          )
        ],
      ),
    );
  }
}
