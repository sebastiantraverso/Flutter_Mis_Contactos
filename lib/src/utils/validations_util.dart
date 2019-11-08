

class Validations {


  static bool validMail ( String mail ){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( mail ) ) {
        return true;
      } else {
        return false;
      }
  }


  static int phoneEliminateSimbols ( String phone ) {
    String value = phone;
    value = value.replaceAll(new RegExp(r' '), '');
    value = value.replaceAll(new RegExp(r'-'), '');
    value = value.replaceAll(new RegExp(r'\.'), '');
    value = value.replaceAll(new RegExp(r','), '');
    return int.parse(value);
  }

}