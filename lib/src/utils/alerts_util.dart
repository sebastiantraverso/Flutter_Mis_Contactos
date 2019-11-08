import 'package:flutter/material.dart';

class Alerts {

    static void alertOnlyOkButton( BuildContext context, String title, List<Widget> body ) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: ( _localContext ) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text( title ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: body,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(_localContext).pop(),
              )
            ],
          );
        }
      );
  }


}