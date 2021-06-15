import 'package:facilities_v1/models/FacilityModelBak.dart';

class BuildingModel{
  String facility_name;
  List<FacilityModel> facilities;

  BuildingModel({required this.facility_name, required this.facilities});

  factory BuildingModel.fromJson(Map<String, dynamic> json){

    //Mapeamos la lista de instalaciones
    var list = json['facilities'] as List;
    List<FacilityModel> listaFacilities = list.map((i) => FacilityModel.fromJson(i)).toList();

    return BuildingModel(
        facility_name: json["facility_name"],
        facilities: listaFacilities
    );

  }

}