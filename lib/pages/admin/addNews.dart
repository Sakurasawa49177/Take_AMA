import 'package:flutter/material.dart';
import 'package:take_ama/services/NewsAPI.dart';
import 'package:take_ama/utils/SnackBarHelper.dart';
import 'package:take_ama/utils/validatefield.dart';

import '../../models/News.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  News news = News();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add news'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title: TextFormField(
                  validator: ValidateField.validateString,
                  decoration: const InputDecoration(
                    labelText: 'title',
                    hintText: 'title',
                  ),
                  onSaved: (String? v) {
                    news.title = v;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  validator: ValidateField.validateString,
                  decoration: const InputDecoration(
                    labelText: 'description',
                    hintText: 'description',
                  ),
                  onSaved: (String? v) {
                    news.description = v;
                  },
                ),
              ),
              ListTile(
                title: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: _submit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String msg = await NewsAPI.create(news);
      Alert.show(context: context, msg: msg);
      Navigator.pop(context);
    }
  }
}
