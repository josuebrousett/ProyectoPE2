
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
 final controller= Get.put(RegisterController());
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        builder:(_){
          return Form(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String? value){
                        if(value!.isEmpty) return 'Por favor, Ingrese su email';
                        return null;
                      },  
                    ),

                    TextFormField(
                      controller: controller.passwordController,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      validator: (String? value){
                        if(value!.isEmpty) return 'Por favor, Ingrese su contraseña';
                        return null;
                      },
                      obscureText: true,
                    ),

                    Container(
                      padding: const EdgeInsets.only(top:16.0),
                      alignment: Alignment.center, 
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Text('Registro'), 
                        onPressed: ()async{
                         _.register();
                        },
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      child: Text(controller.success == null
                        ? ''
                        : (controller.success
                            ? 'Registrado Exitosamente' + controller.userEmail
                            : 'Registro Fallido'),
                  ),
                )
                  ],  
                ) 
              ,),
            )
          );
        },
      ),
    );
  }
}