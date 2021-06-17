import 'package:facilities_v1/common/HttpHandler.dart';

import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/models/Usuario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final httpHandler = new HttpHandler();

  @override
  Widget build(BuildContext context) {

    httpHandler.getUsuario();
    httpHandler.getEntorno();

    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(

            child: FutureBuilder(
              future: Future.wait([httpHandler.getEntorno(), httpHandler.getUsuario()]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  Entorno datos = snapshot.data[0];
                  Usuario datosUsuario = snapshot.data[1];
                  return Stack(
                    children: <Widget> [
                      // Imagen de cabecera
                      _header(),
                      Positioned(
                        top: 16,
                        right: 10,
                        child: Row(
                          children: <Widget> [
                            // Notificaciones
                            _notifications(),
                            SizedBox(width: 16),
                            // Perfil de usuario
                            _profile(datosUsuario.avatar),
                            //_Profile()
                          ],
                        ),
                      ),
                      // Icono de entorno
                      _icon(datos.icon),
                      // Texto de input
                      _text(),
                      // Campo de busqueda
                      _search(),
                      // Botones
                      Row(
                        children: <Widget> [
                          _buttonWorkspaceReservation(datos.workspaceReservationEnabled, datos.theme.accentColor),
                          SizedBox(width: 16),
                          _buttonParkingReservation(datos.parkingReservationEnabled),
                          SizedBox(width: 16),
                          _buttonMeetingRoomReservation(datos.meetingRoomReservationEnabled),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 450, left: 32, right: 32),
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
                            GestureDetector(
                              onTap: () => {},
                              child: Card(
                                color: Color(colorCard(datos.theme.accentColor)),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            )
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
        )
    );
  }


  Widget _header() {
    //final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 420,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
          image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/originals/c5/cd/3b/c5cd3b24c24a8d0fad4c5480c885c932.jpg"),
              fit: BoxFit.cover
          ),
          boxShadow: [
            new BoxShadow(
              color: Color(0xffA4A4A4),
              offset: Offset(1.0, 4.0),
              blurRadius: 3.0,
            )
          ]
      ),
    );
  }


  Widget _icon(String icon){
    return Positioned(
      top: 16,
      left: 16,
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(icon),
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  }

  Widget _notifications() {
    return GestureDetector(
      onTap: () => {},
      child: Icon(Icons.notifications_outlined, size: 30, color: Colors.white),
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


  Widget _text() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 115),
        child: Text(
          '¿Que tipo de espacio quieres reservar?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  Widget _search() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 150, left: 32, right: 32),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10),
                fillColor: Colors.white,
                hintText: "Buscar...",
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
        ),
      ),
    );
  }


  int colorCard(String color) {
    var cortar = color.split('#');
    String numero = '0xFF' + cortar[1];

    print(numero);

    return int.parse(numero);
  }

  
  Widget _buttonWorkspaceReservation(bool visible, String color) {


    if(visible) {
      return GestureDetector(
        onTap: () => {},
        child: Container(
          width: 100,
          height: 170,
          margin: EdgeInsets.only(top: 220, left: 35, right: 16),
          child: Column(
            children: [
              Card(
                color: Color(colorCard(color)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 90,
                    child: Icon(Icons.car_rental),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Puesto de trabajo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
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
          width: 100,
          height: 170,
          child: Column(
            children: [
              Card(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 80,
                    child: Icon(Icons.car_rental),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Plaza de parking",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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


  Widget _buttonMeetingRoomReservation(bool visible) {
    if(visible) {
      return GestureDetector(
        onTap: () => {},
        child: Container(
          width: 100,
          height: 170,
          child: Column(
            children: [
              Card(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 80,
                    child: Icon(Icons.car_rental),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Sala de reuniones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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

}




