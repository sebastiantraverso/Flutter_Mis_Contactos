import 'package:flutter/material.dart';

import 'package:intent/intent.dart' as intentMail;
import 'package:intent/action.dart' as intentAction;


class SendMail {

  BuildContext context; 
  String email; 

  SendMail( BuildContext context, String email) {
    this.context = context;
    this.email = email;
  }

  void sendMail() {
    intentMail.Intent()
        ..setAction(intentAction.Action.ACTION_SENDTO)
        ..setData(Uri(scheme: 'mailto', path: email ))
        ..startActivity().catchError((e) => print(e));
  }
  
}