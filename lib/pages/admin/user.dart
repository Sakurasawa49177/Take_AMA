import 'package:flutter/material.dart';
import 'package:take_ama/models/UserLogin.dart';
import 'package:take_ama/services/UserAPI.dart';
import 'package:take_ama/utils/storageLocal.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
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
      body: FutureBuilder(
        future: UserAPI.getAll(),
        builder: (context, AsyncSnapshot<List<Profile?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Profile?> profiles = snapshot.data!;
          return ListView.separated(
            itemBuilder: (BuildContext context, int i) {
              Profile profile = profiles[i]!;
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/detail', arguments: profile)
                      .then((value) {
                    setState(() {});
                  });
                },
                leading: Text(profile.id!),
                title: Text('${profile.firstName!} ${profile.lastName!}'),
                trailing: Text(profile.username!),
                subtitle: Text(
                    '${profile.userType == '1' ? 'customer' : 'caretaker'} '),
              );
            },
            itemCount: profiles.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.black,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/register').then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
