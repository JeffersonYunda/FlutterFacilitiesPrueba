

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

    );
  }

}


