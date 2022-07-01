import 'dart:collection';


class ModelPlanExerciseTime
{
  int? id;
  int? weekNo;
  int? planExerciseId;
  int? set;
  String? repsCount;
  int? restTime;



  ModelPlanExerciseTime.fromMap(dynamic dynamic)
  {
    weekNo=dynamic['week_no'];
    planExerciseId=dynamic['plan_exercise_id'];
    set=dynamic['set'];
    repsCount=dynamic['reps_count'];
    restTime=dynamic['rest_time'];
    id=dynamic['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['week_no'] = weekNo;
    map['plan_exercise_id'] = planExerciseId;
    map['set'] = set;
    map['reps_count'] = repsCount;
    map['rest_time'] = restTime;
    map['id'] = id;

    return map;
  }

}