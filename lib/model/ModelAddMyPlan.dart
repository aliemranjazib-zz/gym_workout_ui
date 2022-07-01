import 'dart:collection';


class ModelAddMyPlan {
  int? id;
  int? planCatId;
  int? noWeek;
  int? isCopy;
  String? color;
  String? name;
  String? description;

  ModelAddMyPlan.fromMap(dynamic dynamicObj) {
    description = dynamicObj['description'];
    name = dynamicObj['name'];
    color = dynamicObj['color'];
    isCopy = dynamicObj['is_copy'];
    noWeek = dynamicObj['no_week'];
    planCatId = dynamicObj['plan_cat_id'];
    id = dynamicObj['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['description'] = description;
    map['name'] = name;
    map['color'] = color;
    map['is_copy'] = isCopy;
    map['no_week'] = noWeek;
    map['plan_cat_id'] = planCatId;
    map['id'] = id;
    return map;
  }
}
