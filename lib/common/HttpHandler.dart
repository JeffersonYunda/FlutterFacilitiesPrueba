import 'dart:convert';
import 'dart:io';
import 'package:facilities_v1/models/BuildingModel.dart';
import 'package:facilities_v1/models/Entorno.dart';
import 'package:facilities_v1/models/FacilityModel.dart';
import 'package:facilities_v1/models/ReservaDetalle.dart';
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

      
      print("ENTORNOOOOO");
      print(temp.icon);
      print(temp.workspaceReservationEnabled);
      print(temp.parkingReservationEnabled);
      print(temp.meetingRoomReservationEnabled);
      print(temp.themes.accentColor);
      print(temp.themes.primaryColor);
      print(temp.themes.secondaryColor);
      

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

      
      print("USUARIOOOOOOO");
      print(temp.avatar);
      print(temp.name);
      print(temp.lastName);
       

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


      print("RESERVAAAAAA");
      print(temp.reservations[0].dateString);
      print(temp.reservations[0].name);


      //List listaDatos = datos['reservations'];
      //return listaDatos.map((dato) => ReservaModel.fromJson(dato)).toList();

      return ReservaModel.fromJson(datos);

    } else {
      throw Exception("Fallo al conectar");
    }
  }


  Future<ReservaDetalle> getReservaDetalle(String id) async {

    final response = await http.get(Uri.parse(_baseUrl + "/reservation/" + id));

    if(response.statusCode == 200){
      var reserva = jsonDecode(response.body);

      ReservaDetalle temp = ReservaDetalle.fromJson(reserva);

      print("DETALEE RESERVAAAA");
      print(temp.facility.name);


      return ReservaDetalle.fromJson(reserva);

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

      return BuildingModel.fromJson(edificio);

    } else {
      throw Exception("Fallo al conectar");
    }
  }
  
  //Future<void> crearReserva() async{
  Future<Map<String, dynamic>> crearReserva(String start_date, String end_date) async{

    //Montamos el body con los argumentos para hacer la reserva
    print("Las fechas son:");
    print(start_date);
    print(end_date);

    Map<String, dynamic> lista =
    {
    "start_date": "2021-07-14",
      "end_date": "2021-07-14",
      "facility_path" : ["EDIFICIO_ESPAITEC_2", "EDIFICIO_ESPAITEC_2_PLANTA_4", "DEVELOPIA"],
      "facility_id": "PUESTO_2",
      "use_random_facility": false,
      "days_of_week": [1, 2, 3]
  };

    String jsonTutorial = jsonEncode(lista);

    final response = await http.post(
        Uri.parse(_baseUrl + "/reservation/workspaces"),
        body: jsonTutorial,
    );

    //Si recibimos 200, tenemos una respuesta normal
    if(response.statusCode == 200){

      //Creamos respuesta indicado que la reserva se ha efectuado
      Map<String, dynamic> respuesta =
      {
        "status_code" : response.statusCode,
        "message": "---"
      };
      return respuesta;
    }

    //Si recibimos 409, tenemos un conflicto en la reserva
    if(response.statusCode == 409){
      //decodificamos el json que nos mandan
      var respuesta_server = jsonDecode(response.body);

      //Creamos respuesta indicado que ha habido un conflicto
      Map<String, dynamic> respuesta =
      {
        "status_code" : response.statusCode,
        "message": respuesta_server["message"]
      };

      return respuesta;
    }
    throw Exception("Error");

  }

  //En principio esta llamada se puede hacer como crearReserva, pero de momento
  //la dejaremos en una llamada aparte, ya que damos por hecho que siempre ira bien
  //Future<Map<String, dynamic>> crearReservaAleatoria() async{
  Future<void> crearReservaAleatoria() async{

    //Montamos el body con los argumentos para hacer la reserva

    Map<String, dynamic> lista =
    {
      "start_date": "2021-07-14",
      "end_date": "2021-07-14",
      "facility_path" : ["EDIFICIO_ESPAITEC_2", "EDIFICIO_ESPAITEC_2_PLANTA_4", "DEVELOPIA"],
      "facility_id": "PUESTO_2",
      "use_random_facility": true,
      "days_of_week": [1, 2, 3]
    };

    String jsonTutorial = jsonEncode(lista);

    final response = await http.post(
      Uri.parse(_baseUrl + "/reservation/workspaces"),
      body: jsonTutorial,
    );

    //Si recibimos 200, tenemos una respuesta normal
    if(response.statusCode == 200){
      print("Todo OK");
    }


  }





  void pruebaLogin(usuario, pass) async {

    try{
      var url = 'https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io/login';

      Map jsonBody = {"username": "prueba55", "password": "123"};

      var response = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer JWT_TOKEN",
            "APP_PLATFORM": "android",
            "APP_VERSION": "1.0",
            "APP_PACKAGE": "com.480.facilityreservation",
            "DEVICE_LANGUAGE": "es",
            "Content-Type": "application/json",
          },
          body: jsonEncode(jsonBody)

      ).then((response) {
        print(response.statusCode);
      });




    } on Error catch(e) {
      print('Http error');
    }

  }




  Future<void> getToken() async {
    String url = 'https://92d98850-e5c8-4d80-ad4d-1ee96c686a24.mock.pstmn.io/login';
    Map<String, String> headers = {

      "APP_PLATFORM": "android",
      "APP_VERSION": "1.0",
      "APP_PACKAGE": "com.480.facilityreservation",
      "DEVICE_LENGUAGE": "es",
      "Content-Type": "application/json",

    };

    var body = jsonEncode({
      "username": 'prueba22',
      "password": '123'
    });


    http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);

    int statusCode = response.statusCode;
    print('statuscode: $statusCode');
    final responseJson = json.decode(response.body);
    print(responseJson);

    //print('This is the API response: $responseJson');
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