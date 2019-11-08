import 'package:flutter/material.dart';

import 'package:mis_contactos/src/models/contact_model.dart' ;
import 'package:mis_contactos/src/utils/makeCall_util.dart' as makeCall;
import 'package:mis_contactos/src/utils/sendMail_util.dart' as sendMail;


class ContactWidget extends StatefulWidget {

  final ContactModel contact;

  ContactWidget({ @required this.contact });

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {

  BuildContext _localContext;

  @override
  Widget build(BuildContext context) {

    Size _screen = MediaQuery.of(context).size;
    _localContext = context;


    return Row(
        children: <Widget>[
          // inicial, avatar
          Container(
            padding: EdgeInsets.only(right: 3.0),
            width: _screen.width * .12 ,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // TODO: colocar la inicial dentro de un circulo
                Text( 
                  widget.contact.name.substring(0,2),
                  style: TextStyle( fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                 ), 
              ],
            ),
          ),
          
          // datos contacto
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                    width: _screen.width * .85,
                    child: Text( 
                      widget.contact.name + ' ' + widget.contact.surename,
                      style: TextStyle( fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
              ),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Container(
                    width: _screen.width * .85,
                    child: Text( 
                      ( ( widget.contact.phone == 0) ? '' : widget.contact.phone.toString() ) + ' / ' + widget.contact.email, 
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),

              // fila de Botones
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                  IconButton(
                    icon: Icon( Icons.edit, color: Colors.red,),
                    tooltip: 'Edit',
                    onPressed: () => Navigator.pushNamed(context, 'contact', arguments: widget.contact), 
                  ),
                  
                  SizedBox( width: _screen.width * .12 ),
                  
                  IconButton(
                    icon: Icon( Icons.mail_outline, color: Colors.white,),
                    tooltip: 'Mail',
                    onPressed: ( widget.contact.email == '' ) ? null : _sendMail,  
                  ),
                  
                  SizedBox( width: _screen.width * .12 ),
                  
                  IconButton(
                    icon: Icon( Icons.call, color: Colors.green,),
                    tooltip: 'Llamar', 
                    onPressed: ( widget.contact.phone == 0 ) ? null : _makeCall ,
                  ),
                
                ],
                
              )
            ],
          ),
        ],

      );
  }


  _makeCall() async {
    makeCall.MakeCall _call = new makeCall.MakeCall( _localContext, widget.contact.phone.toString());
    _call.makeCall();
  }

  _sendMail() {
    sendMail.SendMail _mail = new sendMail.SendMail(_localContext, widget.contact.email);
    _mail.sendMail();
  }


}