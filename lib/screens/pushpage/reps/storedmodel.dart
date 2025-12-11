//
// import 'dart:typed_data';
//
// import 'package:objectbox/objectbox.dart';
//
// @Entity()
// class WorkoutData {
//   @Id()
//   int id = 0;
//   final String? name;
//   final String? category;
//   final List<String> weight;
//   final String? date;
//   final String? image;
//   final List<String> repslist;
//
//   WorkoutData({
//     this.name,
//     this.category,
//     required this.weight,
//     this.image,
//     this.date,
//     required this.repslist,
//   });
// }

import 'package:objectbox/objectbox.dart';

// Renamed ExerciseModel to ExerciseDataModel
@Entity()
class ExerciseDataModel {
  @Id()
  int id = 0;
  final List<CategoryData>? data;

  ExerciseDataModel({this.data});

  factory ExerciseDataModel.fromJson(Map<String, dynamic> json) => ExerciseDataModel(
    data: (json["data"] as List?)?.map((x) => CategoryData.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.map((x) => x.toJson()).toList(),
  };
}

// Renamed Datum to CategoryData
@Entity()
class CategoryData {
  @Id()
  int id = 0;
  final String? categoryImage;
  final String? categoryName;
  final List<ExerciseData>? exerciseList;

  CategoryData({this.categoryImage, this.categoryName, this.exerciseList});

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    categoryImage: json["categoryImage"],
    categoryName: json["categoryName"],
    exerciseList: (json["exerciseList"] as List?)?.map((x) => ExerciseData.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "categoryImage": categoryImage,
    "categoryName": categoryName,
    "exerciseList": exerciseList?.map((x) => x.toJson()).toList(),
  };
}

@Entity()
class ExerciseData {
  @Id()
  int typeId = 0;
  final String? typeName;
  final List<ExerciseType>? typeList;

  ExerciseData({this.typeName, this.typeList});

  factory ExerciseData.fromJson(Map<String, dynamic> json) => ExerciseData(
    typeName: json["typeName"],
    typeList: (json["typeList"] as List?)?.map((x) => ExerciseType.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "typeName": typeName,
    "typeList": typeList?.map((x) => x.toJson()).toList(),
  };
}

@Entity()
class ExerciseType {
  @Id()
  int id = 0;
  final String? typelistimage;
  final String? typelistimage_female;
  final String? typelistName;
  final bool? weighted;
  bool isCompletedex;

  List<String> repsList;
  List<String> weightList;

  ExerciseType({
    this.typelistimage,
    this.typelistimage_female,
    this.typelistName,
    this.weighted,
    this.isCompletedex = false,
    this.repsList = const [], // Initialize with an empty list
    this.weightList = const [], // Initialize with an empty list
  });

  factory ExerciseType.fromJson(Map<String, dynamic> json) => ExerciseType(
    typelistimage: json["typelistimage"],
    typelistimage_female: json["typelistimage_female"],
    typelistName: json["typelistName"],
    weighted: json["weighted"],
    isCompletedex: false,
    repsList: List<String>.from(json["repsList"] ?? []),
    weightList: List<String>.from(json["weightList"] ?? []),
  );

  Map<String, dynamic> toJson() => {
    "typelistimage": typelistimage,
    "typelistimage_female": typelistimage_female,
    "typelistName": typelistName,
    "weighted": weighted,
    "repsList": repsList, // Include repsList in the output
    "weightList": weightList, // Include weightList in the output
  };
}
