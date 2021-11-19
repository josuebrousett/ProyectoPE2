import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/controller/pedidos_controller.dart';

class PedidoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPedidoPage(),
    );
  }

}

class LocationPedidoPage extends StatefulWidget {
  @override
  _LocationPedidoPage createState() => _LocationPedidoPage();
}

class _LocationPedidoPage extends State<LocationPedidoPage>{
  final controller = Get.put(PedidosController());
  var locationMessage = "";


 void getCurrentLocation() async {
   var position = await Geolocator
       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
   var lastPosition = await Geolocator.getLastKnownPosition();
   print(lastPosition);

   setState(() {
     locationMessage =  "$position";
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("REGISTRO DE PEDIDO"),
      ),          
      body: GetBuilder<PedidosController>(
        builder:(_){
          return Form(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationMessage
                    ),
                    FlatButton(
                        onPressed: () {getCurrentLocation();},
                        color: Colors.blue[800],
                        child: Text("Obtener Ubicacion",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                    ),
                    TextFormField(
                      controller: controller.pedidoController,
                      decoration: const InputDecoration(labelText: 'Pedido'),
                      validator: (String? value){
                        if(value!.isEmpty) return 'Ingrese un pedido';
                        return null;
                      },  
                    ),

                    TextFormField(
                      controller: controller.descripcionController,
                      decoration: const InputDecoration(labelText: 'Descripción'),
                      validator: (String? value){
                        if(value!.isEmpty) return 'Ingrese una descripción';
                        return null;
                      },  
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // ignore: deprecated_member_use
                              new RaisedButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text('Registrar'),
                                onPressed: ()=> Get.toNamed('/Menupage'),
                              ),

                              // ignore: deprecated_member_use
                              new RaisedButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text('Cancelar'),
                                onPressed: ()async{
                                //  _.register();
                                },
                              )
                            ],
                          )  
                        ],
                      ),
                    ),

                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Text(controller.success == null
                    //     ? ''
                    //     : (controller.success
                    //         ? 'Registrado Exitosamente' + controller.userEmail
                    //         : 'Registro Fallido'),
                    //  ),
                    // )
                  ],  
                ) 
              ,),
            )
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined),
            label: 'Menu'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: 'Pedidos'
          ),
        ]
      ), 
    ); 
  }
}