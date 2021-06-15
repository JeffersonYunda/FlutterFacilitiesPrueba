import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpHandler httpHandler = new HttpHandler();
    httpHandler.getEntorno();
    getListaEntornos();
  }

  Future<Null> getListaEntornos() async {
    setState(() {

    });

    //Probablemente haya otra manera mas limpia de hacer esto, no se si es lo
    //recomendado por flutter
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget> [
            Text('HOME'),
          ],
        ),
      ),
    );
  }
}


