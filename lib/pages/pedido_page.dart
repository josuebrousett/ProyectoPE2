import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/controller/pedidos_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class _LocationPedidoPage extends State<LocationPedidoPage> {
   // ignore: deprecated_member_use
   final db =Firestore.instance;
   final _formKey = GlobalKey<FormState>();
   String pedido='';
   String descripcion='';
   String id='';

  int _paginaActual = 0;

  final controller = Get.put(PedidosController());
  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = "$position";
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("REGISTRO DE PEDIDO"),
    //   ),
    return GetBuilder<PedidosController>(
      builder: (_) {
        return Form(
            key: _formKey,
            child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationMessage),
                FlatButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  color: Colors.blue[800],
                  child: Text("Obtener Ubicacion",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                TextFormField(
                  controller: controller.pedidoController,
                  decoration: const InputDecoration(labelText: 'Pedido'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Ingrese un pedido';
                  },
                  onSaved: (value)=> pedido=value!,
                ),
                TextFormField(
                  controller: controller.descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (String? value) {
                    if (value!.isEmpty) return 'Ingrese una descripción';
                    return null;
                  },
                  onSaved: (value)=> descripcion=value!,
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
                            onPressed: () =>{ 
                              createPedido(),
                              Get.toNamed('/Menupage'),
                            }
                          ),

                          // ignore: deprecated_member_use
                          new RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('Cancelar'),
                            onPressed: () async {
                              //  _.register();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
    // bottomNavigationBar: BottomNavigationBar(
    //   onTap: (index){
    //     setState(() {
    //       _paginaActual =index;
    //     });
    //   },
    //   currentIndex:_paginaActual,
    //   items: const [
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.verified_user_outlined), label: 'Menu'),
    //   BottomNavigationBarItem(
    //       icon: Icon(Icons.checklist_rounded), label: 'Pedidos'),
    // ]),
  }

  void createPedido() async {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      DocumentReference ref= await db.collection('pedidos').add({'pedido': '$pedido', 'descripcion': '$descripcion'});
      setState(() {
        // ignore: deprecated_member_use
        id=ref.documentID;
        print(ref.documentID);
      });
    }
  }
}
