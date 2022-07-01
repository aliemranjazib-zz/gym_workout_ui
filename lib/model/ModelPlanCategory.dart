import 'dart:collection';

import 'package:flutter/material.dart';

class ModelPlanCategory
{
  int? id;
  String? name;
  String? nameIw;


  ModelPlanCategory();

  ModelPlanCategory.fromMap(dynamic dynamicObj,BuildContext context)
  {
    id=dynamicObj['id'];
    name=dynamicObj['name'];
    nameIw=dynamicObj['name_iw'];

    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    print("getcatname==$s");
    String bodyName = 'name_'+s;
    try {
      name = dynamicObj[bodyName];
      if(name==null)
      {
        name = dynamicObj['name'];
      }
      print("getcat==$name");
    } catch (e) {
      print(e);
      name = dynamicObj['name'];
      print("getcat2==$name");
    }

  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['name_iw'] = nameIw;

    return map;
  }

}