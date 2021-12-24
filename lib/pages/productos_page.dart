// ignore_for_file: import_of_legacy_library_into_null_safe, deprecated_member_use, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/controller/pedidos_controller.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({Key? key}) : super(key: key);
  @override
  _LocationPedidoPage createState() => _LocationPedidoPage();
}

class _LocationPedidoPage extends State<ProductosPage> {
  final controller = Get.put(PedidosController());
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  var locationMessage = "";

  final Stream<QuerySnapshot> pedidos =
      FirebaseFirestore.instance.collection('productos').snapshots();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('productos')
        .snapshots()
        .listen((data) {
      for (var doc in data.docs) {
        print(doc['nombre']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LISTA DE PRODUCTOS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Leyendo algo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: pedidos,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Algo no existe');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Cargando');
                }
                final data = snapshot.requireData;
                print(data.size);
                return ListView.builder(
                  itemCount: data.size,

                  itemBuilder: (context, index) {
                    var white;
                    return Container(
                      height: 50,
                      color: Colors.amber[colorCodes[index]],
                      child: Center(
                          child: Text(' ${data.docs[index]['nombre']}')),
                    );
                    //return Text('Nombre ${data.docs[index]['nombre']}');
                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
