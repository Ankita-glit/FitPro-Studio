import 'package:get/get.dart';
class CategoryExerciseModel {
  final int? id;
  final String? exName;
  final String? exImage;
  final int? exSerial;
  final TargetBodyPart? targetBodyPart;
  final List<TargetBodyPart>? exCategories;
  final List<ExType>? exTypes;


  CategoryExerciseModel({
    this.id,
    this.exName,
    this.exImage,
    this.exCategories,
    this.exTypes,
    this.exSerial,
    this.targetBodyPart,
  });

  factory CategoryExerciseModel.fromJson(Map<String, dynamic> json) => CategoryExerciseModel(
    id: json["id"],
    exName: json["ex_name"],
    exImage: json["ex_image"],
    exCategories: json["ex_categories"] == null ? [] : List<TargetBodyPart>.from(json["ex_categories"]!.map((x) => TargetBodyPart.fromJson(x))),
    exTypes: json["ex_types"] == null ? [] : List<ExType>.from(json["ex_types"]!.map((x) => ExType.fromJson(x))),
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
  RxBool istargetbodytypeSelected;

  TargetBodyPart({
    this.id,
    this.exCount,
    this.name,
    this.image,
    RxBool? istargetbodytypeSelected,
  }):istargetbodytypeSelected = istargetbodytypeSelected ?? false.obs;

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

class ExType {
  final int? id;
  final String? name;

  ExType({
    this.id,
    this.name,
  });

  factory ExType.fromJson(Map<String, dynamic> json) => ExType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
