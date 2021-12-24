import 'package:get/get.dart';
import 'package:proyecto_pe/pages/home_page.dart';
import 'package:proyecto_pe/pages/login_page.dart';
import 'package:proyecto_pe/pages/menu_page.dart';
import 'package:proyecto_pe/pages/register_page.dart';
import 'package:proyecto_pe/pages/pedido_page.dart';
import 'package:proyecto_pe/pages/menubar.dart';
import 'package:proyecto_pe/pages/productos_page.dart';

routes() => [
      GetPage(name: "/home", page: () => HomePage()),
      GetPage(name: "/Registro", page: () => RegisterPage()),
      GetPage(name: "/Pedido", page: () => PedidoPage()),
      GetPage(name: "/productos", page: () => ProductosPage()),
      GetPage(name: "/loginpage", page: () => LoginPage()),
      GetPage(
          name: "/Menupage",
          page: () => MenuPage(),
          transition: Transition.zoom),
      GetPage(name: "/MenuBar", page: () => MenuBar()),
    ];
