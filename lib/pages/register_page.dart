
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                       child: const Text(
                        'REGISTRARSE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
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
                      // ignore: unnecessary_null_comparison
                      child: Text(controller.success == null
                        ? ''
                        : (controller.success
                            ? '' + controller.userEmail
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