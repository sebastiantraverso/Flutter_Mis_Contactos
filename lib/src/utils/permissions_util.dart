import 'package:permission_handler/permission_handler.dart';


class PermissionsService {

  final PermissionHandler _permissionHandler = PermissionHandler();


  // funcion generica para validar cada tipo de permiso
  Future<bool> _requestPermission ( PermissionGroup permission ) async {
    var result = await _permissionHandler.requestPermissions( [permission]);
    if ( result[permission] == PermissionStatus.granted ) {
      return true;
    }
    return false;
  }

 
  // funcion para validar el permiso de llamada
  Future<bool> requestCallPhonePermission( {Function onPermissionDenied} ) async {
    bool granted = await _requestPermission( PermissionGroup.phone );
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }



  // funcion generica HasPermission
  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }


  // llama a la funcion generica HasPermission
  Future<bool> hasCallPermission() async {
    return hasPermission( PermissionGroup.phone );
  }

}