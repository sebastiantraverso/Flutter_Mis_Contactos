import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart' as prov;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mis_contactos/src/pages/contact_page.dart';
import 'package:mis_contactos/src/pages/home_page.dart';
import 'package:mis_contactos/src/pages/help_page.dart';
import 'package:mis_contactos/src/providers/selectedTheme.dart';



Future main() async{
  // orientacion
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // preferencias
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String actualTheme = prefs.getString('colorTheme') ?? 'light';    
  print('main --> $actualTheme ');

  // singleton de SelectedTheme
  SelectedTheme oTheme = new SelectedTheme();
  oTheme.inicializar( actualTheme );
  
  runApp(
    prov.MultiProvider(
      providers: [
        // ChangeNotifierProvider( builder: (context) => DBProvider()),
        prov.ChangeNotifierProvider( builder: (context) => SelectedTheme() ),
      ],
      child: MyApp(),
    )
    );
}
 


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final SelectedTheme selectedTheme = prov.Provider.of<SelectedTheme>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mis Contactos',
        initialRoute: 'home',

        routes: {
          'home'    : ( BuildContext context ) => HomePage(),
          'contact' : ( BuildContext context ) => ContactPage(),
          'help'    : ( BuildContext context ) => HelpPage(),
        },
        theme: selectedTheme.theme,
        
      );         
      
  }


}