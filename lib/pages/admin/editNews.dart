import 'package:flutter/material.dart';

import '../../models/News.dart';
import '../../services/NewsAPI.dart';
import '../../utils/SnackBarHelper.dart';
import '../../utils/validatefield.dart';

class EditNews extends StatefulWidget {
  const EditNews({Key? key}) : super(key: key);

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    News news = ModalRoute.of(context)!.settings.arguments as News;
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
                  initialValue: news.title,
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
                  initialValue: news.description,
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
                  onPressed: () {
                    _submit(news);
                  },
                ),
              ),
              ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text('Delete'),
                  onPressed: () {
                    _delete(news.id!);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _delete(String id) async {
    String msg = await NewsAPI.delete(id);
    Alert.show(context: context, msg: msg);
    Navigator.pop(context);
  }

  _submit(News news) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String msg = await NewsAPI.update(news);
      Alert.show(context: context, msg: msg);
      Navigator.pop(context);
    }
  }
}
