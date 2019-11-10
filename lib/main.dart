import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart';



void main() => runApp(MyApp());





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marce Desk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}



class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String barcode = '';

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marce desk app"),
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            RaisedButton(onPressed: _scan, child: Text("Escanear ip"),
              color: Theme.of(context).primaryColor ),

            this.barcode.length > 0 ?
            Text('Ip  $barcode') : Container(width: 0.0, height: 0.0),

            this.barcode.length > 0 ?
              RaisedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Botonera(this.barcode)),
                );
              }, child: Text("Conectar"), color: Theme.of(context).primaryColor )
                : Container(width: 0.0, height: 0.0),


        ]
      ),

     )
    );
  }


  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
  }


}



class Botonera extends StatefulWidget {
  final String barcode;
  Botonera(this.barcode);
  @override
  _BotoneraState createState() => _BotoneraState();
}

class _BotoneraState extends State<Botonera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conectado: " + widget.barcode),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: (){
                send("p");
              },
                  child: Text("P"),
                  color: Theme.of(context).primaryColor ),

              RaisedButton(onPressed: (){
                  send("o");
                  },
                  child: Text("O"),
                  color: Theme.of(context).primaryColor ),
            ],
          )
        ],
      )

    );
  }


  void send(key) async {
    print(key);

    String url = 'http://' + widget.barcode + ':8080/' + key;
    print(url);
    Response response = await get(url);
    print(response);
  }
}


