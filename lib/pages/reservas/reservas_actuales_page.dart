import 'package:animate_do/animate_do.dart';
import 'package:facilities_v1/models/ReservaModel.dart';
import 'package:flutter/material.dart';

class ReservasActuales extends StatelessWidget  {
  final List<Reservation> reservas;
  ReservasActuales({required this.reservas});

  List<Widget> listaReservas(BuildContext context, List<Reservation> reservations) {
 
    final _screenSize = MediaQuery.of(context).size;
    List<Widget> list = <Widget>[];
    for(Reservation reserva in reservations) {
      if(reserva.isPastReservation == false) {
        // Si el precio es null
        if(reserva.costString == 'null') {
          reserva.costString = '0';
        }
          list.add(
            GestureDetector(
              onTap: () => {Navigator.pushNamed(context, "reserva_detalle", arguments: reserva.id)},
              child: Container(
                width: _screenSize.width * 0.7,
                margin: EdgeInsets.only(top: 15),
                child: Padding(
                  padding: const EdgeInsets.only(left: 1, right: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: <Widget> [
                      Row(
                        children: [
                          Column(
                            children: <Widget> [
                              icono(reserva.type)
                            ],
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Text(
                                    reserva.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget> [
                                  Text(
                                    reserva.dateString,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: <Widget> [
                            Column(
                              children: <Widget> [
                                Container(
                                  width: 48,
                                  height: 30,
                                  child: Card(
                                    color: Colors.white54,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          reserva.costString + '€',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget> [
                                Container(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Icon(Icons.more_vert, color: Colors.grey, size: 35),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
      } else {
        list.add(Container());
      }
    }
    return list;
  }

  Widget icono(String tipo) {
      if(tipo == 'WORKSPACES') {
        return  Container(
          width: 65,
          height: 65,
          child: Card(
            color: Colors.grey[600],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 2, bottom: 5),
                child: Container(
                  height: 20,
                  width: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/imagenes/ordenadorBlanco.png'),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } 
      if(tipo == 'PARKING') {
        return Container(
          width: 65,
          height: 65,
          child: Card(
            color: Colors.grey[600],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 2, bottom: 5),
                child: Container(
                  height: 20,
                  width: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/imagenes/cocheBlanco.png'),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      if(tipo == 'MEETING') {
        return Container(
          width: 65,
          height: 65,
          child: Card(
            color: Colors.grey[600],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 2, bottom: 5),
                child: Container(
                  height: 20,
                  width: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/imagenes/reunionBlanco.png'),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    
    return Container(
      width: 65,
      height: 65,
      child: Card(
        color: Colors.grey[600],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 23, right: 23),
      children: listaReservas(context, reservas)
      )
      
    );
  }
}

// Quitar efecto de tope
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}