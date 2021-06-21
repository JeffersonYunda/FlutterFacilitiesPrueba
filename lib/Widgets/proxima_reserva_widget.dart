import 'dart:async';

import 'package:facilities_v1/models/ReservaModel.dart';
import 'package:facilities_v1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';


class CuentaAtras extends StatefulWidget {
  CuentaAtras({Key? key, required this.reservations}) : super(key: key);
  final List<Reservation> reservations;

  @override
  _CuentaAtrasState createState() => _CuentaAtrasState();
}

class _CuentaAtrasState extends State<CuentaAtras> {

  double progreso = 0.0;
  double completado = 0.0;
  int duracion = 1;
  bool actualizar = true;
  

  void startTimer() {
    Timer.periodic(Duration(seconds: duracion), (timer) { 
      setState(() {
        if(progreso == duracion) {
          timer.cancel();
      } else {
        progreso += completado;
      }
      });
    });
  }

  List<String> valoresSueltos(String cadena) {
    List<String> valorString = <String>[];
    
    String sin;
    sin = cadena.replaceAll('-', ' ').replaceAll(':', ' ').replaceAll('.', ' ').replaceAll('T', ' ');
    valorString = sin.split(' ');
    
    return valorString;
  }

  @override
  void initState() {
    super.initState();
    progreso = 0.0;
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    

   
     print('Esto es una prueba: ' + " - " + completado.toString());


    
    Widget reserva(BuildContext context) {
      List<int> segundosOrden = <int>[];
      bool indicador = false;
     

      for(Reservation reserva in widget.reservations ) {
        if(reserva.isPastReservation == false) {
         segundosOrden.add(fechaSegundosDos(reserva.workspaceReservationDetails.startDate, reserva.workspaceReservationDetails.endDate));
        }
      }

      segundosOrden.sort();
      
      for(Reservation reserva in widget.reservations ) {
        if(reserva.isPastReservation == false) {
          indicador = true;
          int segundosfecha = fechaSegundosDos(reserva.workspaceReservationDetails.startDate, reserva.workspaceReservationDetails.endDate);
          if(segundosfecha == segundosOrden[0]) {

            String cadena = reserva.workspaceReservationDetails.endDate;
            int ano = 0;
            int mes = 0;
            int dia = 0;
            int hora = 0;
            int minutos = 0;
            int segundos = 0;

            List<String> formatoCorrecto = valoresSueltos(cadena);

            for (var i = 0; i < formatoCorrecto.length; i++) {
              if(i == 0) {
                ano = int.parse(formatoCorrecto[i]);
              }
              if(i == 1) {
                mes = int.parse(formatoCorrecto[i]);
              }
              if(i == 2) {
                dia = int.parse(formatoCorrecto[i]);
              }
              if(i == 3) {
                hora = int.parse(formatoCorrecto[i]);
              }
              if(i == 4) {
                minutos = int.parse(formatoCorrecto[i]);
              }
              if(i == 5) {
                segundos = int.parse(formatoCorrecto[i]);
              }
            }

            if(actualizar) {
              completado = 1/fechaSegundos(cadena).toDouble();
            }
            actualizar = false;

            return Container(
              width: _screenSize.width * 0.9,
              child: Card(
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Row(
                                children: <Widget> [
                                  Text(
                                    "Proxima reserva en ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: CountdownTimer(
                                      endTime: DateTime(ano, mes, dia, hora, minutos, segundos).millisecondsSinceEpoch,
                                      textStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                                      widgetBuilder: (_,  time) {
                                        if (time == null) {
                                          return Container();
                                        }      
                                        var days = time.days.toString();
                                        var hours = time.hours.toString();
                                        var min = time.min.toString();
                                        var sec = time.sec.toString();
                                        if(days == 'null' && hours != 'null' && min != 'null') {
                                          return Text('${time.hours}h ${time.min}m ${time.sec}s');
                                        }
                                        if(days == 'null' && hours == 'null' && min != 'null') {
                                          return Text('${time.min}m ${time.sec}s');
                                        }    
                                        if(days == 'null' && hours == 'null' && min == 'null') {
                                          return Text('${time.sec}s');
                                        }     
                                        return Text('${time.days}d ${time.hours}h ${time.min}m ${time.sec}s');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget> [
                                  Text(
                                    reserva.dateString,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: <Widget> [
                              GestureDetector(
                                onTap: () => {},
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  child: Card(
                                    color: Colors.grey[600],
                                    child: Center(
                                      child: Container(
                                        child: Icon(Icons.arrow_forward, color: Theme.of(context).accentColor),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(top:  10, bottom: 0),
                            child: Container(
                              width: _screenSize.width * 0.805,
                              height: 5,
                              /*
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              */
                              child:  LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                                value: progreso,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
      } 
      if(indicador == false) {
        return Container();
      }
      return Container();
    }
    
    return  reserva(context);
  }
}