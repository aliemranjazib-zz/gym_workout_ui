import 'dart:collection';


class ModelPlanCompleteData {
  int? id;
  int? catId;
  int? subCatId;
  int? noWeek;
  int? noDay;
  int? planExerciseId;


  ModelPlanCompleteData.fromMap(dynamic dynamicObj)
  {
    planExerciseId=dynamicObj["plan_exercise_id"];
    noDay=dynamicObj["no_day"];
    noWeek=dynamicObj["no_week"];
    subCatId=dynamicObj["sub_cat_id"];
    catId=dynamicObj["cat_id"];
    id=dynamicObj[id];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['plan_exercise_id'] = planExerciseId;
    map['no_day'] = noDay;
    map['no_week'] = noWeek;
    map['sub_cat_id'] = subCatId;   map['cat_id'] = catId;
    map['id'] = id;

    return map;
  }
}
