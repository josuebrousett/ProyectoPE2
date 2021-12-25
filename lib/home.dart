import 'package:flutter/material.dart';
import 'package:proyecto_pe/auth.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido Registrado'),
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> Auth()));
            },
          )
        ]
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/delivery.jpg',
            height: 300.0,
            width: 350.0,
          ),
          SizedBox(
            height: 50,
          ),
          Title(
            color: Colors.blueAccent, 
            child: Text('Gracias por usar nuestra aplicación, en unos momentos llegará su pedido')
            ),
          FloatingActionButton(
            child: Icon(Icons.arrow_back),
            elevation: 50.0,
            backgroundColor: Colors.amber,
            onPressed: ()=> Get.toNamed('/Pedido'),
            ),
        ],
      )
    );
  }
}