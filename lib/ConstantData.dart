import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SizeConfig.dart';
import 'model/IntensivelyModel.dart';

// Color defPrimaryColor = "#0053A6".toColor();
Color defPrimaryColor = Colors.orange;
Color mainBgColor = Colors.grey.shade100;
Color primaryColor = "#142B44".toColor();
// Color primaryColor = "#102C45".toColor();
String arialFont = "Arial";
String bebasneueFont = "Bebasneue";
String meriendaOneFont = "MeriendaOne";

class ConstantData {
  static const double avatarRadius = 40;
  static const double padding = 20;
  static String fontsFamily = 'SFProText';
  static String assetImagesPath = 'assets/imgs/';
  static String assetHomeImagesPath = 'assets/homeImages/';
  static int defaultRepsCount = 12;
  static Color subPrimaryColor = "#084043".toColor();
  // static Color primaryColor = "#FCC414".toColor();
  static Color bgColor = "#EBEBEB".toColor();

  static final String defTimeZoneName = "America/Detroit";

  static Color cellColor = "#e1e2e2".toColor();
  static Color defCellColor = "#ffffff".toColor();
  static Color color1 = "#FFE5E5".toColor();
  static Color color2 = "#E5FFF3".toColor();
  static Color color3 = "#FFE5F6".toColor();
  static Color color4 = "#ECE5FF".toColor();
  // static Color cellColor = "#E4E4E4".toColor();
  static Color defColor = "#12153D".toColor();

  static double font15Px = SizeConfig.safeBlockVertical! / 0.6;

  static double font12Px = SizeConfig.safeBlockVertical! / 0.75;

  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;
  static double font20Px = SizeConfig.safeBlockVertical! / 0.58;
  static double font22Px = SizeConfig.safeBlockVertical! / 0.4;
  static double font25Px = SizeConfig.safeBlockVertical! / 0.3;

  static ThemeData themeData = new ThemeData(
    primaryColor: new Color(0xFF102B46),
    primaryColorDark: new Color(0xFF102B46),
    // accentColor: new Color(0xFFF1C40E),
    backgroundColor: Colors.white,

    // textTheme: TextTheme().apply(bodyColor: Colors.black),

    // primaryColorDark: new Color(0xFFF1C40E),
  );

  static String getExerciseTypeStr(int i, BuildContext context) {
    switch (i) {
      case 1:
        return S.of(context).beginner;
      case 2:
        return S.of(context).intemediate;
      case 3:
        return S.of(context).advanced;
    }
    return "";
  }

  static List<IntensivelyModel> getIntensivelyModel() {
    List<IntensivelyModel> list = [];

    IntensivelyModel model = new IntensivelyModel();
    model.title = "Beginner";
    // model.title = "Low";
    model.desc =
        "Low impact strength training refers to exercise that is easy and gentle on your joints and tendons.";
    list.add(model);

    model = new IntensivelyModel();
    model.title = "Advance";
    // model.title = "Moderate";
    model.desc =
        "Many physical activity recommendations report that moderate exercise is important for health and well-being..";
    list.add(model);

    model = new IntensivelyModel();
    // model.title = "High";
    model.title = "Intermediate ";
    model.desc =
        "While it's often referred to as \"runner's high,\"these feelings can also occur with other forms of aerobic.";
    list.add(model);

    return list;
  }

// static String getLocalNameFromModel(
  //     BuildContext context, ModelExerciseCategory category) {
  //   print("objecy=${category.toString()}");
  //   // Map<String, dynamic> parsedMap = jsonEDecode(category);
  //   String resp = jsonEncode(category);
  //
  //   //   print("modelset===${jsonEncode(category)}");
  //   // var map=Map<String, dynamic>.from(category.toMap());
  //   // var map=category.toMap();
  //   return 'id';
  // }

}

launchURL() async {
  await launch("https://google.com");
}

void exitApp() {
  if (Platform.isIOS) {
    exit(0);
  } else {
    SystemNavigator.pop();
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // });
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
