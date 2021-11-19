import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login - ValiDely',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/imgdely.jpg',
            height: 300.0,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.blueAccent,
              text: 'Registrarse',
              onPressed: ()=> Get.toNamed('/Registro'),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),

          Container(
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Iniciar Sesion',
              onPressed: ()=> Get.toNamed('/loginpage'),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),

        ],
      )
    );

  }
}