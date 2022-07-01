import 'dart:collection';

import 'package:flutter/material.dart';

class ModelEquipment {
  int? id;
  int? referenceDetailId;
  String? equipmentImage;
  String? bodyName;
  String? bodyNameIw;

  ModelEquipment.fromMap(dynamic obj,BuildContext context) {
    id = obj['id'];
    referenceDetailId = obj['reference_detail_id'];
    equipmentImage = obj['equpment_image'];
    bodyName = obj['body_name'];
    Locale myLocale = Localizations.localeOf(context);
    String s = myLocale.languageCode;
    print("getcatname==$s");
    String textName = 'body_name_'+s;
    try {
      bodyName = obj[textName];
      if(bodyName==null)
      {
        bodyName = obj['body_name'];
      }
    } catch (e) {
      print(e);
      bodyName = obj['body_name'];
    }
    // body_name_iw = obj['body_name_iw'];
  }

  Map<String, dynamic> toMap() {
    var map = new HashMap<String, dynamic>();
    map['body_name_iw'] = bodyNameIw;
    map['body_name'] = bodyName;
    map['equpment_image'] = equipmentImage;
    map['reference_detail_id'] = referenceDetailId;
    map['id'] = id;

    return map;
  }
}
