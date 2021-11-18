import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:proyecto_pe/controller/login_controller.dart';

import '../home.dart';


class MenuPage extends StatefulWidget{
  @override
  _AuthState createState()=> _AuthState();
}

class _AuthState extends State<MenuPage>{
  final controller= Get.put(LoginController());
  LocalAuthentication _auth=LocalAuthentication();
  bool _checkBio=false;
  bool _isBioFinger=false;


  @override 
  void initState(){
    super.initState();
    _checkBiometrics();
    _listBioAndFindFingerType();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: <Widget>[
          Builder(builder: (BuildContext context){
            // ignore: deprecated_member_use
            return FlatButton(
              onPressed: ()async{
                controller.signOut();
              }, 
              child: const Text('Cerrar Sesion'),
              ); 
          })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(icon:Icon(Icons.fingerprint,size: 50,), onPressed: _startAuth,iconSize: 60,),
            SizedBox(height: 15),
            Text('Huella dactilar'),
          ],
        ),
      )
    );
  }

  void _checkBiometrics() async{
    try{
      final bio=await _auth.canCheckBiometrics;
      setState(() {
        _checkBio=bio;
      });
      print ('Biometrics= $_checkBio');
    }
    catch(e){
      print(e);
    }
  }

  void _listBioAndFindFingerType() async{
    List<BiometricType> _listType=[];
    try{
      _listType = await _auth.getAvailableBiometrics();
    }
    on PlatformException catch(e){
      print(e.message);
    }
    print('List Biometrics = $_listType');

    if(_listType.contains(BiometricType.fingerprint)){
      setState(() {
        _isBioFinger =true;
      });
      print('FingerPrint is $_isBioFinger');
    }
  }

  void _startAuth() async {
    bool _isAuthenticated=false;
    AndroidAuthMessages _androidMsg=AndroidAuthMessages(
      signInTitle: 'Prueba',
      fingerprintHint: 'Toque el sensor',
        fingerprintNotRecognized: 'Huella No Reconocido',
        fingerprintSuccess: 'Huella reconocida',
        goToSettingsDescription: 'Por favor configure su huella',
    );
    try{
      _isAuthenticated= await _auth.authenticateWithBiometrics(
          localizedReason: "Escanee su huella",
          useErrorDialogs: true,
          stickyAuth: true,
          androidAuthStrings: _androidMsg,

      );
    }
    on PlatformException catch(e){
      print(e.message);
    }

    if(_isAuthenticated){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> Home()));
    }
  }
}