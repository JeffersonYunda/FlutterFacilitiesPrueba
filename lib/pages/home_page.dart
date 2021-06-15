import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var entornos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEntornos();
  }

  Future<Null> getListaEntornos() async {
    setState(() {
        entornos = HttpHandler().getEntorno();
    });

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HOME'),
      ),
    );
  }
}


