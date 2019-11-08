import 'package:flutter/material.dart';

import 'package:intent/intent.dart' as intentCall;
import 'package:intent/action.dart' as intentAction;
import 'package:mis_contactos/src/utils/alerts_util.dart';
import 'package:mis_contactos/src/utils/permissions_util.dart' as permissionUtil;



class MakeCall {

  final permissionUtil.PermissionsService _permissionsService = new permissionUtil.PermissionsService();
  BuildContext _localContext;
  String _phone;

  MakeCall( BuildContext context, String phone ) {
    this._localContext = context;
    this._phone = phone;
  }


  void makeCall() async {
    bool _validPermission = await _permissionsService.requestCallPhonePermission( onPermissionDenied: () {
                                                                                    _alertNotPermission();
                                                                                    return false;
                                                                                  } 
                                                                                );
    
    if ( _validPermission ) {
      intentCall.Intent()
        ..setAction(intentAction.Action.ACTION_CALL)
        ..setData( Uri(scheme: 'tel', path: _phone ) )
        ..startActivity().catchError( (e) => print (e) ); 
    }
  }

  void _alertNotPermission() {    
    Alerts.alertOnlyOkButton( _localContext, 
                              'Permiso denegado',
                               [
                                 Text('No se podra establecer la llamada porque no se otorgo el permiso solicitado.'),
                                 Text('Intente realizar una nueva llamada para poder otorgarlo.')
                               ]
                            );
  }
  
}