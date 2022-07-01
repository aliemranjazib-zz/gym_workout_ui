import 'dart:collection';

import 'package:flutter/material.dart';

class ModelExerciseCategory {
  int? id;
  String? categoryName;
  String? imageName;
  // String cat_name_iw;

  ModelExerciseCategory.fromMap(dynamic dynamicObj, BuildContext context) {
    id = dynamicObj['id'];
    // cat_name = dynamicObj['cat_name'];
    imageName = dynamicObj['img_name'];
    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    print("getcatname==$s");
    String catName = 'cat_name_'+s;

    // if (s != "en") {
    //   catName = 'cat_name_' + s;
    // }
    try {
      categoryName = dynamicObj[catName];
      if(categoryName==null)
        {
          categoryName = dynamicObj['cat_name'];
        }
      print("getcat==$categoryName");
    } catch (e) {
      print(e);
      categoryName = dynamicObj['cat_name'];
      print("getcat2==$categoryName");
    }



    print("local==${myLocale.languageCode}==$catName");
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['cat_name'] = categoryName;
    map['img_name'] = imageName;

    return map;
  }
// ModelExerciseCategory({this.id, this.cat_name,this.img_name});
//
// factory ModelExerciseCategory.fromJson(Map<String, dynamic> json) => _$ModelExerciseCategoryFromJson(json);
// Map<String, dynamic> toJson() => _$ModelExerciseCategoryToJson(this);

}

// ModelExerciseCategory _$ModelExerciseCategoryFromJson(Map<String, dynamic> json) {
//   return ModelExerciseCategory(id:json['id'] as int,
//     cat_name: json['cat_name'] as String,
//     img_name: json['img_name'] as String,
//     // dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
//   );
// }
//
// Map<String, dynamic> _$PersonToJson(ModelExerciseCategory instance) => <String, dynamic>{
//   'firstName': instance.firstName,
//   'lastName': instance.lastName,
//   'dateOfBirth': instance.dateOfBirth.toIso8601String(),
// };

// @JsonSerializable()
// class Category {
//   var typeA;
//
//   Category();
//
//   factory Category.fromJson(Map<String, dynamic> json) =>
//       _$CategoryFromJson(json);
//
//   Map<String, dynamic> toJason() => _$CategoryToJson(this);
// }
