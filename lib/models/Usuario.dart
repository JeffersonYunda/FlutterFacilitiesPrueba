class Usuario {

  String avatar;
  String name;
  String lastName;

  Usuario({
    required this.avatar,
    required this.name,
    required this.lastName,
  });


  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    avatar: json["avatar"],
    name: json["name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "name": name,
    "last_name": lastName,
  };
}