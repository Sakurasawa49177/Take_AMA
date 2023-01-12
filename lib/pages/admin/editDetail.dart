import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/UserLogin.dart';
import '../../services/UserAPI.dart';
import '../../utils/SnackBarHelper.dart';
import '../../utils/validatefield.dart';

class EditDetailPage extends StatefulWidget {
  const EditDetailPage({Key? key}) : super(key: key);
  @override
  State<EditDetailPage> createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  String labelFirstName = "First name";
  String labelLastName = "Last name";
  String labelUserName = "User Name";
  String labelPassword = "Password";
  String labelConfirmPassword = "Confirm password";
  String labelEmail = "Email";
  String labelDetail = "About me";
  String labelBirthday = "Birthday (Year)";
  String labelTaxID = "Tax ID.";

  var _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _keyform,
          child: ListView(
            children: [
              TextFormField(
                initialValue: profile.firstName,
                validator: ValidateField.validateString,
                decoration: InputDecoration(
                  labelText: labelFirstName,
                  hintText: labelFirstName,
                ),
                onSaved: (String? value) {
                  profile.firstName = value!;
                },
              ),
              TextFormField(
                initialValue: profile.lastName,
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  profile.lastName = value!;
                },
                decoration: InputDecoration(
                  labelText: labelLastName,
                  hintText: labelLastName,
                ),
              ),
              TextFormField(
                initialValue: profile.taxId,
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  profile.taxId = value!;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(13)
                ],
                decoration: InputDecoration(
                  labelText: labelTaxID,
                  hintText: labelTaxID,
                ),
              ),
              TextFormField(
                initialValue: profile.email,
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  profile.email = value!;
                },
                decoration: InputDecoration(
                  labelText: labelEmail,
                  hintText: labelEmail,
                ),
              ),
              TextFormField(
                initialValue: profile.detail,
                validator: ValidateField.validateString,
                onSaved: (String? value) {
                  profile.detail = value!;
                },
                decoration: InputDecoration(
                  labelText: labelDetail,
                  hintText: labelDetail,
                ),
              ),
              TextFormField(
                initialValue: profile.birthDay,
                keyboardType: TextInputType.number,
                validator: ValidateField.validateNumber,
                onSaved: (String? value) {
                  profile.birthDay = value;
                },
                decoration: InputDecoration(
                  labelText: labelBirthday,
                  hintText: labelBirthday,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _update(profile);
                },
                child: const Text('submit'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  delete(profile.id);
                },
                child: const Text('Delete'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _update(Profile profile) async {
    if (_keyform.currentState!.validate()) {
      _keyform.currentState!.save();
      String res = await UserAPI.update(profile);
      Alert.show(context: context, msg: res);
      Navigator.pop(context);
    }
  }

  void delete(String? id) async {
    await UserAPI.delete(id!);
    Navigator.pop(context);
  }
}
