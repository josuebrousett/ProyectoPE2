import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'pedido_page.dart';
import 'productos_page.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/controller/login_controller.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  final controller = Get.put(LoginController());
  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    print("ingreso");
    return MaterialApp(
        title: 'VALIDELY',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Inicio'),
            actions: <Widget>[
              Builder(builder: (BuildContext context) {
                // ignore: deprecated_member_use
                return FlatButton(
                  onPressed: () async {
                    controller.signOut();
                  },
                  child: const Text('Cerrar Sesion'),
                );
              })
            ],
          ),
          body: _paginaActual == 0 ? ProductosPage() : PedidoPage(),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _paginaActual = index;
                });
              },
              currentIndex: _paginaActual,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user_outlined), label: 'Menu'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.checklist_rounded), label: 'Pedidos'),
              ]),
        ));
  }
}
