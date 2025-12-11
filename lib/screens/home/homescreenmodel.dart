import 'package:get/get.dart';

class ExerciseModel {
  final List<Datum>? data;

  ExerciseModel({
    this.data,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? categoryId;
  final String? categoryImage;
  final String? categoryName;
  RxBool iscategorySelected;

  final List<ExerciseList>? exerciseList;

  Datum({
    this.categoryId,
    this.categoryImage,
    this.categoryName,
    this.exerciseList,
    RxBool? iscategorySelected,
  }): iscategorySelected = iscategorySelected ?? false.obs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["categoryId"],
    categoryImage: json["categoryImage"],
    categoryName: json["categoryName"],
    exerciseList: json["exerciseList"] == null ? [] : List<ExerciseList>.from(json["exerciseList"]!.map((x) => ExerciseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryImage": categoryImage,
    "categoryName": categoryName,
    "exerciseList": exerciseList == null ? [] : List<dynamic>.from(exerciseList!.map((x) => x.toJson())),
  };
}

class ExerciseList {
  final int? typeId;
  final String? typeName;
  RxBool isExerciseSelected;
  final List<TypeList>? typeList;

  ExerciseList({
    this.typeId,
    this.typeName,
    this.typeList,
    RxBool? isExerciseSelected,
  }): isExerciseSelected = isExerciseSelected ?? false.obs;

  factory ExerciseList.fromJson(Map<String, dynamic> json) => ExerciseList(
    typeId: json["typeId"],
    typeName: json["typeName"],
    typeList: json["typeList"] == null ? [] : List<TypeList>.from(json["typeList"]!.map((x) => TypeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "typeName": typeName,
    "typeList": typeList == null ? [] : List<dynamic>.from(typeList!.map((x) => x.toJson())),
  };
}

class TypeList {
  final String? typeCategoryName;
  final bool? weighted;
  RxList<TypeCategory>? typeCategory;

  TypeList({
    this.typeCategoryName,
    this.weighted,
    this.typeCategory,
  });

  factory TypeList.fromJson(Map<String, dynamic> json) => TypeList(
    typeCategoryName: json["typeCategoryName"],
    weighted: json["weighted"],
    typeCategory: (json["typeCategory"] as List?)?.map((x) => TypeCategory.fromJson(x)).toList().obs,  // Making it reactive
  );

  Map<String, dynamic> toJson() => {
    "typeCategoryName": typeCategoryName,
    "weighted": weighted,
    "typeCategory": typeCategory == null ? [] : List<dynamic>.from(typeCategory!.map((x) => x.toJson())),
  };
}

class TypeCategory {
  final int? sn;
  final int? typelistid;
  final String? typelistimage;
  final String? typelistimageFemale;
  final String? typelistName;
  RxBool? istypeCategorySelected;

  TypeCategory({
    this.sn,
    this.typelistid,
    this.typelistimage,
    this.typelistimageFemale,
    this.typelistName,
    RxBool? istypeCategorySelected,
  }): istypeCategorySelected = istypeCategorySelected ?? false.obs;

  factory TypeCategory.fromJson(Map<String, dynamic> json) => TypeCategory(
    sn: json["sn"],
    typelistid: json["typelistid"],
    typelistimage: json["typelistimage"],
    typelistimageFemale: json["typelistimage_female"],
    typelistName: json["typelistName"],
  );

  Map<String, dynamic> toJson() => {
    "sn": sn,
    "typelistid": typelistid,
    "typelistimage": typelistimage,
    "typelistimage_female": typelistimageFemale,
    "typelistName": typelistName,
  };
}

