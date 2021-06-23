class Entorno {

  String baseUrl;
  String icon;
  String location;
  String idiom;
  bool workspaceReservationEnabled;
  bool parkingReservationEnabled;
  bool meetingRoomReservationEnabled;
  Themes themes;

  Entorno({
    required this.baseUrl,
    required this.icon,
    required this.location,
    required this.idiom,
    required this.workspaceReservationEnabled,
    required this.parkingReservationEnabled,
    required this.meetingRoomReservationEnabled,
    required this.themes,
  });

  factory Entorno.fromJson(Map<String, dynamic> json) => Entorno(
    baseUrl: json["base_url"],
    icon: json["icon"],
    location: json["location"],
    idiom: json["idiom"],
    workspaceReservationEnabled: json["workspace_reservation_enabled"],
    parkingReservationEnabled: json["parking_reservation_enabled"],
    meetingRoomReservationEnabled: json["meeting_room_reservation_enabled"],
    themes: Themes.fromJson(json["theme"]),
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl,
    "icon": icon,
    "location": location,
    "idiom": idiom,
    "workspace_reservation_enabled": workspaceReservationEnabled,
    "parking_reservation_enabled": parkingReservationEnabled,
    "meeting_room_reservation_enabled": meetingRoomReservationEnabled,
    "theme": themes.toJson(),
  };
}

class Themes {

  String accentColor;
  String primaryColor;
  String secondaryColor;

  Themes({
    required this.accentColor,
    required this.primaryColor,
    required this.secondaryColor,
  });

  factory Themes.fromJson(Map<String, dynamic> json) => Themes(
    accentColor: json["accent_color"],
    primaryColor: json["primary_color"],
    secondaryColor: json["secondary_color"],
  );

  Map<String, dynamic> toJson() => {
    "accent_color": accentColor,
    "primary_color": primaryColor,
    "secondary_color": secondaryColor,
  };
}

