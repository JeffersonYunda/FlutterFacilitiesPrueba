import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ReservaDetallePage extends StatelessWidget {
  const ReservaDetallePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              // Imagen de cabecera
              Stack(
                children: <Widget> [
                  _header(),
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
                    _nombre(),
                    SizedBox(height: 13),
                    // ubicación
                    _direccion(),
                    SizedBox(height: 52),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        // textoPrecio()
                        _textoPrecio(),
                        // precio
                        _precio(),
                      ],
                    ),
                    SizedBox(height: 13),
                    // Edifico
                    _edificio(),
                    // Puesto 
                    _puesto(),
                    SizedBox(height: 13),
                    // Fecha valida
                    _fechaValida(),
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
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55)),
        image: DecorationImage(
            image: AssetImage('assets/imagenes/Group7.png'),
            // image: NetworkImage("https://i.pinimg.com/originals/c5/cd/3b/c5cd3b24c24a8d0fad4c5480c885c932.jpg"),
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

  Widget _nombre() {
    return Text(
      'Edificio Espaitec II',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.black,
      ),
    );
  }

  Widget _direccion() {
    return Text(
      'Avinguda de Vicent Sos Baynat, s/n, 12071 Castelló de la plana, Castelló',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
      ),
    );
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

  Widget _precio() {
    return Container(
      width: 60,
      height: 40,
      child: Card(
        color: Colors.white54,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(
            '9€',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _edificio() {
    return Text(
      'Edificio Espaitec II - Planta 4 - Zona B',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

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

  Widget _fechaValida() {
    return Text(
      'Válido hasta el lunes 31 mayo desde las 8:00 h. hasta las 17:30 h.',
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