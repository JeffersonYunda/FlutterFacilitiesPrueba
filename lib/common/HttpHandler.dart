import 'dart:convert';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/Edificio.dart';
import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:facilities_v1/models/ReservaModel.dart';
import 'package:facilities_v1/models/Usuario.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class HttpHandler {

  final String _baseUrl = "https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io";


  Future<Entorno> getEntorno() async {
    final response = await http.get(Uri.parse(_baseUrl + "/configuration/CUATROOCHENTA"));

    if(response.statusCode == 200){
      var entorno = jsonDecode(response.body);

      Entorno temp = Entorno.fromJson(entorno);

      /*
      print("Imprimiendo desde http");
      print(temp.icon);
      print(temp.workspaceReservationEnabled);
      print(temp.parkingReservationEnabled);
      print(temp.meetingRoomReservationEnabled);
      print(temp.theme.accentColor);
      print(temp.theme.primaryColor);
      print(temp.theme.secondaryColor);
      */

      return Entorno.fromJson(entorno);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

  Future<Usuario> getUsuario() async {
    final response = await http.get(Uri.parse(_baseUrl + "/me"));

    if(response.statusCode == 200){
      var usuario = jsonDecode(response.body);

      Usuario temp = Usuario.fromJson(usuario);

      /*
      print("Imprimiendo desde http");
      print(temp.avatar);
      print(temp.name);
      print(temp.lastName);
       */

      return Usuario.fromJson(usuario);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

  Future<ReservaModel> getReserva() async {
   // final response = await http.post(Uri.parse(_baseUrl + "/reservations/search"));
   final response = await http.post(Uri.parse(_baseUrl + "/reservations/search"));


    if(response.statusCode == 200){
      var datos = jsonDecode(response.body);

      ReservaModel temp = ReservaModel.fromJson(datos);


      print("Imprimiendo desde getReserva");
      print(temp.reservations[0].dateString);


      //List listaDatos = datos['reservations'];
      //return listaDatos.map((dato) => ReservaModel.fromJson(dato)).toList();

      return ReservaModel.fromJson(datos);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

  Future<BuildingModel> getFacilitiesAvailables() async {
  //Future<void> getFacilitiesAvailables() async {

    //Realizamos peticion a la URL de 480
    final response = await http.post(Uri.parse(_baseUrl + "/facility/search"));

    //Comprobamos que la descarga vaya Ok
    if(response.statusCode == 200){
      //Decodificamos el JSON que nso mandan
      var edificio = jsonDecode(response.body);

      /*
      BuildingModel temp = BuildingModel.fromJson(edificio);

      print("Imprimiendo desde http");
      print(temp.facility_name);
      print(temp.facilities[0].name);
*/
      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

  Future<BuildingModel> getEntityFacility(String ruta) async{

    //Realizamos peticion a la URL de 480
    final response = await http.post(Uri.parse(_baseUrl + ruta));

    //Comprobamos que la descarga vaya Ok
    if(response.statusCode == 200){
      //decodigicamos el JSON que nos mandan
      var entityFacility = jsonDecode(response.body);

      print("nos mandan");
      print(response.body);

      return BuildingModel.fromJson(entityFacility);

    }else{
      throw Exception("Fallo al conectar");
    }

  }

}