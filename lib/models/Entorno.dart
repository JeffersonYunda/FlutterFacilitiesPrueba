class Entorno {

  String icon;
  bool workspace_reservation_enabled;
  bool parking_reservation_enabled;
  bool meeting_room_reservation_enabled;
 // late int primaryColor;
 // late int secondaryColor;

  Entorno({
    required this.icon,
    required this.workspace_reservation_enabled,
    required this.parking_reservation_enabled,
    required this.meeting_room_reservation_enabled,
  });

  factory Entorno.fromJson(Map<String, dynamic> json){
    return Entorno(
      icon: json["icon"],
      workspace_reservation_enabled: json["workspace_reservation_enabled"],
      parking_reservation_enabled: json["parking_reservation_enabled"],
      meeting_room_reservation_enabled: json["meeting_room_reservation_enabled"],
    );
  }

}