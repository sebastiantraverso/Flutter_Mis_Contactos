import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mis_contactos/src/models/contact_model.dart';
export 'package:mis_contactos/src/models/contact_model.dart';



class DBProvider with ChangeNotifier {

  static Database _database;
  static final DBProvider db = DBProvider._();

  static const _ContactTable = 'Contacts';

  DBProvider._();

  
  Future<Database> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();
    return _database;
  }


  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentDirectory.path, 'ContactsDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: ( db ) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Contacts ('
          ' id INTEGER PRIMARY KEY,'
          ' name TEXT,'
          ' surename TEXT,'
          ' phone INTEGER,'
          ' secondPhone INTEGER,'
          ' email TEXT'
          ')'
        );
      }
    );
  }


  // CREAR 
  newContact( ContactModel contact ) async {
    final db = await database;
    final res = await db.insert( _ContactTable, contact.toJson() );
    return res;
  }

  newContactRaw( ContactModel contact ) async {
    final db = await database;
    
    final res = db.rawInsert(
      "INSERT INTO $_ContactTable ( id, name, surename, phone, secondPhone, email ) "
      "VALUES ( '${contact.id}', '${contact.name}', '${contact.surename}', '${contact.phone}', '${contact.secondPhone}', '${contact.email}' )"

    );
    return res;
  }



  // SELECT
  Future<ContactModel> getContactId( int id ) async {
    final db = await database;
    final res = await db.query( _ContactTable, where: 'id = ?', whereArgs: [id] );
    return res.isNotEmpty ? ContactModel.fromJson( res.first ) : null;
  } 

  Future<List<ContactModel>> getAllContacts() async {
    final db = await database;
    final res = await db.query( _ContactTable, orderBy: 'name' );
    List<ContactModel> list = res.isNotEmpty
                                ? res.map( (c) => ContactModel.fromJson(c) ).toList()
                                : [];
    return list;                                
  }



  // UPDATE
  Future<int> updateContac( ContactModel newContact ) async {
    final db = await database;
    final res = await db.update( _ContactTable , newContact.toJson(), where: 'id = ?', whereArgs: [newContact.id] );
    return res;
  }



  // DELETE
  Future<int> deleteContact( int id) async {
    final db = await database;
    final res = await db.delete( _ContactTable, where: 'id = ?', whereArgs: [id]);
    return res;
  }



}