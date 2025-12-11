class Profilemodel {
  final String? uid;
  final String? email;
  final String? name;
  final DateTime? dob;
  final int? weight;
  final String? wunit;
  final String? gender;
  final int? height;
  final String? hunit;
  final String? tzName;

  Profilemodel({
    this.uid,
    this.email,
    this.name,
    this.dob,
    this.weight,
    this.wunit,
    this.gender,
    this.height,
    this.hunit,
    this.tzName,
  });

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
    uid: json["uid"],
    email: json["email"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    weight: json["weight"],
    wunit: json["wunit"],
    gender: json["gender"],
    height: json["height"],
    hunit: json["hunit"],
    tzName: json["tz_name"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "weight": weight,
    "wunit": wunit,
    "gender":gender,
    "height": height,
    "hunit": hunit,
    "tz_name": tzName,
  };
}
