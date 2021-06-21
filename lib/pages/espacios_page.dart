

import 'dart:convert';

import 'package:facilities_v1/common/HttpHandler.dart';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class EspaciosPage extends StatefulWidget {
  @override
  _EspaciosPageState createState() => _EspaciosPageState();
}

class _EspaciosPageState extends State<EspaciosPage> {

  var listaEdificios;

  var i;

  var debug;

  List<BuildingModel> listaDatos = <BuildingModel>[];

  var datos;

  bool pasar = true;

  int eliminar = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaEdificios();


    i = 1;
    debug = 0;

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

    print('Inicio');
    return Scaffold(
      
      body: SafeArea(
        child: FutureBuilder(
          future: listaEdificios,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {
              bool entrar = true;
              debug = debug + 1;
            
              BuildingModel building = snapshot.data;
             
                listaDatos.add(building);



              //Cambiamos la opcion por defecto para que no nos pete.
              //Asignamos siempre el primer edificio del listado.
              //   facilitySelected = building.facilities[0];
              return Container(
                child: Center(
                  child: ListView.builder(
                    itemCount: i,
                    itemBuilder: ( _ , index) {
                    late FacilityModel facilitySelected = listaDatos[index].facilities[0];
                      return Column(
                        //children: listaWidget
                        children: [
                          DropdownButton<FacilityModel>(
                            value: facilitySelected,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
      
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

                                  
                                  listaDatos.removeAt(listaDatos.length-1);




                                  i = i + 1;
                                  devolverDatos(newFacility.id);
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      )
      
      
      

      
      /*
      body: ListView.builder(
        itemCount: i,
        itemBuilder: (context, index) {

          print('Puerta');
          print('______________');

          return FutureBuilder(
            future: listaEdificios,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child:
                  Text("Ha ocurrido un error: ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                print('Salon');
                print('______________');
                BuildingModel building = snapshot.data as BuildingModel;

                

                listaDatos.add(building);
                
                

                late FacilityModel facilitySelected;

                 print('  ');
                 print('Datos: ' + listaDatos.length.toString());
                 
                 print('  ');

                //Cambiamos la opcion por defecto para que no nos pete.
                //Asignamos siempre el primer edificio del listado.
                facilitySelected = listaDatos[index].facilities[0];

                
                 print('  ');
                 print('Indice que recorre: ' +  index.toString());
                 print('  ');



                return Column(
                  //children: listaWidget
                  children: [
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.blue,
                      child: Text(listaDatos[index].facility_name),
                    ),
                    DropdownButton<FacilityModel>(
                      value: facilitySelected,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,

                      items: listaDatos[index].facilities
                          .map<DropdownMenuItem<FacilityModel>>(
                              (FacilityModel facility) {
                            return DropdownMenuItem<FacilityModel>(
                                value: facility,
                                child: Text(facility.name));
                          }).toList(),
                      onChanged: (FacilityModel? newFacility){
                        setState(() {
                          

                          print('Salida');
                          print('______________________________');

                          print("El edificio elegido es: ${newFacility!.name}");
                          
                          if(newFacility.is_selectable == false) {
                            eliminar = eliminar + 1;
                            listaDatos.removeAt(listaDatos.length-eliminar);
                            i = 1 + 1;
                            devolverDatos(newFacility.id);
                          }

                        });
                      },
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          );
        },
      ),

      */
      









      /*

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
                              if(newFacility.is_selectable == false) {
                                devolverDatos(true, newFacility.id);
                              }

                            });
                          },
                        ),

                        _visible? obtenerCampo(): new Container(),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              )
            ],
          ),
        ),
      )


      */



    );
  }



/*
  Widget obtenerCampo() {

    

    final campo =  FutureBuilder(
      future: listaEspacios,
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

                    if(newFacility.is_selectable == false) {
                      devolverDatos(newFacility.id);
                    }

                  });
                },
              ),
            ],
          );



        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    final cuadro = Container(
      color: Colors.green,
      width: 100,
      height: 100,
    );


    listaCampos.add(campo);
    listaCampos.add(cuadro);



    if(listaCampos.length > 3){
      return Container(
        color: Colors.red,
        height: 600,
        width: 500,
        child: ListView(
          // scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: listaCampos
        ),
      );
    } else {
      return campo;
    }
  }
  */
}


