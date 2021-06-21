class ReservaDetalle {

  String id;
  String type;
  DateTime startDate;
  String dateString;
  dynamic costString;
  bool isPastReservation;
  Facility facility;
  WorkspaceReservationDetails workspaceReservationDetails;

  ReservaDetalle({
    required this.id,
    required this.type,
    required this.startDate,
    required this.dateString,
    required this.costString,
    required this.isPastReservation,
    required this.facility,
    required this.workspaceReservationDetails,
  });

  factory ReservaDetalle.fromJson(Map<String, dynamic> json) => ReservaDetalle(
    id: json["id"],
    type: json["type"],
    startDate: DateTime.parse(json["start_date"]),
    dateString: json["date_string"],
    costString: json["cost_string"] == null ? "null" : json["cost_string"],
    isPastReservation: json["is_past_reservation"],
    facility: Facility.fromJson(json["facility"]),
    workspaceReservationDetails: WorkspaceReservationDetails.fromJson(json["workspace_reservation_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "start_date": startDate.toIso8601String(),
    "date_string": dateString,
    "cost_string": costString,
    "is_past_reservation": isPastReservation,
    "facility": facility.toJson(),
    "workspace_reservation_details": workspaceReservationDetails.toJson(),
  };
}

class Facility {

  String id;
  String name;
  String image;
  bool isSelectable;
  String coordinates;
  dynamic forgeUrl;
  String childrenName;

  Facility({
    required this.id,
    required this.name,
    required this.image,
    required this.isSelectable,
    required this.coordinates,
    required this.forgeUrl,
    required this.childrenName,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
    id: json["id"],
    name: json["name"],
    image: json["image"] == null ? "null" : json["image"],
    isSelectable: json["is_selectable"],
    coordinates: json["coordinates"] == null ? "null" : json["coordinates"],
    forgeUrl: json["forge_url"] == null ? "null" : json["forge_url"],
    childrenName: json["children_name"] == null ? "null" : json["children_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "is_selectable": isSelectable,
    "coordinates": coordinates,
    "forge_url": forgeUrl,
    "children_name": childrenName,
  };
}

class WorkspaceReservationDetails {

  DateTime startDate;
  DateTime endDate;
  String facilityId;
  List<int> daysOfWeek;

  WorkspaceReservationDetails({
    required this.startDate,
    required this.endDate,
    required this.facilityId,
    required this.daysOfWeek,
  });

  factory WorkspaceReservationDetails.fromJson(Map<String, dynamic> json) => WorkspaceReservationDetails(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    facilityId: json["facility_id"],
    daysOfWeek: List<int>.from(json["days_of_week"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "facility_id": facilityId,
    "days_of_week": List<dynamic>.from(daysOfWeek.map((x) => x)),
  };
}
