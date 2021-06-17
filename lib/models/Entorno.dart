class Entorno {

  String icon;
  bool workspaceReservationEnabled;
  bool parkingReservationEnabled;
  bool meetingRoomReservationEnabled;
  Theme theme;

  Entorno({
    required this.icon,
    required this.workspaceReservationEnabled,
    required this.parkingReservationEnabled,
    required this.meetingRoomReservationEnabled,
    required this.theme,
  });

  factory Entorno.fromJson(Map<String, dynamic> json) => Entorno(
    icon: json["icon"],
    workspaceReservationEnabled: json["workspace_reservation_enabled"],
    parkingReservationEnabled: json["parking_reservation_enabled"],
    meetingRoomReservationEnabled: json["meeting_room_reservation_enabled"],
    theme: Theme.fromJson(json["theme"]),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "workspace_reservation_enabled": workspaceReservationEnabled,
    "parking_reservation_enabled": parkingReservationEnabled,
    "meeting_room_reservation_enabled": meetingRoomReservationEnabled,
    "theme": theme.toJson(),
  };
}

class Theme {

  String accentColor;
  String primaryColor;
  String secondaryColor;

  Theme({
    required this.accentColor,
    required this.primaryColor,
    required this.secondaryColor,
  });

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
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

