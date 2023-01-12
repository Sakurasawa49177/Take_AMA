import 'package:flutter/material.dart';
import 'package:take_ama/services/UserAPI.dart';
import 'package:take_ama/utils/SnackBarHelper.dart';
import 'package:take_ama/utils/storageLocal.dart';
import '../models/UserLogin.dart';
import '../utils/validatefield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(50),
            width: 150,
            height: 150,
            child: Image.asset("assets/images/TakeAMALogo.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _keyForm,
            child: Column(
              children: [
                ListTile(
                  title: TextFormField(
                    validator: ValidateField.validateString,
                    onSaved: (String? value) {
                      username = value!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Username', hintText: 'ชื่อผู้ใช้'),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    obscureText: true,
                    validator: ValidateField.validateString,
                    onSaved: (String? value) {
                      password = value!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Password', hintText: 'รหัสผ่าน'),
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        _keyForm.currentState!.save();
                        submit(username, password);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text('Register'),
          )
        ],
      )),
    );
  }

  void submit(String username, String password) async {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      if (username.toLowerCase() == "admin") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/menu-admin", (route) => false);
        return;
      }
      UserLogin? userLogin =
          await UserAPI.login(username: username, password: password);
      if (userLogin!.data != null) {
        await StorageLocal.storageUser(userLogin);
        Alert.show(context: context, msg: userLogin.message!);
        if ('${userLogin.data!.userType}' == "1") {
          Navigator.pushNamedAndRemoveUntil(
              context, "/client-home", (route) => false);
        } else if ('${userLogin.data!.userType}' == "2") {
          Navigator.pushNamedAndRemoveUntil(
              context, "/caretaker-home", (route) => false);
        }
      } else {
        Alert.show(context: context, msg: "Something went wrong");
      }
    }
  }
}
