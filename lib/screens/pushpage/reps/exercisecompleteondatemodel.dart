class CompleteExerciseListOnDatemodel {
  final int? id;
  final User? user;
  final Exercise? exercise;
  final int? setsCount;
  final DateTime? date;
  final List<Rep>? reps;
  final bool isCompleted;

  CompleteExerciseListOnDatemodel({
    this.id,
    this.user,
    this.exercise,
    this.setsCount,
    this.date,
    this.reps,
    required this.isCompleted,
  });

  factory CompleteExerciseListOnDatemodel.fromJson(Map<String, dynamic> json) => CompleteExerciseListOnDatemodel(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    exercise: json["exercise"] == null ? null : Exercise.fromJson(json["exercise"]),
    setsCount: json["sets_count"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    reps: json["reps"] == null ? [] : List<Rep>.from(json["reps"]!.map((x) => Rep.fromJson(x))),
    isCompleted: json["is_completed"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "exercise": exercise?.toJson(),
    "sets_count": setsCount,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "reps": reps == null ? [] : List<dynamic>.from(reps!.map((x) => x.toJson())),
    "is_completed": isCompleted,  // Add isCompleted flag here
  };
}

class Exercise {
  final int? id;
  final String? exName;
  final String? exImage;
  final List<TargetBodyPart>? exCategories;
  final List<ExTypes>? exTypes;
  final int? exSerial;
  final TargetBodyPart? targetBodyPart;

  Exercise({
    this.id,
    this.exName,
    this.exImage,
    this.exCategories,
    this.exTypes,
    this.exSerial,
    this.targetBodyPart,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    exName: json["ex_name"],
    exImage: json["ex_image"],
    exCategories: json["ex_categories"] == null ? [] : List<TargetBodyPart>.from(json["ex_categories"]!.map((x) => TargetBodyPart.fromJson(x))),
    exTypes: json["ex_types"] == null ? [] : List<ExTypes>.from(json["ex_types"]!.map((x) => ExTypes.fromJson(x))),
    exSerial: json["ex_serial"],
    targetBodyPart: json["target_body_part"] == null ? null : TargetBodyPart.fromJson(json["target_body_part"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ex_name": exName,
    "ex_image": exImage,
    "ex_categories": exCategories == null ? [] : List<dynamic>.from(exCategories!.map((x) => x.toJson())),
    "ex_types": exTypes == null ? [] : List<dynamic>.from(exTypes!.map((x) => x.toJson())),
    "ex_serial": exSerial,
    "target_body_part": targetBodyPart?.toJson(),
  };
}

class TargetBodyPart {
  final int? id;
  final int? exCount;
  final String? name;
  final String? image;

  TargetBodyPart({
    this.id,
    this.exCount,
    this.name,
    this.image,
  });

  factory TargetBodyPart.fromJson(Map<String, dynamic> json) => TargetBodyPart(
    id: json["id"],
    exCount: json["ex_count"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ex_count": exCount,
    "name": name,
    "image": image,
  };
}

class ExTypes {
  final int? id;
  final String? name;

  ExTypes({
    this.id,
    this.name,
  });

  factory ExTypes.fromJson(Map<String, dynamic> json) => ExTypes(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Rep {
  final int? id;
  final int? setSerial;
  final int? repsCount;
  final double? weight;
  final String? wunit;

  Rep({
    this.id,
    this.setSerial,
    this.repsCount,
    this.weight,
    this.wunit,
  });

  factory Rep.fromJson(Map<String, dynamic> json) => Rep(
    id: json["id"],
    setSerial: json["set_serial"],
    repsCount: json["reps_count"],
    weight: json["weight"],
    wunit: json["wunit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "set_serial": setSerial,
    "reps_count": repsCount,
    "weight": weight,
    "wunit": wunit,
  };
}

class User {
  final String? uid;
  final String? email;
  final String? name;
  final DateTime? dob;
  final String? gender;
  final double? weight;
  final String? wunit;
  final int? height;
  final String? hunit;
  final String? tzName;

  User({
    this.uid,
    this.email,
    this.name,
    this.dob,
    this.gender,
    this.weight,
    this.wunit,
    this.height,
    this.hunit,
    this.tzName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"],
    email: json["email"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    weight: json["weight"],
    wunit: json["wunit"],
    height: json["height"],
    hunit: json["hunit"],
    tzName: json["tz_name"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "weight": weight,
    "wunit": wunit,
    "height": height,
    "hunit": hunit,
    "tz_name": tzName,
  };
}
