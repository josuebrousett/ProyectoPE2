import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
//import 'package:latlong2/latlong.dart';

class adminPage extends StatefulWidget {
  const adminPage({ Key? key }) : super(key: key);

  @override
  _adminPageState createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Admin - Pedidos"),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key?key}): super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  final Stream<QuerySnapshot> pedidos =
      FirebaseFirestore.instance.collection('pedidos').snapshots();

  
  Future getPost() async{
    // ignore: deprecated_member_use
    var firestore=FirebaseFirestore.instance;
    // ignore: deprecated_member_use
    QuerySnapshot qn =await firestore.collection("pedidos").getDocuments();
    // ignore: deprecated_member_use
    return qn.documents;
  }

  navigateToDetail(QueryDocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(post:post)));
  }

  void initState(){
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: pedidos,
        builder:( BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,){
          if (snapshot.hasError) {
            return Text('Algo no existe');
          }
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(
              child: Text("Loading"),
            );
          } //ver si esta vacio o no la tabla pedidos
          else{
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context,index){
                final val='${data.docs[index]['pedido']}';
                return ListTile(
                  title: Text(' ${data.docs[index]['pedido']}'),
                  subtitle: Text(' ${data.docs[index]['celular']} '+'-'+' ${data.docs[index]['estado']}'),
                  leading: CircleAvatar(
                    child: Text(val.substring(0,1)),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: ()=> navigateToDetail(data.docs[index]),
                );
            });
          }
      }),
    );
  }
}

class DetailPage extends StatefulWidget {

  final QueryDocumentSnapshot? post;
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // final lat ='${widget.post!['descripcion']}';
     final longi = '${widget.post!['ubicacion']}';
     print("hijos de su madre");
     print(longi);
     final latitud=longi.substring(longi.indexOf(':')+2,longi.indexOf(','));
     final longitud=longi.substring(longi.indexOf("Longitude:")+11,longi.length);
     final a=double.parse(latitud);
     final b=double.parse(longitud);
     print(latitud);
     print(longitud);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle -Pedido'),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: Card(
                child:ListTile(
                  title: Text('${widget.post!['pedido']}'),
                  subtitle:Text('${widget.post!['descripcion']}') ,
                ),
              ),
            ),
            Flexible(
              child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(a, b),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers:[ 
                      Marker(
                        point: LatLng(a, b),
                        builder: (ctx)=> Icon(Icons.pin_drop),  
                      ),
                      ],
                    ),
                  ],
              ),
            )         
          ],
        )
      ),
     
    );
  }
}
