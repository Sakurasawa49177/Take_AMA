import 'package:flutter/material.dart';
import 'package:take_ama/models/UserCount.dart';
import 'package:take_ama/services/UserAPI.dart';

class UserCountCard extends StatelessWidget {
  const UserCountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserAPI.getUserCount(),
        builder: (BuildContext context, AsyncSnapshot<UserCount?> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          UserCount? userCount = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    userCount!.userCount!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.remove_red_eye),
                ],
              ),
            ],
          );
        });
  }
}
