import 'package:flutter/material.dart';

class AlertPopup {
  static Future<void> showMyDialog(BuildContext context, String titleText,
      String content, bool isBack) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleText),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isBack) {
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class AlertPopupNonReturn {
  static Future<void> showMyDialog(
      {BuildContext? context,
        String? titleText,
        String? content,
        Function? function}) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleText!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                function!();
              },
            ),
          ],
        );
      },
    );
  }
}

class AlertPopupReturnBool {
  static Future<bool?> showMyDialog(
      BuildContext context, String titleText, String content) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleText),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
