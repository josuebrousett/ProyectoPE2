import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_pe/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_pe/routes/my_routes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner:false,
    initialRoute: '/home',
    navigatorKey: Get.key,
    getPages: routes(),
  ));
}



// void main()=> runApp(MyApp());

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Identificacion",
//       home: Auth(),
    
//     );
//   }

// }
