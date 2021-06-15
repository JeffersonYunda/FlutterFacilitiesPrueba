class FacilityModel{
  String id;
  String name;
  String image;
  bool is_selectable;
  String forge_2d_url;
  String forge_3d_url;
  String forge_element_id;
  String coordinates_2d;
  String children_name;

  FacilityModel({
    required this.id,
    required this.name,
    required this.image,
    required this.is_selectable,
    required this.forge_2d_url,
    required this.forge_3d_url,
    required this.forge_element_id,
    required this.coordinates_2d,
    required this.children_name


  });

  factory FacilityModel.fromJson(Map<String, dynamic> json){
    return FacilityModel(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null ? "null" : json["image"],
        is_selectable: json["is_selectable"],
        forge_2d_url: json["forge_2d_url"] == null ? "null" : json["forge_2d_url"],
        forge_3d_url: json["forge_3d_url"] == null ? "null" : json["forge_3d_url"],
        forge_element_id: json["forge_element_id"] == null ? "null" : json["forge_element_id"],
        coordinates_2d: json["coordinates_2d"] == null ? "null" : json["coordinates_2d"],
        children_name: json["children_name"] == null ? "null" : json["children_name"]
    );
  }
}