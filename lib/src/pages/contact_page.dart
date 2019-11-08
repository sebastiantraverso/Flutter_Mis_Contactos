import 'package:flutter/material.dart';

import 'package:mis_contactos/src/bloc/contact_bloc.dart';
import 'package:provider/provider.dart' as prov;

import 'package:mis_contactos/src/models/contact_model.dart';
import 'package:mis_contactos/src/providers/db_provider.dart';
import 'package:mis_contactos/src/utils/makeCall_util.dart' as makeCall;
import 'package:mis_contactos/src/utils/validations_util.dart';
import 'package:mis_contactos/src/providers/selectedTheme.dart';



class ContactPage extends StatefulWidget {

  @override
  _ContactPageState createState() => _ContactPageState();
}


class _ContactPageState extends State<ContactPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ContactBloc contactBloc = ContactBloc();
  ContactModel contacto = new ContactModel();

  OutlineInputBorder _outLineBorder = new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),);
  
  String _title;
  bool _guardando = false;

  SelectedTheme selectedTheme;


  @override
  Widget build(BuildContext context) {

    selectedTheme = prov.Provider.of<SelectedTheme>(context);
    final _screen = MediaQuery.of(context).size;

    final contactData = ModalRoute.of(context).settings.arguments;
    if ( contactData != null) {
      contacto = contactData;
      setState(() => _title = 'Editar Contacto');
    } else {
      setState(() => _title = 'Crear Contacto');
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text( _title ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: ( contactData == null ) ? null : _deleteContact,  
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric( vertical: 15.0, horizontal: 10.0),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0,),
                _crearNombre(),
                SizedBox(height: 10.0,),
                _crearApellido(),
                SizedBox(height: 10.0,),
                _crearPhone(),
                SizedBox(height: 10.0,),
                _crearEmail(),
                SizedBox(height: 10.0,),
                _crearSecondPhone(),
                SizedBox(height: 20.0,),
                _crearBotones( context, _screen, selectedTheme ),
              ],
            ),
          ),
        ),
      ),
      
    );
  
  }
  
  
  
  Widget _crearNombre() {
    return TextFormField(
      initialValue: contacto.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: _outLineBorder,
        labelText: 'Nombre',
        hintText: 'Nombre del contacto',
        icon: Icon( Icons.person)
      ),
      maxLength: 45,
      onSaved: ( value ) => contacto.name = value,
      validator: ( value ) {
        if ( value.length < 2 ) {
          return 'El nombre debe tener al menos 2 caracteres.';
        } else {
          return null;
        }
      },
    );
  }


 
  Widget _crearApellido() {
    return TextFormField(
      initialValue: contacto.surename,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: _outLineBorder,
        labelText: 'Apellido',
        hintText: 'Apellido del contacto',
        icon: Icon( Icons.person_outline)
      ),
      maxLength: 45,
      onSaved: ( value ) => ( value != null ) ? contacto.surename = value : contacto.surename = '',
    );
  }



  Widget _crearPhone() {
    return TextFormField(
      initialValue: ( contacto.phone == null || contacto.phone == 0 ) ? '' : contacto.phone.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: _outLineBorder,
        labelText: 'Número telefónico',
        icon: Icon( Icons.phone_android)
      ),
      maxLength: 20,
      onSaved: ( value ) => ( value != '' ) ? contacto.phone = Validations.phoneEliminateSimbols( value ) : contacto.phone = 0 ,
     );
  }



  Widget _crearEmail() {
    return TextFormField(
      initialValue: contacto.email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: _outLineBorder,
        labelText: 'Correo electrónico',
        hintText: 'E-mail',
        icon: Icon( Icons.mail_outline)
      ),
      maxLength: 45,
      onSaved: ( value ) => ( value != '' ) ? contacto.email = value : contacto.email = '' ,
      validator: ( value ) {
        if ( value != '' ) {
          if ( ! Validations.validMail( value ) ) {
            return 'El mail no es valido';
          } else {
            return null;
          }         
        } else {
          return null;
        }
      }
      ,
    );
  }


  
  Widget _crearSecondPhone() {
    return TextFormField(
      initialValue: ( contacto.secondPhone == null || contacto.secondPhone == 0 ) ? '' : contacto.secondPhone.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: _outLineBorder,
        labelText: 'Número alternativo',
        icon: Icon( Icons.settings_phone)
      ),
      maxLength: 20,
      onSaved: ( value ) => ( value != '' ) ? contacto.secondPhone = Validations.phoneEliminateSimbols( value ) : contacto.secondPhone = 0 ,
    );
  }



  Widget _crearBotones( BuildContext context, Size screen, SelectedTheme selectedTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: screen.width * .32,
          child: RaisedButton.icon(
            icon: Icon( Icons.settings_phone),
            label: Text('Alternativo', style: TextStyle(fontSize: 11),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            textColor: selectedTheme.textButtonColor,
            onPressed: ( contacto.secondPhone == 0 ||contacto.secondPhone == null || _guardando ) ? null : _makeCall,
          ),
        ),

        Container(
          width: screen.width * .29,
          child: RaisedButton.icon(
            icon: Icon( Icons.cancel),
            label: Text('Cancelar', style: TextStyle(fontSize: 11),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            textColor: selectedTheme.textButtonColor,
            onPressed: ( _guardando ) ? null : _cancelCreateOrModify ,
          ),
        ),
        
        Container(
          width: screen.width * .28,
          child: RaisedButton.icon(
            icon: Icon( Icons.check_circle_outline),
            label: Text('Guardar', style: TextStyle(fontSize: 11),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            textColor: selectedTheme.textButtonColor,
            onPressed: ( _guardando ) ? null : _submit,
          ),
        ),
      ],
    );
  }



  void _submit() {
    if ( !formKey.currentState.validate() ) return ;

    formKey.currentState.save();

    setState(() => _guardando = true );

    if ( contacto.id == null ) {
      contactBloc.addContact( contacto );
    } else {
      contactBloc.updateContact( contacto );
    }

    print('paso el Submit');
    setState(() => _guardando = true );

    showNotification( 'Contacto guardado' );
    Future.delayed( new Duration(milliseconds: 1500), () => Navigator.pop(context) );
  }



  void showNotification( String message ) {
    final snackBar = SnackBar(
      content: Text( message ),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar( snackBar );
  }



  _makeCall() async {
    makeCall.MakeCall _call = new makeCall.MakeCall( context, contacto.secondPhone.toString());
    _call.makeCall();
  }

  
  _deleteContact() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ( _localContext ) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text( 'Eliminar contacto!!' ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Confirma que desea eliminar el contacto ${contacto.name} ${contacto.surename} ?'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => ( Navigator.pop(context) ),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () { contactBloc.deleteContact( contacto.id );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } ,
              ),
            ],
          );
        }
      );
  }


  _cancelCreateOrModify() {
    String msg;

    if ( contacto.id == null ) {
      msg = 'Desea cancelar la creación del contacto?';
    } else {
      msg = 'Desea cancelar la modificación del contacto?';
    }

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ( _localContext ) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text( 'Cancelar!!' ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text( msg ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => ( Navigator.pop(context) ),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () { Navigator.pop(context);
                                Navigator.pop(context); 
                              },
              ),
            ],
          );
        }
      );
  }


}