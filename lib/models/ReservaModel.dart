class ReservaModel {

    List<Reservation> reservations;

    ReservaModel({
        required this.reservations,
    });


    factory ReservaModel.fromJson(Map<String, dynamic> json) => ReservaModel(
        reservations: List<Reservation>.from(json["reservations"].map((x) => Reservation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "reservations": List<dynamic>.from(reservations.map((x) => x.toJson())),
    };
}

class Reservation {
    Reservation({
        required this.id,
        required this.type,
        required this.startDate,
        required this.dateString,
        required this.costString,
        required this.isPastReservation,
        required this.name,
        required this.workspaceReservationDetails,
    });

    String id;
    String type;
    // DateTime startDate;
    String startDate;
    String dateString;
    dynamic costString;
    bool isPastReservation;
    String name;
    WorkspaceReservationDetails workspaceReservationDetails;

    factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        type: json["type"],
       // startDate: DateTime.parse(json["start_date"]),
        startDate: json["start_date"],
        dateString: json["date_string"],
        costString: json["cost_string"] == null ? "null" : json["cost_string"],
        isPastReservation: json["is_past_reservation"],
        name: json["name"],
        workspaceReservationDetails: WorkspaceReservationDetails.fromJson(json["workspace_reservation_details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
       // "start_date": startDate.toIso8601String(),
       "start_date": startDate,
        "date_string": dateString,
        "cost_string": costString,
        "is_past_reservation": isPastReservation,
        "name": name,
        "workspace_reservation_details": workspaceReservationDetails.toJson(),
    };
}

class WorkspaceReservationDetails {
    WorkspaceReservationDetails({
        required this.startDate,
        required this.endDate,
        required this.facilityId,
        required this.daysOfWeek,
    });

    String startDate;
    String endDate;
    String facilityId;
    List<int> daysOfWeek;

    factory WorkspaceReservationDetails.fromJson(Map<String, dynamic> json) => WorkspaceReservationDetails(
       // startDate: DateTime.parse(json["start_date"]),
       startDate: json["start_date"],
        endDate: json["end_date"],
        facilityId: json["facility_id"],
        daysOfWeek: List<int>.from(json["days_of_week"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
       // "start_date": startDate.toIso8601String(),
       "start_date": startDate,
        "end_date": endDate,
        "facility_id": facilityId,
        "days_of_week": List<dynamic>.from(daysOfWeek.map((x) => x)),
    };
}
