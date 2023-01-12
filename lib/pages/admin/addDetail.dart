import 'package:flutter/material.dart';
import 'package:take_ama/models/User.dart';

import '../../services/UserAPI.dart';
import '../../utils/SnackBarHelper.dart';
import '../../utils/validatefield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User user = User();
  String labelFirstName = "First name";
  String labelLastName = "Last name";
  String labelUserName = "User Name";
  String labelPassword = "Password";
  String labelConfirmPassword = "Confirm password";
  String labelEmail = "Email";
  String labelDetail = "About me";
  String labelBirthday = "Birthday (Year)";

  final _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _keyform,
          child: ListView(
            children: [
              TextFormField(
                validator: ValidateField.validateString,
                decoration: InputDecoration(
                  labelText: labelFirstName,
                  hintText: labelFirstName,
                ),
                onSaved: (String? value) {
                  user.firstName = value!;
                },
              ),
              TextFormField(
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  user.lastName = value!;
                },
                decoration: InputDecoration(
                  labelText: labelLastName,
                  hintText: labelLastName,
                ),
              ),
              TextFormField(
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  user.username = value!;
                },
                decoration: InputDecoration(
                  labelText: labelUserName,
                  hintText: labelUserName,
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  user.password = value!;
                },
                decoration: InputDecoration(
                  labelText: labelPassword,
                  hintText: labelPassword,
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: ValidateField.validateString,
                decoration: InputDecoration(
                  labelText: labelConfirmPassword,
                  hintText: labelConfirmPassword,
                ),
              ),
              TextFormField(
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  user.email = value!;
                },
                decoration: InputDecoration(
                  labelText: labelEmail,
                  hintText: labelEmail,
                ),
              ),
              TextFormField(
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  user.detail = value!;
                },
                decoration: InputDecoration(
                  labelText: labelDetail,
                  hintText: labelDetail,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: ValidateField.validateNumber,
                onSaved: (String? value) {
                  user.birthDay = int.parse(value!);
                },
                decoration: InputDecoration(
                  labelText: labelBirthday,
                  hintText: labelBirthday,
                ),
              ),
              RadioUserType(submit: onChangeTypeUser),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _register,
                child: Text('submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  onChangeTypeUser(String v) {
    user.userType = v;
  }

  _register() async {
    if (_keyform.currentState!.validate()) {
      _keyform.currentState!.save();
      String res = await UserAPI.register(user);
      Alert.show(context: context, msg: res);
      Navigator.pop(context);
    }
  }
}

class Memo extends StatelessWidget {
  const Memo({
    Key? key,
    required this.labelDetail,
    required this.user,
  }) : super(key: key);

  final String labelDetail;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              labelDetail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            maxLines: 5,
            validator: ValidateField.validateString,
            onSaved: (String? value) {
              user.detail = value!;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}

enum SingingCharacter { customer, careTaker }

class RadioUserType extends StatefulWidget {
  final Function submit;
  const RadioUserType({super.key, required this.submit});

  @override
  State<RadioUserType> createState() => _RadioUserTypeState();
}

class _RadioUserTypeState extends State<RadioUserType> {
  SingingCharacter? _character = SingingCharacter.customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Customer'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.customer,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                widget.submit('1');
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Care Taker'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.careTaker,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                widget.submit('2');
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
