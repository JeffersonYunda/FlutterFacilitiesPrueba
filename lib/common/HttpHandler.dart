import 'dart:convert';
import 'package:facilities_v1/models/Edificio.dart';
import 'package:http/http.dart' as http;


class HttpHandler {

  final String _baseUrl = "";

  Future<List<Edificio>> getReservaCampoUno() async {
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

}