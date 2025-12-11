import 'package:get/get.dart';

class Homepagemodel {
  final int? id;
  final String? name;
  final String? image;
  final int? exCount;
  RxBool iscategorySelected;

  Homepagemodel({
    this.id,
    this.name,
    this.image,
    this.exCount,
    RxBool? iscategorySelected
  }): iscategorySelected = iscategorySelected ?? false.obs;

  factory Homepagemodel.fromJson(Map<String, dynamic> json) => Homepagemodel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    exCount: json["ex_count"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "ex_count":exCount
  };
}
