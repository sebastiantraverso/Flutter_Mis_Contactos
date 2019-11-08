
import 'dart:async';

import 'package:mis_contactos/src/models/contact_model.dart';
import 'package:mis_contactos/src/providers/db_provider.dart';

class ContactBloc {

  static final ContactBloc _singleon = new ContactBloc._();

  factory ContactBloc() {
    return _singleon;
  }

  ContactBloc._(){
    getAllContacts();
  }



  final _contacController = StreamController<List<ContactModel>>.broadcast();

  Stream<List<ContactModel>> get contactStream => _contacController.stream;

  dispose() {
    _contacController?.close();
  }



  // ACTIONS
  getAllContacts() async {
    _contacController.sink.add( await DBProvider.db.getAllContacts() );
  }


  // getContact( int id) async {
  //   _contacController.sink.add( await DBProvider.db.getContactId(id) );
  // }

  addContact( ContactModel contact ) async {
    await DBProvider.db.newContact(contact);
  }

  updateContact( ContactModel contact ) async {
    await DBProvider.db.updateContac(contact);
    getAllContacts();
  }

  deleteContact( int id) async {
    await DBProvider.db.deleteContact(id);
    getAllContacts();
  }





}