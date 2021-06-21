
import 'package:facilities_v1/blocs/theme.dart';
import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaBotones extends StatelessWidget {
  final Entorno botones;
  const ListaBotones({required this.botones});


  List<Widget> listaBotones(BuildContext context, Entorno datos) {
    int items = 0;
    List<Widget> list = <Widget>[];
    
    if(datos.workspaceReservationEnabled == true) {
      list.add(
        GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, "reservar_puesto")},
          child: Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 32, right: 30),
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
      )
      );
    }

    if(datos.parkingReservationEnabled == true) {
      list.add(
        GestureDetector(
        onTap: () => {},
        child: Container(
          width: 90,
          height: 90,
          margin: EdgeInsets.only(top: 32, right: 30),
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
      )
      );
    }

    if(datos.meetingRoomReservationEnabled == true) {
      final theme = Provider.of<ThemeChanger>(context);
      list.add(
        GestureDetector(
        onTap: () => theme.setTheme(
          ThemeData(
            accentColor: Colors.pink,
            primaryColor: Color(colorHexadecimal(datos.themes.primaryColor)),
            secondaryHeaderColor: Color(colorHexadecimal(datos.themes.secondaryColor)),
            fontFamily: 'anext'
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
      )
      );
    }

    list.add(Container());

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
     // padding: const EdgeInsets.only(left: 15, right: 15),
      children: listaBotones(context, botones)
    );
  }
}