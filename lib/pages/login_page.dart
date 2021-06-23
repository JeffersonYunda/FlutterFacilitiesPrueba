import 'dart:async';

import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:flutter/material.dart';

// Prueba login
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final httpHandler = new HttpHandler();

  bool _contrasenaVisible = false;

  final usuario = TextEditingController();
  final contrasena = TextEditingController();

  String usu ='';
  String pass = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: null,
        child: SafeArea(
          child: Column(
            children: <Widget> [
              Stack(
                children: <Widget> [
                  // Imagen de cabecera
                  imagenCabecera(),
                  Center(
                    child: Container(
                      height: 229,
                      //color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget> [
                          // Logo cabecera
                          logoCabecera(),
                          // Texto cabecera
                          textoCabecera()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 36),
              // Texto iniciar sesion
              textoLogin(),
              SizedBox(height: 24),
              // Campo usuario
              campoUsuario(),
              SizedBox(height: 24),
              // Campo contraseña
              campoContrasena(),
              SizedBox(height: 75),
              // Boton acceder
              botonLogin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget imagenCabecera() {
    return Container(
      width: double.infinity,
      height: 229,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55)),
        image: DecorationImage(
          image: AssetImage('assets/imagenes/cabeceraLogin.png'),
          //image: NetworkImage(imagen),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget logoCabecera() {
    return Container(
      width: 280,
      height: 53,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/imagenes/logoLogin.png'),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget textoCabecera() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        'Reserva de espacios',
        style: TextStyle(
         // fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget textoLogin() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        'Iniciar sesión',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget campoUsuario() {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: TextFormField (
        controller: usuario,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: 'Usuario',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            hintText: 'Introduce el usuario'
        ),
      ),
    );
  }

  Widget campoContrasena() {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: TextFormField(
      //  keyboardType: TextInputType.text,
        controller: contrasena,
        obscureText: !_contrasenaVisible,
        decoration: InputDecoration(
         // floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: 'Contraseña',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 17
          ),
          hintText: 'Introduce la contraseña',
          suffixIcon: IconButton(
            icon: Icon(
              _contrasenaVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey[500],
            ),
            onPressed: () {
              setState(() {
                _contrasenaVisible = !_contrasenaVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget botonLogin(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      alignment: Alignment.center,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 110),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600]
          ),
        ),
        onPressed: () {

          usu = usuario.text;
          pass = contrasena.text;




            httpHandler.getToken();
          //  httpHandler.pruebaLogin(usu, pass);



        },
      ),
    );

  }

  /*
  Widget botonLogin(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        usu = usuario.text;
        pass = contrasena.text;

        print('Usuario: ' + usu + "  Contraseña: " + pass);
      },
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
  */

}

