import 'dart:collection';


class ModelPlanExerciseData {


  int? id;
  int? catId;
  int? subCatId;
  int? day;
  int? exerciseId;


  ModelPlanExerciseData.fromMap(dynamic dynamic)
  {
    id=dynamic['id'];
    catId=dynamic['cat_id'];
    subCatId=dynamic['sub_cat_id'];
    day=dynamic['day'];
    exerciseId=dynamic['exercise_id'];
  }


  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['cat_id'] = catId;
    map['sub_cat_id'] = subCatId;
    map['day'] = day;
    map['exercise_id'] = exerciseId;

    return map;
  }

}
