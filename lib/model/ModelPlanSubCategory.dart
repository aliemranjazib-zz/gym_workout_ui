import 'dart:collection';
import 'package:flutter/material.dart';

class ModelPlanSubCategory {
  int? id;
  int? catId;
  int? type;
  int? noWeek;
  String? name;
  String? introduction;
  String? image;
  String? nameIw;
  String? introductionIw;

  ModelPlanSubCategory.fromMap(dynamic dynamicObj, BuildContext context) {
    id = dynamicObj['id'];
    catId = dynamicObj['cat_id'];
    type = dynamicObj['type'];
    noWeek = dynamicObj['no_week'];
    name = dynamicObj['name'];
    introduction = dynamicObj['introduction'];
    image = dynamicObj['image'];
    nameIw = dynamicObj['name_iw'];
    introductionIw = dynamicObj['introduction_iw'];

    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    print("getcatname==$s");
    String bodyName = 'name_' + s;
    String intro = 'introduction_' + s;
    try {
      name = dynamicObj[bodyName];
      introduction = dynamicObj[intro];
      if (name == null) {
        name = dynamicObj['name'];
      }
      if (introduction == null) {
        introduction = dynamicObj['introduction'];
      }
      print("getcat==$name");
    } catch (e) {
      print(e);
      name = dynamicObj['name'];
      introduction = dynamicObj['introduction'];
      print("getcat2==$name");
    }
  }


  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['cat_id'] = catId;
    map['type'] = type;
    map['no_week'] = noWeek;
    map['name'] = name;
    map['introduction'] = introduction;
    map['image'] = image;
    map['name_iw'] = nameIw;
    map['introduction_iw'] = introductionIw;

    return map;
  }
}
