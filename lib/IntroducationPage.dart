
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class IntroducationPage extends StatefulWidget {
  @override
  _IntroducationPage createState() => _IntroducationPage();
}

class _IntroducationPage extends State<IntroducationPage> {
  Widget getSizeBox = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = ConstantWidget.getScreenPercentSize(context, 10);
    double circle = ConstantWidget.getPercentSize(height, 30);
    return WillPopScope(
      onWillPop: () async {
        onBackClick();
        return false;
      },
      child: Scaffold(
        // appBar: getThemeAppBar("Add Plan", () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: height,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                              (ConstantWidget.getPercentSize(height, 90))))),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstantWidget.getTextWidget(
                              S.of(context).introduction,
                              Colors.white,
                              TextAlign.start,
                              FontWeight.w600,
                              ConstantWidget.getPercentSize(height, 30)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Container(
                            height: circle,
                            width: circle,
                            decoration: BoxDecoration(
                                color: Colors.black54, shape: BoxShape.circle),
                            margin: EdgeInsets.only(right: 8),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: ConstantWidget.getPercentSize(circle, 80),
                              ),
                            ),
                          ),
                          onTap: () {
                            onBackClick();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height),
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(18),
                  children: [
                    getTitle(S.of(context).planName1),

                    getSubTitle("21 Days Weight Loss Success At Home"),
                    // getSizeBox,

                    getSizeBox,

                    getTitle(S.of(context).description),

                    getSubTitle(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                    getSizeBox,

                    getTitle(S.of(context).benefits),

                    getSubTitle(
                        "Helps lose weight.\nHelp improve mobility and endurance.\nDecrease stress,Improve mood."),
                    getSizeBox,

                    getTitle(S.of(context).intensity),

                    getSubTitle(
                        "Day 1 - 7 Medium\Day 7 - 14 High\nDay 14 - 21 High"),

                    getSizeBox,

                    getTitle(S.of(context).duration),

                    getSubTitle("3 Week"),

                    getSizeBox,

                    getTitle(S.of(context).daysPerWeek),

                    getSubTitle("6"),

                    getSizeBox,

                    getTitle(S.of(context).goal),

                    getSubTitle("Build Muscles"),

                    getSizeBox,

                    getTitle(S.of(context).trainingLevel),

                    getSubTitle("Intermediate"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getTextStyle() {
    return TextStyle(
        fontSize: ConstantWidget.getScreenPercentSize(context, 1.8),
        color: Colors.black54,
        fontFamily: ConstantData.fontsFamily);
  }

  getTitle(String s) {
    return ConstantWidget.getTextWidget(
        s,
        ConstantData.defColor,
        TextAlign.start,
        FontWeight.w600,
        ConstantWidget.getScreenPercentSize(context, 2.3));
  }

  getSubTitle(String s) {
    return ConstantWidget.getTextWidget(s, Colors.black54, TextAlign.start,
        FontWeight.w400, ConstantWidget.getScreenPercentSize(context, 1.8));
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
