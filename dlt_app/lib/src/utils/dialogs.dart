import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

Future<void> alertDialog(
    {@required BuildContext context, String title, @required String content}) {
  //   Platform.isIOS
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> confirmDialog(
    {@required BuildContext context,
    String title,
    @required String content}) async {
  return await showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      var alertDialog = AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
      return alertDialog;
    },
  );
}

Future<int> selectOptionDialog(
    {@required BuildContext context,
    String title,
    @required List<String> lists}) async {
  assert(lists != null);
  int index = -1;
  List<Widget> options = lists.map((String e) {
    int _index = ++index;
    print('$index $e');
    return SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, _index);
      },
      child: Text(e),
    );
  }).toList();
  /*
  options.add(SimpleDialogOption(
    child: FlatButton(
      child: const Text('ACCEPT'),
      onPressed: () {
        Navigator.of(context).pop(1);
      },
    ),
  ));
  */
  return showDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: title != null ? Text(title) : null,
        children: options,
      );
    },
  );
}
