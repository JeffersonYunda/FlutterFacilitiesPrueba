import 'dart:convert';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/Edificio.dart';
import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class HttpHandler {

  final String _baseUrl = "https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io";

  Future<Entorno> getEntorno() async {
    final response = await http.get(Uri.parse(_baseUrl + "/configuration/CUATROOCHENTA"));

    if(response.statusCode == 200){
      var entorno = jsonDecode(response.body);

      Entorno temp = Entorno.fromJson(entorno);

      print("Imprimiendo desde http");
      print(temp.icon);
      print(temp.meeting_room_reservation_enabled);
      print(temp.parking_reservation_enabled);
      print(temp.workspace_reservation_enabled);


      return Entorno.fromJson(entorno);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

  Future<BuildingModel> getFacilitiesAvailables() async {
  //Future<void> getFacilitiesAvailables() async {

    //Realizamos peticion a la URL de 480
    //final response = await http.post(Uri.parse(_baseUrl + "/facility/search"));
    final response = await rootBundle.loadString('assets/falsos_json/raiz.json');

    var edificio = json.decode(response);

    return BuildingModel.fromJson(edificio);

    /*
    //Comprobamos que la descarga vaya Ok
    if(response.statusCode == 200){
      //Decodificamos el JSON que nso mandan
      var edificio = jsonDecode(response.body);


      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }

     */
  }

  Future<BuildingModel> getEntities() async {
    //Future<void> getFacilitiesAvailables() async {

    //Realizamos peticion a la URL de 480
    //final response = await http.post(Uri.parse(_baseUrl + "/facility/search"));
    final response = await rootBundle.loadString('assets/falsos_json/entidad.json');

    var edificio = json.decode(response);

    return BuildingModel.fromJson(edificio);

    /*
    //Comprobamos que la descarga vaya Ok
    if(response.statusCode == 200){
      //Decodificamos el JSON que nso mandan
      var edificio = jsonDecode(response.body);


      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }

     */
  }



}