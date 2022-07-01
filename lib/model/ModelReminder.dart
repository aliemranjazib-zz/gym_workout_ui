import 'dart:collection';


class ModelReminder {
  int? id;
  String? time;
  String? repeat;
  String? ison;

  ModelReminder.fromMap(dynamic dynamicObj) {
    id = dynamicObj["id"];
    time = dynamicObj["time"];
    repeat = dynamicObj["repeat"];
    ison = dynamicObj["ison"];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['time'] = time;
    map['repeat'] = repeat;
    map['ison'] = ison;
    return map;
  }
}
