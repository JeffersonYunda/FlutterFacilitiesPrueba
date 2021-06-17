import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/custom_input/boton_azul.dart';
import 'package:facilities_v1/custom_input/checkbox_days.dart';
import 'package:facilities_v1/custom_input/custom_input.dart';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservarPuestoPage extends StatefulWidget {
  @override
  _ReservarPuestoPageState createState() => _ReservarPuestoPageState();
}

class _ReservarPuestoPageState extends State<ReservarPuestoPage> {
  var listaEdificios;

  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();
    setState(() {

    });
  }

  void devolverDatos(bool visible, String nombre) {
    if(nombre == "Edificio Espaitec 1") {
      _visible = visible;
    }
  }

  Future<Null> getListaEdificios() async {
    setState(() {
      listaEdificios = HttpHandler().getFacilitiesAvailables();
    });
  }

  late FacilityModel facilitySelected;
  List<Widget> listaDropdowns = [];

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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //Si tuviesemos que cortar la altura tiramos de aqui
            //height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                //Formulario
                FutureBuilder(
                    future: listaEdificios,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text("Ha ocurrido un error: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        BuildingModel building = snapshot.data as BuildingModel;

                        //Cambiamos la opcion por defecto para que no nos pete.
                        //Asignamos siempre el primer edificio del listado.
                        facilitySelected = building.facilities[0];

                        //¿Debemos guardar todos los widget y pintarlos?
                        listaDropdowns.add(new DropdownCustom(
                          building: building,
                        ));

                        return Column(
                          //children: listaWidget
                          children: [
                            DropdownButton<FacilityModel>(
                              value: facilitySelected,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,

                              items: building.facilities
                                  .map<DropdownMenuItem<FacilityModel>>(
                                      (FacilityModel facility) {
                                return DropdownMenuItem<FacilityModel>(
                                    value: facility,
                                    child: Text(facility.name));
                              }).toList(),

                              onChanged: (FacilityModel? newFacility){
                                setState(() {
                                  print("El edificio elegido es: ${newFacility!.name}");
                                  devolverDatos(true, newFacility.name);
                                });
                              },
                            ),

                            _visible? new Row(
                              children: [
                                TablaDos()
                              ],
                              /*
                              children: <Widget> [
                                DropdownButton<FacilityModel>(
                                  value: facilitySelected,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,

                                  items: building.facilities
                                      .map<DropdownMenuItem<FacilityModel>>(
                                          (FacilityModel facility) {
                                        return DropdownMenuItem<FacilityModel>(
                                            value: facility,
                                            child: Text(facility.name));
                                      }).toList(),

                                  onChanged: (FacilityModel? newFacility){
                                    setState(() {
                                      print("El edificio elegido es: ${newFacility!.name}");
                                    });
                                  },
                                ),
                              ],
                              */

                            ): new Container()
                          ],


                          /*
                      children:
                      [
                        DropdownButton<FacilityModel>(
                          value: facilitySelected,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurple,
                          ),

                          onChanged: (FacilityModel? newFacility){
                            setState(() {
                              facilitySelected = newFacility!;

                              //Aqui tenemos que hacer otra peticion a la API, para pedir el numero de planta
                              //¿Pero luego como lo enseñamos?

                              //y si guardamos el facility en un array y luego se pinta todo?

                            });
                          },

                          items: building.facilities
                              .map<DropdownMenuItem<FacilityModel>>((FacilityModel facility) {
                            return DropdownMenuItem<FacilityModel>(
                                value: facility,
                                child: Text(facility.name)
                            );
                          }).toList(),
                        ),


                      ],
*/
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })

                //_FormularioReservasPuesto(),

                //Espacio entre el formulario y el boton
                //Este espacio deberia calcularse de otra manera o
                //si se usa un SizedBox la altura deberia estar expresada
                //en tanto por ciento
                /*
              SizedBox(
                height: 200,
              ),
*/
                //Boton de reservar
                /*
              BotonAzul(
                  text: "Reservar puesto",
                  onPressed: (){}
              )

               */
              ],
            ),
          ),
        ));
  }
}

class TablaDos extends StatefulWidget {
  @override
  _TablaDosState createState() => _TablaDosState();
}

class _TablaDosState extends State<TablaDos> {

  var listaEntidad;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getListaEdificios();
    setState(() {

    });
  }


  /*
  Future<Null> getListaEdificios() async {
    setState(() {
      listaEntidad = HttpHandler().getEntities();
    });
  }
   */




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaEntidad,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child:
              Text("Ha ocurrido un error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            BuildingModel building = snapshot.data as BuildingModel;

            //Cambiamos la opcion por defecto para que no nos pete.
            //Asignamos siempre el primer edificio del listado.
           // facilitySelected = building.facilities[0];

            //¿Debemos guardar todos los widget y pintarlos?
           /* listaDropdowns.add(new DropdownCustom(
              building: building,
            ));

            */

            return Column(
              //children: listaWidget
              children: [
                DropdownButton<FacilityModel>(
                 // value: facilitySelected,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,

                  items: building.facilities
                      .map<DropdownMenuItem<FacilityModel>>(
                          (FacilityModel facility) {
                        return DropdownMenuItem<FacilityModel>(
                            value: facility,
                            child: Text(facility.name));
                      }).toList(),

                  onChanged: (FacilityModel? newFacility){
                    setState(() {

                    });
                  },
                ),
              ],


              /*
                      children:
                      [
                        DropdownButton<FacilityModel>(
                          value: facilitySelected,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurple,
                          ),

                          onChanged: (FacilityModel? newFacility){
                            setState(() {
                              facilitySelected = newFacility!;

                              //Aqui tenemos que hacer otra peticion a la API, para pedir el numero de planta
                              //¿Pero luego como lo enseñamos?

                              //y si guardamos el facility en un array y luego se pinta todo?

                            });
                          },

                          items: building.facilities
                              .map<DropdownMenuItem<FacilityModel>>((FacilityModel facility) {
                            return DropdownMenuItem<FacilityModel>(
                                value: facility,
                                child: Text(facility.name)
                            );
                          }).toList(),
                        ),


                      ],
*/
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        })
    ;
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
        setState(() {
          facilitySelected = newFacility!;

          //Aqui tenemos que hacer otra peticion a la API, para pedir el numero de planta
          //¿Pero luego como lo enseñamos?

          print("El siguiente elemento a llamar es ${newFacility.id}");

          //¿Tenemos que usar un manejador de estados aqui?
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
