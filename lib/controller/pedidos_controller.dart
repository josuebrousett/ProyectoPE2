

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PedidosController extends GetxController{
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final ubicacionController = TextEditingController();
  final pedidoController = TextEditingController();
  final descripcionController = TextEditingController();

  bool success=true;
  String userEmail='';

  void dispose(){ //
    ubicacionController.dispose();
    pedidoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  // void pedidosregister() async{
  //   Future.delayed(Duration(seconds: 2),
  //     (){
  //       Get.toNamed('/Pedido');
  //     },
  //   );
  // }
  // void register() async{
  //   final User user = (await _auth.createUserWithEmailAndPassword(
  //     ubicacion : ubicacionController.text, 
  //     pedido : pedidoController.text,
  //     descripcion : descripcionController.text,
  //     ))
  //     .user;
  //   if(user!=null){
  //     success= true;
  //     print('Registro Exitoso');
  //     Future.delayed(Duration(seconds: 2),
  //     (){
  //       Get.toNamed('/Menupage');
  //     },
  //     );
  //   }
  //   else{
  //     success=false;
  //   }
  // }
}