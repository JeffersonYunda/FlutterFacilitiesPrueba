import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/models/ReservaDetalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class ReservaDetallePage extends StatefulWidget {

  @override
  _ReservaDetallePageState createState() => _ReservaDetallePageState();
}

class _ReservaDetallePageState extends State<ReservaDetallePage> {
  final httpHandler = new HttpHandler();

  @override
  Widget build(BuildContext context) {

    final String argumento = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: httpHandler.getReservaDetalle(argumento),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                ReservaDetalle datos = snapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Stack(
                      children: <Widget> [
                        // Imagen de cabecera
                        _header(datos.facility.image),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              // btnVolver
                              _btnVolver(context),
                              // btnOpciones
                              _btnOpciones()
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          // nombre
                          _nombre(datos.facility.name),
                          SizedBox(height: 13),
                          // ubicación
                          _direccion(datos.facility.coordinates),
                          SizedBox(height: 52),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              // textoPrecio()
                              _textoPrecio(),
                              // precio
                              _precio(datos.costString),
                            ],
                          ),
                          SizedBox(height: 13),
                          // Edifico
                          _edificio(datos.facility.childrenName),
                          // Puesto
                          // _puesto(),
                          SizedBox(height: 13),
                          // Fecha valida
                          _fechaValida(datos.dateString),
                          SizedBox(height: 19),
                          // mensajeCard
                          _mensajeCard(context),
                          SizedBox(height: 13),
                          // botonQR
                          ScanQR(),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _header(String imagen) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55)),
        image: DecorationImage(
            //image: AssetImage('assets/imagenes/Group7.png'),
            image: NetworkImage(imagen),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _btnVolver(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.of(context).pop()},
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_back, color: Colors.grey, size: 30),
      ),
    );
  }

  Widget _btnOpciones() {
    return GestureDetector(
      onTap: () => {},
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(Icons.more_vert, color: Colors.grey, size: 30),
      ),
    );
  }

  Widget _nombre(String nombre) {
    return Text(
      nombre,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.black,
      ),
    );
  }

  Widget _direccion(String direccion) {

    if(direccion != 'null') {
      return Text(
        direccion,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
      );
    } else {
      return Container();
    }

  }

  Widget _textoPrecio() {
    return Text(
      'Detalles de tu reserva:',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _precio(String precio) {

    if(precio != 'null') {
      return Container(
        width: 60,
        height: 40,
        child: Card(
          color: Colors.white54,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                precio + '€',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }

  }

  Widget _edificio(String niveles) {

    if(niveles != 'null') {
      return Text(
        niveles,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black54,
        ),
      );
    } else {
      return Container();
    }

  }

  /*
  Widget _puesto() {
    return Text(
      'Puesto número 45',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }
   */

  Widget _fechaValida(String fechaValida) {
    return Text(
      fechaValida,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _mensajeCard(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.95,
      height: 84,
      child: Card(
        color: Colors.red[100],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Es necesario ratificar la ocupación escaneando el código QR del puesto de trabajo para confirmarque lo has ocupado.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.red[300],
            ),
          ),
        ),
      ),
    );
  }
}


class ScanQR extends StatefulWidget {
  ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  String _data = "";

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode("#3D8BEF", "Cancelar", false, ScanMode.QR).then((value) => setState(() => _data = value));
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async => _scan(),
      child: Center(
        child: Container(
          width: _screenSize.width * 0.75,
          height: 65,
          child: Card(
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Center(
              child: Text(
                'Ratificar ocupación',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}