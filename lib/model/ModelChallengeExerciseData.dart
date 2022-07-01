import 'dart:collection';


class ModelChallengeExerciseData {
  String? reps;
  int? rest;
  int? sets;
  int? day;
  int? week;
  int? challengeCatId;
  int? id;

  ModelChallengeExerciseData.fromMap(dynamic dynamicObj) {
    rest = dynamicObj['rest'];
    sets = dynamicObj['sets'];
    day = dynamicObj['day'];
    week = dynamicObj['week'];
    challengeCatId = dynamicObj['challenge_cat_id'];
    id = dynamicObj['id'];
    reps = dynamicObj['reps'];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['rest'] = rest;
    map['sets'] = sets;
    map['day'] = day;
    map['week'] = week;
    map['challenge_cat_id'] = challengeCatId;
    map['reps'] = reps;
    map['id'] = id;
    return map;
  }


}
