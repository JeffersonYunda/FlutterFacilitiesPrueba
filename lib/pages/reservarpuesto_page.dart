import 'dart:convert';

import 'package:facilities_v1/Widgets/caja_fecha_reservas_widget.dart';
import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/custom_input/checkbox_days.dart';
import 'package:facilities_v1/custom_input/custom_input.dart';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ReservarPuestoPage extends StatefulWidget {
  @override
  _ReservarPuestoPageState createState() => _ReservarPuestoPageState();
}

class _ReservarPuestoPageState extends State<ReservarPuestoPage> {
  var listaEdificios;
  final emailCtrl = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  bool checkBoxLunes = false;
  bool checkBoxMartes = false;
  bool checkBoxMiercoles = false;
  bool checkBoxJueves = false;
  bool checkBoxViernes = false;
  bool checkBoxSabado = false;
  bool checkBoxDomingo = false;
  late FacilityModel edificio;

  DateTime startDate = DateTime.now();

  Future<Null> selectTimePicker(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        controller.text =
            "${startDate.day.toString()}.${startDate.month.toString()}.${startDate.year.toString()}";
        print(startDate.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();

    setState(() {});
  }

  Future<Null> getListaEdificios() async {
    setState(() {
      listaEdificios = HttpHandler().getFacilitiesAvailables();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: Row(
                children: [
                  //Icono de 'Equis'
                  GestureDetector(
                    onTap: () {
                      print("Cerrando");
                    },
                    child: Icon(
                      Icons.clear,
                      size: 25,
                      color: Colors.black54,
                    ),
                  ),

                  //Separacion entre el icono y el titulo de la pagina
                  SizedBox(
                    width: 40,
                  ),

                  //Titulo de la pagina
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Reservar puesto',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      //Cuerpo de las reservas
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Usamos columnas anidadas para situar el boton de reservar
              //en la parte inferior de la pantalla sin problema

              //Formulario de las reservas
              Column(
                children: [
                  //Espacio entre titulo y campos de fecha
                  SizedBox(
                    height: 12,
                  ),

                  //Fila de fechas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CajaReservaFechaWidget(
                        dateController: startDateController,
                        placeHolder: "DD/MM/AAAA",
                        icon: Icons.calendar_today_outlined,
                        title: "Día inicio",
                      ),
                      CajaReservaFechaWidget(
                        dateController: endDateController,
                        placeHolder: "DD/MM/AAAA",
                        icon: Icons.calendar_today_outlined,
                        title: "Día fin",
                      ),
                    ],
                  ),

                  //Espacio entre fechas y siguiente nivel
                  SizedBox(
                    height: 24,
                  ),

                  FutureBuilder(
                      future: listaEdificios,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child:
                                Text("Ha ocurrido un error: ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          BuildingModel building =
                              snapshot.data as BuildingModel;
                          FacilityModel facilitySelected =
                              building.facilities[0];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Puesto",
                                    style: TextStyle(
                                        letterSpacing: 0.5, color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            offset: Offset(0, 3))
                                      ]),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButton<FacilityModel>(
                                        //value: facilitySelected,
                                        hint: Text("Seleccione opción"),
                                        icon: const Icon(
                                          Icons.arrow_right_outlined,
                                          color: Colors.black38,
                                        ),
                                        iconSize: 24,
                                        isExpanded: true,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),

                                        onChanged: (FacilityModel? newValue) {
                                          setState(() {
                                            facilitySelected = newValue!;
                                          });
                                        },

                                        items: building.facilities.map<
                                                DropdownMenuItem<
                                                    FacilityModel>>(
                                            (FacilityModel value) {
                                          return DropdownMenuItem<
                                              FacilityModel>(
                                            value: value,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),

                                  /*
                                  *  children: [
                                    DropdownButton<FacilityModel>(
                                      value: facilitySelected,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,

                                        items: listaDatos[index].facilities.
                                        map<DropdownMenuItem<FacilityModel>>(
                                            (FacilityModel facility){
                                              return DropdownMenuItem<FacilityModel>(
                                                value: facility,
                                                  child: Text(facility.name)
                                              );
                                            }
                                        ).toList(),

                                      onChanged: (FacilityModel? newFacility){
                                        setState(() {
                                          print("Aqui hacemos cosas");
                                        });
                                      },

                                    )
                                  ],
                                  *
                                  * */
                                )
                              ],
                            ),
                          );
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),

                  //Espacio entre nivel anterior y dias de la semana
                  SizedBox(
                    height: 24,
                  ),

                  //Fila para dias de la semana
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Checkbox para el lunes
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxLunes = !checkBoxLunes;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxLunes
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxLunes
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxLunes
                              ? Center(
                                  child: Text(
                                    "Lu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Lu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el martes
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxMartes = !checkBoxMartes;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxMartes
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxMartes
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxMartes
                              ? Center(
                                  child: Text(
                                    "Ma",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Ma",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el miercoles
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxMiercoles = !checkBoxMiercoles;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxMiercoles
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxMiercoles
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxMiercoles
                              ? Center(
                                  child: Text(
                                    "Mi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Mi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el jueves
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxJueves = !checkBoxJueves;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxJueves
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxJueves
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxJueves
                              ? Center(
                                  child: Text(
                                    "Ju",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Ju",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el viernes
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxViernes = !checkBoxViernes;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxViernes
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxViernes
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxViernes
                              ? Center(
                                  child: Text(
                                    "Vi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Vi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el sabado
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxSabado = !checkBoxSabado;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxSabado
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxSabado
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxSabado
                              ? Center(
                                  child: Text(
                                    "Sa",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Sa",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      //Checkbox para el domingo
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            checkBoxDomingo = !checkBoxDomingo;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              color: checkBoxDomingo
                                  ? Theme.of(context).accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: checkBoxDomingo
                                  ? null
                                  : Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2.0)),
                          width: 32,
                          height: 32,
                          child: checkBoxDomingo
                              ? Center(
                                  child: Text(
                                    "Do",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Do",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),

                      /*
                  checkBoxLunes = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Lu",
                  ),

                  checkBoxMartes = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Ma",
                  ),

                  checkBoxMiercoles = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Mi",
                  ),

                  checkBoxJueves = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Ju",
                  ),

                  checkBoxViernes = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Vi",
                  ),

                  checkBoxSabado = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: false,
                    text: "Sa",
                  ),

                  checkBoxDomingo = CheckboxDay(
                    isChecked: true,
                    size: 32,
                    iconSize: 32,
                    disabled: true,
                    text: "Do",
                  )
                   */
                    ],
                  ),
                ],
              ),

              //Boton de reservar puesto
              GestureDetector(
                onTap: () {
                  var json_respuesta;
                  //Hacemos peticion
                  HttpHandler().crearReserva(startDateController.text, endDateController.text ).then((respuesta) => {
                        //Si obtenemos un codigo 200, enseñamos que todo ha ido guay
                        if (respuesta["status_code"] == 200)
                          {
                            //Abrimos cuadro de dialogo de reserva hecha correctamente
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Center(
                                        child: Text(
                                          "Reserva Realizada",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      content: Text(
                                        'La reserva ha sido realizada con exito. Puedes acceder al detalle de tu reserva desde el listado de reservas',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Center(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop('ok');
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    )).then((result) => {print(result)}),
                          }
                        //Si obtenemos un codigo 409, enseñamos que ha habido conflicto y
                        //se da la posibilidad de elegir un sitio aleatorio
                        else if (respuesta["status_code"] == 409)
                          {
                            //Abrimos cuadro de dialogo de reserva pendiente

                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Center(
                                        child: Text(
                                          "Reserva pendiente",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      content: Text(
                                        respuesta["message"],
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop('Cancelar');
                                              },
                                              child: Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop('OK');
                                              },
                                              child: Text(
                                                'Aceptar',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )).then((result) => {
                                      if(result == "OK"){
                                        HttpHandler().crearReservaAleatoria().then((value) => {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Center(
                                                  child: Text(
                                                    "Reserva Realizada",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                content: Text(
                                                  'La reserva ha sido realizada con exito. Puedes acceder al detalle de tu reserva desde el listado de reservas',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  Center(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop('ok');
                                                      },
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )).then((result) => {print(result)}),
                                        })
                                      }
                                    }),
                          }
                      });
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 65,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Reservar puesto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

/*
List<Widget> listaWidget = [];
var listaEdificios;
var lista_temp;
late BuildingModel model;

class ReservarPuestoPage extends StatefulWidget {
  @override
  _ReservarPuestoPageState createState() => _ReservarPuestoPageState();
}

class _ReservarPuestoPageState extends State<ReservarPuestoPage> {
  var listaEdificios;
  var lista_temp;
  var i;
  List<BuildingModel> listaDatos = <BuildingModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();
  }


  Future<Null> getListaEdificios() async {

    setState(() {
      listaEdificios = HttpHandler().getFacilitiesAvailables();
    });


  }

  late FacilityModel facilitySelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.clear,
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Reservar puesto',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),

        body: SafeArea(
              child: FutureBuilder(
                    future: listaEdificios,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text("Ha ocurrido un error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        BuildingModel building = snapshot.data as BuildingModel;

                        listaDatos.add(building);

                        //Cambiamos la opcion por defecto para que no nos pete.
                        //Asignamos siempre el primer edificio del listado.
                        facilitySelected = building.facilities[0];


                        return Container(
                          child: Center(
                            child: ListView.builder(
                              itemCount: i,
                                itemBuilder: ( _ , index){
                                return Column(
                                  /*
                                  children: [
                                    DropdownButton<FacilityModel>(
                                      value: facilitySelected,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,

                                        items: listaDatos[index].facilities.
                                        map<DropdownMenuItem<FacilityModel>>(
                                            (FacilityModel facility){
                                              return DropdownMenuItem<FacilityModel>(
                                                value: facility,
                                                  child: Text(facility.name)
                                              );
                                            }
                                        ).toList(),

                                      onChanged: (FacilityModel? newFacility){
                                        setState(() {
                                          print("Aqui hacemos cosas");
                                        });
                                      },

                                    )
                                  ],
                                  */
                                );
                                }
                            ),


                          ),



                        );

                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })



            ),


        floatingActionButton: FloatingActionButton(
        onPressed: () async {

          //Desde aqui hacemos una peticion web
          lista_temp = HttpHandler().getEntityFacility("/facility/" + model.facilities.last.id +  "/search");
          model = await HttpHandler().getEntityFacility("/facility/" + model.facilities.last.id  + "/search");

          setState(() {
            listaWidget.add(DropdownCustom(building: model));
            listaEdificios =  lista_temp;
          });

        },
    child: Container(),
    ),

    );
  }
}






class DropdownCustom extends StatefulWidget {
  final BuildingModel building;

  const DropdownCustom({Key? key, required this.building}) : super(key: key);

  @override
  _DropdownCustomState createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    FacilityModel facilitySelected = widget.building.facilities[0];

    // TODO: implement build
    return DropdownButton<FacilityModel>(
      value: facilitySelected,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurple,
      ),
      onChanged: (FacilityModel? newFacility) {
        setState(() async {
          facilitySelected = newFacility!;

          print("El siguiente elemento a llamar es ${newFacility.id}");
          //Aqui hay que hacer listaWidget.add

          lista_temp = HttpHandler().getEntityFacility("/facility/" + facilitySelected.id +  "/search");
          model = await HttpHandler().getEntityFacility("/facility/" + facilitySelected.id  + "/search");

          setState(() {
            listaWidget.add(DropdownCustom(building: model));
            listaEdificios =  lista_temp;

          });

        });
      },
      items: widget.building.facilities
          .map<DropdownMenuItem<FacilityModel>>((FacilityModel facility) {
        return DropdownMenuItem<FacilityModel>(
            value: facility, child: Text(facility.name));
      }).toList(),
    );
  }
}

 */
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class _FormularioReservasPuesto extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_FormularioReservasPuesto> {
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //Dia inicio y dia fin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInput(
                icon: Icons.calendar_today_outlined,
                placeholder: '31.05.2021',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Día inicio",
              ),
              CustomInput(
                icon: Icons.calendar_today_outlined,
                placeholder: '13.06.2021',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Día fin",
              ),
            ],
          ),

          //Espacio
          SizedBox(
            height: 10,
          ),

          //Edificio
          CustomInput(
              icon: Icons.arrow_right_outlined,
              placeholder: 'Edificio Espaitec II',
              textController: emailCtrl,
              widthPercentage: 0.94,
              title: "Edificio"),

          //Espacio
          /*
          SizedBox(
            height: 10,
          ),

          //Numero de planta y zona
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInput(
                icon: Icons.arrow_right_outlined,
                placeholder: 'Planta 4',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Nº de Planta",
              ),

              CustomInput(
                icon: Icons.arrow_right_outlined,
                placeholder: 'Zona B',
                keyboardType: TextInputType.datetime,
                textController: emailCtrl,
                widthPercentage: 0.45,
                title: "Zona",
              ),
            ],
          ),

          //Espacio
          SizedBox(
            height: 10,
          ),

          //Puesto y boton de mapa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03,),
                child: CustomInput(
                    icon: Icons.arrow_right_outlined,
                    placeholder: 'Puesto número 45',
                    textController: emailCtrl,
                    widthPercentage: 0.65,
                    title: "Puesto"
                ),
              ),

              //Boton circular
              Container(
                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                width: 60,
                height: 60,
                child: IconButton(
                  icon: Icon(Icons.map),
                  enableFeedback: true,
                  onPressed: (){},
                ),
              )
            ],
          ),

          //Dias de la semana
          CheckboxDay(
            isChecked: true,
            size: 50,
            iconSize: 50,
            selectedColor: Colors.black,
            selectedIconColor: Colors.black,
          )
*/
        ],
      ),
    );
  }
}
