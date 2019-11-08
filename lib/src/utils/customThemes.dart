import 'package:flutter/material.dart';
  

enum myTheme { light, dark, kitty, limon }  


class CustomThemes {

  // variables estaticas
  static ThemeData light = new ThemeData(
    buttonTheme: ButtonThemeData( 
                    buttonColor: Colors.indigo, 
                    shape: StadiumBorder(), 
                    padding: EdgeInsets.all(12.0)
                ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
                                  backgroundColor: Colors.indigo,
                              ),
    brightness: Brightness.light
  );


  static ThemeData dark = new ThemeData(
    buttonTheme: ButtonThemeData( 
                    buttonColor: Colors.tealAccent, 
                    shape: StadiumBorder(), 
                    padding: EdgeInsets.all(12.0)
                ),
    brightness: Brightness.dark
  );


  static ThemeData kitty = ThemeData(
    primaryColor: Color.fromRGBO(255, 80, 171, 1.0), // #ff80ab
    primaryColorLight: Color.fromRGBO(255, 178, 221, 1.0),  // #ffb2dd
    primaryColorDark: Color.fromRGBO(201, 79, 124, 1.0),  // #c94f7c
    primaryTextTheme: TextTheme( 
                          display1: TextStyle( color: Color.fromRGBO(33, 33, 33, 1.0)),  // #212121
                          display2: TextStyle(),
                          display3: TextStyle(),
                          display4: TextStyle(),
                          body1: TextStyle( color: Color.fromRGBO(33, 33, 33, 1.0)),  // #212121
                          body2: TextStyle(),
                          button: TextStyle(),
                          caption: TextStyle(),
                          headline: TextStyle(),
                          overline: TextStyle(),
                          subhead: TextStyle(),
                          subtitle: TextStyle(),
                          title: TextStyle( color: Color.fromRGBO(33, 33, 33, 1.0)),  // #212121
                          ),
    accentColor: Color.fromRGBO(252, 228, 236, 1.0),  // #fce4ec
    accentTextTheme: TextTheme( 
                        display1: TextStyle( color: Color.fromRGBO(135, 13, 78, 1.0)),  // #870d4e
                        display2: TextStyle(),
                        display3: TextStyle(),
                        display4: TextStyle(),
                        body1: TextStyle( color: Color.fromRGBO(135, 13, 78, 1.0)),  // #870d4e
                        body2: TextStyle(),
                        button: TextStyle(),
                        caption: TextStyle(),
                        headline: TextStyle(),
                        overline: TextStyle(),
                        subhead: TextStyle(),
                        subtitle: TextStyle(),
                        title: TextStyle( color: Color.fromRGBO(135, 13, 78, 1.0)),  // #870d4e
                        ),
      buttonTheme: ButtonThemeData( buttonColor: Color.fromRGBO(255, 80, 171, 1.0), shape: StadiumBorder(), padding: EdgeInsets.all(12.0)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(255, 80, 171, 1.0), // #ff80ab
        foregroundColor: Color.fromRGBO(255, 80, 171, 1.0), // #ff80ab
        )
  );

 
  static ThemeData limon = ThemeData(
    primaryColor: Colors.lime, 
    primaryColorLight: Color.fromRGBO(255, 255, 179, 1.0),  // #ffffb3
    primaryColorDark: Color.fromRGBO(191, 204, 80, 1.0),  // #bfcc50
    primaryTextTheme: TextTheme( 
                          display1: TextStyle( color: Color.fromRGBO(249, 251, 231, 1.0)),  // #f9fbe7
                          display2: TextStyle(),
                          display3: TextStyle(),
                          display4: TextStyle(),
                          body1: TextStyle( color: Color.fromRGBO(249, 251, 231, 1.0)),  // #f9fbe7
                          body2: TextStyle(),
                          button: TextStyle(),
                          caption: TextStyle(),
                          headline: TextStyle(),
                          overline: TextStyle(),
                          subhead: TextStyle(),
                          subtitle: TextStyle(),
                          title: TextStyle( color: Colors.black),  // #
                          ),
    accentColor: Color.fromRGBO(249, 251, 231, 1.0),  // #f9fbe7
    accentTextTheme: TextTheme( 
                        display1: TextStyle( color: Color.fromRGBO(0, 77, 64, 1.0)),  // #004d40
                        display2: TextStyle(),
                        display3: TextStyle(),
                        display4: TextStyle(),
                        body1: TextStyle( color: Color.fromRGBO(0, 77, 64, 1.0)),  // #004d40
                        body2: TextStyle(),
                        button: TextStyle(),
                        caption: TextStyle(),
                        headline: TextStyle(),
                        overline: TextStyle(),
                        subhead: TextStyle(),
                        subtitle: TextStyle(),
                        title: TextStyle( color: Color.fromRGBO(0, 77, 64, 1.0)),  // #004d40
                        ),
      buttonTheme: ButtonThemeData( buttonColor: Color.fromRGBO(244, 255, 129, 1.0), shape: StadiumBorder(), padding: EdgeInsets.all(12.0)), // #f4ff81
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(244, 255, 129, 1.0), // #f4ff81
        foregroundColor: Color.fromRGBO(0, 0, 0, 1.0), // #f4ff81
        ),
  );


  // metodo
  static ThemeData selectedTheme ( String selectedString ) {
    switch (selectedString) {
      case 'light'  : return light;
      case 'dark'   : return dark;
      case 'kitty'  : return kitty;    
      case 'limon'  : return limon;    
      default       : return light;
    }
  }

  

}