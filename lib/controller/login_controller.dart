import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{

  final FirebaseAuth _auth= FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController= TextEditingController();

  void SignInWithEmailAndPassword() async {
    try{
      final User user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text)
        )
        .user;
      Get.snackbar('Hola', 'Sesion Iniciada correctamente');
      print("todo bien hasta ahora");
      Future.delayed(
        Duration(seconds: 2),
        (){
          Get.toNamed("/Pedido");
        }
      );
    }
    catch(e){
      Get.snackbar('Error', 'No se puede ingresar', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _signOut() async{
    await _auth.signOut();
  }

  void signOut() async{
    final User user=await _auth.currentUser;
    if(user == null){
      Get.snackbar('Mensaje', 'No ha iniciado sesion');
      return;
    }
    _signOut();
    final String uid= user.uid;
    Get.snackbar('Mensaje', 'Ha Cerrado Sesion',
      snackPosition: SnackPosition.BOTTOM);
    Get.toNamed("/home");
  }

  void signInWithGoogle() async {
    try{
      UserCredential userCredential;

      final GoogleSignInAccount googleUser =await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
           accessToken: googleAuth.accessToken,
           idToken: googleAuth.idToken,
         );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
    
    final user= userCredential.user;
    Get.snackbar('Hola', 'Ingresando ${user.uid} con Google');
    print('TOdo Normal');
    Future.delayed(
      Duration(seconds: 2),
      (){
        Get.toNamed("/Pedido");
      },
    );
    
    }
    catch(e){
      print(e);
      Get.snackbar('Error', 'Ingreso Fallido with Google: $e', 
      snackPosition: SnackPosition.BOTTOM );

    }

  }

  // void pedidosregister() async{
  //   Future.delayed(Duration(seconds: 2),
  //     (){
  //       Get.toNamed('/Pedido');
  //     },
  //   );
  // }
   
}
