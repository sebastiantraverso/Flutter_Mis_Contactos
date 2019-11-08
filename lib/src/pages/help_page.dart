import 'package:flutter/material.dart';

import 'package:mis_contactos/src/providers/selectedTheme.dart';
import 'package:provider/provider.dart' as prov;

class HelpPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SelectedTheme selectedTheme = prov.Provider.of<SelectedTheme>(context);

    final Size size = MediaQuery.of(context).size;

    return SafeArea(
          child: Scaffold(
            backgroundColor: selectedTheme.backgroundScaffold,
              appBar: AppBar(
                title: Text( 'Ayuda' ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 20.0,),

                    _descripcion(),
                    SizedBox(height: 40.0,),
                    
                    _ayudaPpal( size ),
                    SizedBox(height: 20.0,),
                    
                    _descripcionPpal(),
                    Divider( thickness: 2.0,),
                    SizedBox(height: 40.0,),
                    
                    _ayudaContacto( size ),
                    SizedBox(height: 10.0,),

                    _descripcionContacto(),
                    SizedBox(height: 50.0,),

                    _footer(),
                    SizedBox(height: 80.0,),
                  ],
                ),
              ),
      ),
    );
  }


  Widget _descripcion(){
    TextAlign align = TextAlign.justify;
    TextStyle font = TextStyle(fontSize: 16.0);
    
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:Text( 'La aplicación permite almacenar contactos para un rápido acceso al momento de realizar una llamada o enviar un mail. \n' +
                       'Los contacos no son sincronizados con la cuenta de Gmail.', 
                   textAlign: align,
                   style: font, 
                ),
      )
    );
  }


  Widget _ayudaPpal( Size size ){
    return Container(
      child: Image(
        image: AssetImage('assets/prints/ayuda_ppal.png'),
        width: size.width *.85,
        fit: BoxFit.cover,
      )
    );
  }


  Widget _descripcionPpal() {
    TextAlign align = TextAlign.left;
    TextStyle font = TextStyle(fontSize: 16.0);

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:Text( 'Referencias: \n' +
                       '  1. Crear nuevo contacto \n' +
                       '  2. Tarjeta del contacto \n' +
                       '  3. Llamar \n' +
                       '  4. Enviar mail \n' +
                       '  5. Editar \n' + 
                       '  6. Cambiar colores', 
                   textAlign: align,
                   style: font, 
                ),
      )
    );
  }


  Widget _ayudaContacto( Size size ){
    return Container(
      child: Image(
        image: AssetImage('assets/prints/ayuda_editar.png'),
        width: size.width *.85,
        fit: BoxFit.cover,
      )
    );
  }


  Widget _descripcionContacto() {
    TextAlign align = TextAlign.left;
    TextStyle font = TextStyle(fontSize: 16.0);

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:Text( 'Referencias: \n' +
                       '  1. Guarda datos del contacto \n' +
                       '  2. Cancelar los cambios realizados \n' +
                       '  3. Llamar al teléfono alternativo \n' +
                       '  4. Eliminar al contacto ', 
                   textAlign: align,
                   style: font, 
                ),
      )
    );

  }


  Widget _footer(){
    TextAlign align = TextAlign.left;
    TextStyle font = TextStyle(fontSize: 16.0);

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:Text( 'Muchas gracias por usar la app!! ', 
                   textAlign: align,
                   style: font, 
                ),
      )
    );
  }


}