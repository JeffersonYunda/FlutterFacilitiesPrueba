import 'dart:convert';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/Edificio.dart';
import 'package:http/http.dart' as http;


class HttpHandler {

  final String _baseUrl = "https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io";

  Future<List<Edificio>> Jefferson() async {
    final response = await http.get(Uri.parse(_baseUrl + ""));

    List<Edificio> edificios = [];

    if(response.statusCode == 200){
      var map = jsonDecode(response.body);
      for (var item in map) {

      }

      return edificios;
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

      BuildingModel temp = BuildingModel.fromJson(edificio);

      print("Imprimiendo desde http");
      print(temp.facility_name);

      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }
  }

}