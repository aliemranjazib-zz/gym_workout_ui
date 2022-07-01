import 'dart:collection';


class ModelMyPlanExercise {

  int? id;
  int? day;
  int? week;
  int? exerciseId;
  int? myPlanId;
  int? noSets;
  int? weight;
  int? rest;
  String? noReps;



  ModelMyPlanExercise.fromMap(dynamic dynamicObj)
  {
    day=dynamicObj['day'];
    week=dynamicObj['week'];
    exerciseId=dynamicObj['exercise_id'];
    myPlanId=dynamicObj['my_plan_id'];
    noSets=dynamicObj['no_sets'];
    weight=dynamicObj['weight'];
    rest=dynamicObj['rest'];
    noReps=dynamicObj['no_reps'];
    id=dynamicObj['id'];
  }


  Map<String,dynamic> toMap()
  {
    var map=new HashMap<String,dynamic>();
    map['day']=day;
    map['week']=week;
    map['exercise_id']=exerciseId;
    map['my_plan_id']=myPlanId;
    map['no_sets']=noSets;
    map['weight']=weight;
    map['rest']=rest;
    map['no_reps']=noReps;
    map['id']=id;

    return map;
  }

}
