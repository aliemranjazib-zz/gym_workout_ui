import 'dart:collection';

import 'package:flutter/material.dart';

class ModelExerciseDetail {
  int? id;
  int? categoryId;
  String? exerciseName;
  String? exerciseDetail;
  String? exerciseImage;
  int? type;
  String? exerciseNameIw;
  String? exerciseDetailIw;
  String? isFavorite;
  String? equipmentName;
  String? equipmentNameIw;
  String? equipmentImage;

  ModelExerciseDetail.fromMap(dynamic dynamicObj,BuildContext context) {
    equipmentImage = dynamicObj['equipment_img'];
    equipmentNameIw = dynamicObj['equipment_name_iw'];
    isFavorite = dynamicObj['is_favorite'];
    exerciseDetailIw = dynamicObj['exercise_detail_iw'];
    exerciseNameIw = dynamicObj['exercise_name_iw'];
    type = dynamicObj['type'];
    exerciseImage = dynamicObj['exercise_img'];
    // exercise_detail = dynamicObj['exercise_detail'];
    // exercise_name = dynamicObj['exercise_name'];
    categoryId = dynamicObj['cat_id'];
    id = dynamicObj['id'];

    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    print("getcatname==$s");
    String catName = 'exercise_name_'+s;
    String catDetail = 'exercise_detail_'+s;
    String equipment = 'equipment_name_'+s;
    try {
      exerciseName = dynamicObj[catName];
      exerciseDetail = dynamicObj[catDetail];
      equipmentName = dynamicObj[equipment];

      if(equipmentName==null)
      {
        equipmentName = dynamicObj['equipment_name'];
      }
       if(exerciseName==null)
      {
        exerciseName = dynamicObj['exercise_name'];
      }

      if(exerciseDetail==null)
        {
          exerciseDetail = dynamicObj['exercise_detail'];

        }
      print("getcat==$exerciseName==$exerciseDetail");
    } catch (e) {
      print(e);
      exerciseName = dynamicObj['exercise_name'];
      exerciseDetail = dynamicObj['exercise_detail'];
      equipmentName = dynamicObj['equipment_name'];

      print("getcat2==$exerciseName==$exerciseDetail");
    }


  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['equipment_img'] = equipmentImage;
    map['equipment_name_iw'] = equipmentNameIw;
    map['equipment_name'] = equipmentName;
    map['is_favorite'] = isFavorite;
    map['exercise_detail_iw'] = exerciseDetailIw;
    map['exercise_name_iw'] = exerciseNameIw;
    map['type'] = type;
    map['exercise_img'] = exerciseImage;
    map['exercise_detail'] = exerciseDetail;
    map['exercise_name'] = exerciseName;
    map['cat_id'] = categoryId;
    map['id'] = id;
    return map;
  }
}
