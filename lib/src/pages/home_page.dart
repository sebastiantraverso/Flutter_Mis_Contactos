import 'package:flutter/material.dart';

import 'package:provider/provider.dart' as prov;

import 'package:mis_contactos/src/bloc/contact_bloc.dart';
import 'package:mis_contactos/src/bloc/provider.dart';
import 'package:mis_contactos/src/models/contact_model.dart';
import 'package:mis_contactos/src/widgets/contact_widget.dart';
import 'package:mis_contactos/src/providers/selectedTheme.dart';
import 'package:mis_contactos/src/utils/customThemes.dart' as customThemes;
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int currentPage = 0;
  List<ContactModel> contactList;
  final contactBloc = new ContactBloc();

  

  @override
  Widget build(BuildContext context) {

    final SelectedTheme selectedTheme = prov.Provider.of<SelectedTheme>(context);

    contactBloc.getAllContacts();
    
    return Scaffold(
      appBar: _appBar( selectedTheme ),

      body: _createBody( context, selectedTheme ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createFloatingActionButton( selectedTheme ),
    );
  }


  Widget _appBar( SelectedTheme selectedTheme) {
    return AppBar(
        title: Text('Mis contactos'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.color_lens,),
            onSelected: ( customThemes.myTheme result ) { 
              if( result.index == 0 ) { 
                selectedTheme.theme = 'light';
                _saveNewSelectedTheme('light');
              }
              else if ( result.index == 1 ) { 
                selectedTheme.theme = 'dark';
                _saveNewSelectedTheme('dark');
              }
              else if ( result.index == 2 ) { 
                selectedTheme.theme = 'kitty';
                _saveNewSelectedTheme('kitty');
               }
               else if ( result.index == 3 ) { 
                selectedTheme.theme = 'limon';
                _saveNewSelectedTheme('limon');
               }
              else { 
                selectedTheme.theme = 'light';
                _saveNewSelectedTheme('light');
               }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<customThemes.myTheme>> [
              const PopupMenuItem<customThemes.myTheme> (
                value: customThemes.myTheme.light,
                child: Text( 'Claro'),
              ),
              const PopupMenuItem<customThemes.myTheme> (
                value: customThemes.myTheme.dark,
                child: Text( 'Oscuro'),
              ),
              const PopupMenuItem<customThemes.myTheme> (
                value: customThemes.myTheme.kitty,
                child: Text( 'Kitty'),
              ),
              const PopupMenuItem<customThemes.myTheme> (
                value: customThemes.myTheme.limon,
                child: Text( 'Limón'),
              ),
            ],
          ),

          IconButton(
            icon: Icon( Icons.help_outline),
            onPressed: () => Navigator.pushNamed(context, 'help'),
          ),
        ],
      );
  }



  Widget _createFloatingActionButton( SelectedTheme selectedTheme ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(child: SizedBox(),),
        FloatingActionButton(
          child: Icon( Icons.add, color: selectedTheme.textButtonColor,), 
          elevation: 6.0,
          onPressed: () => Navigator.pushNamed(context, 'contact'),
        ),
        SizedBox(width: 5.0,)
      ],
    );
  }


  Widget _createBody( BuildContext context, SelectedTheme selectedTheme) {
    return StreamBuilder<List<ContactModel>>(
      stream: contactBloc.contactStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ContactModel>> snapshot){

        if ( !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }  

        final contacts = snapshot.data;
        print(contacts.length);

        if ( contacts.length == 0 ) {
          return Center(
            child: Text( 'No hay información'),
          );
        }

        return ListView.builder(
          itemCount:  contacts.length,
          itemBuilder: ( context, i) {
            return _makeCard( context, contacts[i], selectedTheme );
          },
        );

      },
    );    
  }


  Widget _makeCard( BuildContext context,  ContactModel contact, SelectedTheme selectedTheme ) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.symmetric( horizontal: 5.0, vertical: 5.0),
      child: Container(
        // padding: new EdgeInsets.symmetric(horizontal: 3.0),
        decoration: BoxDecoration( 
          color: selectedTheme.backgroundCardColor, 
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ContactWidget( contact: contact,)
      ),
    );
  }



  _saveNewSelectedTheme( String newTheme ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorTheme', newTheme);
  }


}