import 'dart:collection';

import 'package:flutter/material.dart';

class ModelChallengeMainCat {
  int? id;
  String? title;
  String? img;
  String? introduction;
  String? titleIw;
  String? introductionIw;
  int? week;

  ModelChallengeMainCat.fromMap(dynamic modelObj, BuildContext context) {
    week = modelObj['week'];
    introductionIw = modelObj['introduction_iw'];
    titleIw = modelObj['title_iw'];
    introduction = modelObj['introduction'];
    img = modelObj['img'];
    title = modelObj['title'];
    id = modelObj['id'];
    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    String titles = 'title_' + s;
    String intro = 'introduction_' + s;
    try {
      title = modelObj[titles];
      introduction = modelObj[intro];
      if (title == null) {
        title = modelObj['title'];
      }
      if (introduction == null) {
        introduction = modelObj['introduction'];
      }
    } catch (e) {
      print(e);
      title = modelObj['title'];
      introduction = modelObj['introduction'];
    }
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['img'] = img;
    map['introduction'] = introduction;
    map['title_iw'] = titleIw;
    map['introduction_iw'] = introductionIw;
    map['week'] = week;
    return map;
  }
}
