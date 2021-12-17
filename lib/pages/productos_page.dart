// ignore_for_file: import_of_legacy_library_into_null_safe

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
  var locationMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LISTA DE PRODUCTOS"),
      ),
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('productos').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView(
              children: snapshot.data!.docs.map((grocery) {
                return Center(
                  child: ListTile(
                    title: Text(grocery['nombre']),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined), label: 'Menu'),
        BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded), label: 'Pedidos'),
      ]),
    );
  }
}
