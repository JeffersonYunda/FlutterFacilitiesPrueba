import 'dart:convert';

import 'package:facilities_v1/Widgets/lista_botones_home_widget.dart';
import 'package:facilities_v1/Widgets/lista_reservas_home_widget.dart';
import 'package:facilities_v1/Widgets/proxima_reserva_widget.dart';
import 'package:facilities_v1/blocs/theme.dart';

import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/models/ReservaModel.dart';
import 'package:facilities_v1/models/Usuario.dart';
import 'package:facilities_v1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final httpHandler = new HttpHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: FutureBuilder(
              future: Future.wait([httpHandler.getEntorno(), httpHandler.getUsuario(), httpHandler.getReserva()]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  Entorno datos = snapshot.data[0];
                  Usuario datosUsuario = snapshot.data[1];
                  ReservaModel datosReserva= snapshot.data[2];
                  return Column(
                    children: [
                      Stack(
                        children: <Widget> [
                          // Imagen de cabecera
                          _header(context),
                          Column(
                            children: <Widget> [
                              Container(
                                margin: EdgeInsets.only(top: 15, right: 32, left: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                    // Icono de entorno
                                    _icon(datos.icon),
                                    Row(
                                      children: <Widget> [
                                        // Notificaciones
                                        _notifications(),
                                        SizedBox(width: 16),
                                        // Perfil de usuario
                                        _profile(datosUsuario.avatar),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  // ubicación
                                  _location(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  // Texto de input
                                  _text(),
                                ],
                              ),
                              // Campo de busqueda
                              _search(),
                              // Botones
                              Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 35, right: 35),
                                  child: ListaBotones(botones: datos),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Text(
                              "Mis reservas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            // Boton ver reservas
                            _reservas(datos.themes.accentColor)
                          ],
                        ),
                      ),
                      // Proxima reserva
                      CuentaAtras(reservations: datosReserva.reservations),
                      // Lista de reservas
                      ListaReservasHome(reservas: datosReserva.reservations)
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        )
    );
  }

  Widget _header(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 398,
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

  Widget _icon(String icon){
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(icon),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _notifications() {
    return GestureDetector(
      onTap: () => {},
      child: Icon(Icons.notifications_outlined, size: 28, color: Colors.white),
    );
  }

  Widget _profile(String avatar) {

    return GestureDetector(
        onTap: () => {},
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(avatar),
          backgroundColor: Colors.transparent,
        )
    );
  }

  Widget _location() {
    return Container(
      margin: EdgeInsets.only(left: 32),
      child: Row(
        children: <Widget> [
          Icon(Icons.add_location_alt_outlined, color: Colors.grey[400]),
          Text(
            'Castelló de la Plana, ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          Text(
            'ES',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _text() {
    return Container(
      margin: EdgeInsets.only(top: 13, left: 32, right: 32),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '¿Que tipo de espacio quieres reservar?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.only(top: 9, right: 25, left: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(12),
            fillColor: Colors.white,
            hintText: "Buscar...",
            hintStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }

  

  Widget _buttonWorkspaceReservation(bool visible) {
    if(visible) {
      return GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, "reservar_puesto")
        },child: Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                child: Card(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, bottom: 5),
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/imagenes/ordenador.png'),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Puesto de trabajo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buttonParkingReservation(bool visible) {
    if(visible) {
      return GestureDetector(
        onTap: () => {},
        child: Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                child: Card(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 5),
                      child: Container(
                        height: 50,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/imagenes/coche.png'),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Plaza de parking",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buttonMeetingRoomReservation(bool visible, Themes color) {
    final theme = Provider.of<ThemeChanger>(context);

    if(visible) {
      return GestureDetector(
        onTap: () => theme.setTheme(
          ThemeData(
            accentColor: Colors.pink,
            primaryColor: Color(colorHexadecimal(color.primaryColor)),
            secondaryHeaderColor: Color(colorHexadecimal(color.secondaryColor))
          )
        ),child: Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                child: Card(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 5),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/imagenes/reunion.png'),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Sala de reuniones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _reservas(String color) {
    return  GestureDetector(
        onTap: () => {},
        child: Card(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)
          ),
          child: Center(
            child: Container(
              width: 120,
              height: 30,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Ver todas",
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
        )
    );
  }
}