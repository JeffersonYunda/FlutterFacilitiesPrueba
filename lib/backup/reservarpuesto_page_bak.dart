

import 'dart:convert';

import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/custom_input/custom_input.dart';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class ReservarPuestoPageBak extends StatefulWidget {
  @override
  _ReservarPuestoPageBakState createState() => _ReservarPuestoPageBakState();
}

class _ReservarPuestoPageBakState extends State<ReservarPuestoPageBak> {

  var listaEdificios;

  List<BuildingModel> listaDatos = <BuildingModel>[];

  //late FacilityModel facilitySelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();

    setState(() {

    });
  }


  Future<Null> getListaEdificios() async {
    setState(() {
      listaEdificios = HttpHandler().getFacilitiesAvailables();
    });
  }



  void devolverDatos(String id) {

    setState(() {
      getListaEspacios(id);
    });
  }


  Future<Null> getListaEspacios(String id) async {
    setState(() {
      listaEdificios = getEspacios(id);
    });
  }


  Future<BuildingModel> getEspacios(String id) async {

    final String _baseUrl = "https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io";

    final response = await http.post(Uri.parse(_baseUrl + "/facility/" + id + "/search"));

    if(response.statusCode == 200){

      var edificio = jsonDecode(response.body);

      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: SafeArea(
          child: FutureBuilder(
              future: listaEdificios,
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.hasData) {

                  BuildingModel building = snapshot.data;

                  //Si la lista de datos no contiene el edificio, lo metemos
                  if(!listaDatos.contains(building)){
                    listaDatos.add(building);
                  }


                  //Cambiamos la opcion por defecto para que no nos pete.
                  //Asignamos siempre el primer edificio del listado.
                  //   facilitySelected = building.facilities[0];
                  return Container(
                    child: Center(
                      child: ListView.builder(
                          itemCount: listaDatos.length,
                          itemBuilder: ( _ , index) {

                            late FacilityModel facilitySelected = listaDatos[index].facilities[1];



                            return Column(
                              children: [

                                DropdownButton<FacilityModel>(
                                  value: facilitySelected,

                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  isExpanded: true,

                                  items: listaDatos[index].facilities
                                      .map<DropdownMenuItem<FacilityModel>>(
                                          (FacilityModel facility) {
                                        return DropdownMenuItem<FacilityModel>(
                                            value: facility,
                                            child: Text(facility.name));
                                      }).toList(),

                                  onChanged: (FacilityModel? newFacility){
                                    setState(() {

                                      print("El edificio elegido es: ${newFacility!.name}");

                                      if(newFacility.is_selectable == false) {

                                        //Si nuestra lista de datos ya contiene alguna estancia elegida, debemos
                                        //borra desde donde este hasta el final

                                          facilitySelected = newFacility;

                                          devolverDatos(newFacility.id);

                                       // listaDatos.removeAt(listaDatos.length-1);
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  );
                }

                if(snapshot.connectionState != ConnectionState.done){
                  return Text("loading..");
                }

                if(snapshot.hasError){
                  return Text("Error tiene que ser tratado");
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
        )

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
