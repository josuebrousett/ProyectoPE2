

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool success=true;
  String userEmail='';

  void dispose(){ //
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() async{
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      ))
      .user;
    if(user!=null){
      success= true;
      print('Registro Exitoso');
      Future.delayed(Duration(seconds: 2),
      (){
        Get.toNamed('/Pedido');
      },
      );
    }
    else{
      success=false;
    }
  }
}