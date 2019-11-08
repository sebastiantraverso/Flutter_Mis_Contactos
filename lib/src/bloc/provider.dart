import 'package:flutter/material.dart';
import 'package:mis_contactos/src/bloc/contact_bloc.dart';
export 'package:mis_contactos/src/bloc/contact_bloc.dart';


class Provider extends InheritedWidget {

  
  final contacBloc = ContactBloc();

  Provider( {Key key, Widget child} )
    : super( key: key, child: child);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  static ContactBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).contacBloc;
  }



}