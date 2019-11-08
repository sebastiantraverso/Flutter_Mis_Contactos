import 'package:flutter/material.dart';

import 'package:mis_contactos/src/utils/customThemes.dart';



class SelectedTheme with ChangeNotifier {

  // atributos
  ThemeData _theme;
  Color _backgroundCardColor; 
  Color _textButtonColor;
  Color _backgroundScaffold;


  // singleton
  static final SelectedTheme _singleton = SelectedTheme._internal();

  factory SelectedTheme(){
    return _singleton;
  }

  SelectedTheme._internal();


  // metodos
  void inicializar ( String opcion) {
    _theme = CustomThemes.selectedTheme( opcion );

    print( 'themePrefer --> $opcion ' );

    // background de la Card del contacto
    switch ( opcion ) {
      case 'light': _backgroundCardColor = Colors.lightBlue[200];
                    _textButtonColor = Colors.white;
                    _backgroundScaffold = Colors.blue[100];
                    break;
      case 'dark' : _backgroundCardColor = Colors.grey[600];
                    _textButtonColor = Colors.black;
                    _backgroundScaffold = Colors.grey[600];
                    break;
      case 'kitty' : _backgroundCardColor = Colors.purple[100];  
                    _textButtonColor = Colors.white;
                    _backgroundScaffold = Colors.pink[100];
                    break;
      case 'limon' : _backgroundCardColor = Colors.amber[100];  
                    _textButtonColor = Colors.teal;
                    _backgroundScaffold = Colors.lime[300];
                    break;
      default     : _backgroundCardColor = Colors.lightBlue[200];
                    _textButtonColor = Colors.white;
                    _backgroundScaffold = Colors.blue[100];
                    break;
    }
  }


  ThemeData getTheme ( String option) => _theme = CustomThemes.selectedTheme(option);


  // getters
  get theme => _theme;  
  get backgroundCardColor => _backgroundCardColor;
  get textButtonColor => _textButtonColor;
  get backgroundScaffold => _backgroundScaffold;


  // setters
  set theme ( String option) {
    // Theme de la app
    _theme = CustomThemes.selectedTheme(option);

    inicializar( option );

    notifyListeners();
  }

}