import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/HomeScreen.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/PrefData.dart';
import 'package:numberpicker/numberpicker.dart';

import 'SizeConfig.dart';
import 'generated/l10n.dart';
import 'model/IntensivelyModel.dart';

class FirstPage extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // FirstPage(this.onChanged);

  @override
  _FirstPage createState() {
    return _FirstPage();
    // return _FirstPage(this.onChanged);
  }
}

class _FirstPage extends State<FirstPage> {
  int _position = 0;
  double? margin;
  List<IntensivelyModel> intensivelyList = ConstantData.getIntensivelyModel();
  int selectIntensively = 0;

  bool isMale = true;

  int cm = 80;
  int age = 20;
  int inch = 25;
  int ft = 25;
  int kg = 25;
  double lbs = 25;

  Future<bool> _requestPop() {
    if (_position > 0) {
      setState(() {
        _position--;
      });
    } else {
      exitApp();
      // Future.delayed(const Duration(milliseconds: 200), () {
      //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
    }

    return new Future.value(false);
  }

  int totalPosition = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setLbsValue();
  }

  setLbsValue() {
    lbs = kg * 2.205;
    lbs = double.parse((lbs).toStringAsFixed(0));

    double total = (cm / 2.54);
    double value = (total / 12);
    double value1 = (total - 12) * value.toInt();

    print("total----$total------$value--------$value1");

    ft = value.toInt();
    inch = value1.toInt();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    margin = ConstantWidget.getScreenPercentSize(context, 2);
    setState(() {});

    return WillPopScope(
        child: Scaffold(
          backgroundColor: mainBgColor,
          appBar: AppBar(
            backgroundColor: mainBgColor,
            elevation: 0,
            title: Text(""),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace_sharp,
                color: Colors.black,
              ),
              onPressed: _requestPop,
            ),
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ConstantWidget.getScreenPercentSize(context, 2)),
                child: getPositionWidget(),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: defMargin),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: Container(
                          height:
                              ConstantWidget.getScreenPercentSize(context, 7),
                          margin: EdgeInsets.only(bottom: (defMargin * 2)),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular((defMargin / 2)))),
                          child: InkWell(
                            child: Center(
                              child: ConstantWidget.getCustomTextWithoutAlign(
                                  S.of(context).continueText,
                                  Colors.white,
                                  FontWeight.w500,
                                  ConstantData.font22Px),
                            ),
                          )),
                      onTap: () {
                        if (_position < (totalPosition - 1)) {
                          _position++;

                          setState(() {});
                        } else {
                          PrefData.setIsFirstTime(false);
                          Navigator.of(context).pop(true);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(0),
                              ));
                        }
                      },
                    ),
                  )),
              Container(
                height: ConstantWidget.getScreenPercentSize(context, 0.7),
                child: Row(
                  children: [
                    for (int i = 0; i < totalPosition; i++)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          color: (i <= _position) ? primaryColor : Colors.grey,
                          height: double.infinity,
                        ),
                        flex: 1,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  getPositionWidget() {
    if (_position == 0) {
      return firstWidget();
    } else if (_position == 1) {
      return secondWidget();
    } else if (_position == 2) {
      return thirdWidget();
    } else if (_position == 3) {
      return ageWidget();
    } else if (_position == 4) {
      return getIntensively();
    }
  }

  Widget getIntensively() {
    SizeConfig().init(context);
    Widget space = SizedBox(
      height: margin,
    );
    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderView("How intensively you workout?",
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
            space,
            Expanded(
              child: ListView.builder(
                itemCount: intensivelyList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == selectIntensively);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectIntensively = index;
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      color: isSelect ? primaryColor : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              ConstantWidget.getScreenPercentSize(
                                  context, 1.5)))),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: (margin!), vertical: (margin! / 2)),
                        decoration: BoxDecoration(
                            // color: isSelect ? primaryColor : Colors.transparent,
                            // borderRadius: BorderRadius.all(Radius.circular(
                            //     ConstantWidget.getScreenPercentSize(
                            //         context, 1.5))),
                            // border: Border.all(
                            //     color: isSelect ? Colors.transparent : primaryColor,
                            //     width: 1.5)

                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            space,
                            ConstantWidget.getTextWidget(
                                intensivelyList[index].title!,
                                isSelect ? Colors.white : Colors.black,
                                TextAlign.center,
                                FontWeight.bold,
                                ConstantWidget.getScreenPercentSize(
                                    context, 1.8)),
                            SizedBox(
                              height: margin! / 2,
                            ),
                            ConstantWidget.getTextWidget(
                                intensivelyList[index].desc!,
                                isSelect ? Colors.white : Colors.black,
                                TextAlign.center,
                                FontWeight.w400,
                                ConstantWidget.getScreenPercentSize(
                                    context, 1.5)),
                            space,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getHeaderView(String s, String subTitle) {
    Widget space = SizedBox(
      height: margin,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space,
        getTitleWidget(s),
        space,
        getSubTitleWidget(subTitle),
      ],
    );
  }

  getTitleWidget(String s) {
    return ConstantWidget.getTextWidget(s, Colors.black, TextAlign.start,
        FontWeight.bold, ConstantWidget.getScreenPercentSize(context, 2.5));
  }

  getSubTitleWidget(String s) {
    return ConstantWidget.getTextWidget(s, Colors.grey, TextAlign.start,
        FontWeight.w300, ConstantWidget.getScreenPercentSize(context, 1.8));
  }

  Widget ageWidget() {
    double subHeight = ConstantWidget.getWidthPercentSize(context, 32);

    return Container(
      margin: EdgeInsets.all(margin!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstantWidget.getTextWidget(
              "How old are you?",
              Colors.black,
              TextAlign.center,
              FontWeight.bold,
              ConstantWidget.getScreenPercentSize(context, 4)),
          // SizedBox(
          //   height: ConstantWidget.getScreenPercentSize(context,3),
          // ),
          //
          //
          // ConstantWidget.getTextWidget(
          //     age.toString(),
          //     Colors.black,
          //     TextAlign.center,
          //     FontWeight.bold,
          //     ConstantWidget.getScreenPercentSize(context, 4)),

          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 3),
          ),

          ConstantWidget.getTextWidget(
              age.toString(),
              Colors.black,
              TextAlign.center,
              FontWeight.w600,
              ConstantWidget.getPercentSize(subHeight, 20)),

          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 15),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: NumberPicker(
                value: age,
                minValue: 20,
                maxValue: 100,
                step: 1,
                itemHeight: 100,
                axis: Axis.horizontal,
                textStyle: TextStyle(
                    fontSize: ConstantWidget.getScreenPercentSize(context, 2),
                    color: Colors.black,
                    fontFamily: ConstantData.fontsFamily),
                selectedTextStyle: TextStyle(
                    fontSize: ConstantWidget.getScreenPercentSize(context, 5),
                    color: primaryColor,
                    fontFamily: ConstantData.fontsFamily),
                onChanged: (value) => setState(() => age = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),

                  // color: primaryColor,
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget thirdWidget() {
    double height = ConstantWidget.getWidthPercentSize(context, 40);
    double cellHeight = ConstantWidget.getWidthPercentSize(context, 12);
    double subHeight = ConstantWidget.getWidthPercentSize(context, 32);

    return Container(
      margin: EdgeInsets.all(margin!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getTextWidget(
              S.of(context).howTallAreYou,
              Colors.black,
              TextAlign.left,
              FontWeight.bold,
              ConstantWidget.getScreenPercentSize(context, 4.2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 0.5),
          ),
          ConstantWidget.getTextWidget(
              S.of(context).toGiveYouABetterExperienceNweNeedToKnowHeight,
              Colors.black54,
              TextAlign.left,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 3),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: (height * 1.3),
                width: height,
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ConstantWidget.getScreenPercentSize(context, 1)),
                padding: EdgeInsets.symmetric(
                    vertical:
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                child: Stack(
                  children: [
                    Container(
                      width: (subHeight * 1.2),
                      height: subHeight,
                      margin: EdgeInsets.only(top: cellHeight / 2),
                      padding: EdgeInsets.only(
                          left: cellHeight / 2, bottom: cellHeight / 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ConstantWidget.getTextWidget(
                              cm.toString(),
                              Colors.black,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 25)),
                          ConstantWidget.getTextWidget(
                              S.of(context).cm,
                              primaryColor,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ],
                      ),
                    ),
                    Container(
                      width: cellHeight,
                      height: cellHeight,
                      margin: EdgeInsets.only(left: (cellHeight / 2)),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(cellHeight, 30)),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstantData.assetImagesPath + "height.png",
                          height: ConstantWidget.getPercentSize(cellHeight, 40),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (height * 1.3),
                width: height,
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ConstantWidget.getScreenPercentSize(context, 1)),
                padding: EdgeInsets.symmetric(
                    vertical:
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                child: Stack(
                  children: [
                    Container(
                      width: (subHeight * 1.2),
                      height: subHeight,
                      margin: EdgeInsets.only(top: cellHeight / 2),
                      padding: EdgeInsets.only(
                          left: cellHeight / 2, bottom: cellHeight / 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Expanded(
                          //   child:
                          ConstantWidget.getTextWidget(
                              ft.toString(),
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 20)),
                          // ),
                          ConstantWidget.getTextWidget(
                              S.of(context).ft,
                              primaryColor,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 15)),

                          SizedBox(
                            width: ConstantWidget.getPercentSize(subHeight, 5),
                          ),
                          ConstantWidget.getTextWidget(
                              inch.toString(),
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 20)),
                          // ),
                          ConstantWidget.getTextWidget(
                              S.of(context).inches,
                              primaryColor,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ],
                      ),
                    ),
                    Container(
                      width: cellHeight,
                      height: cellHeight,
                      margin: EdgeInsets.only(left: (cellHeight / 2)),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(cellHeight, 30)),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstantData.assetImagesPath + "ft.png",
                          height: ConstantWidget.getPercentSize(cellHeight, 40),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: ConstantWidget.getWidthPercentSize(context, 70),
              // decoration: BoxDecoration(
              //   color: ConstantData.cellColor,
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(ConstantWidget.getScreenPercentSize(context,2)),
              //   ),
              // ),

              padding: EdgeInsets.symmetric(
                  vertical: ConstantWidget.getScreenPercentSize(context, 2.5)),

              child: Align(
                alignment: Alignment.topCenter,
                child: NumberPicker(
                  value: cm,
                  minValue: 80,
                  maxValue: 350,
                  textStyle: TextStyle(
                      fontSize: ConstantWidget.getScreenPercentSize(context, 2),
                      color: Colors.black,
                      fontFamily: ConstantData.fontsFamily),
                  selectedTextStyle: TextStyle(
                      fontSize: ConstantWidget.getScreenPercentSize(context, 5),
                      color: primaryColor,
                      fontFamily: ConstantData.fontsFamily),
                  step: 1,
                  haptics: true,
                  onChanged: (value) => setState(() {
                    cm = value;
                    setLbsValue();
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondWidget() {
    double height = ConstantWidget.getWidthPercentSize(context, 40);
    double cellHeight = ConstantWidget.getWidthPercentSize(context, 12);
    double subHeight = ConstantWidget.getWidthPercentSize(context, 32);

    return Container(
      margin: EdgeInsets.all(margin!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getTextWidget(
              S.of(context).whatIsYourWeight,
              Colors.black,
              TextAlign.left,
              FontWeight.bold,
              ConstantWidget.getScreenPercentSize(context, 4.2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 0.5),
          ),
          ConstantWidget.getTextWidget(
              S.of(context).toGiveYouABetterExperienceNweNeedToKnow,
              Colors.black54,
              TextAlign.left,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 3),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: (height * 1.3),
                width: height,
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ConstantWidget.getScreenPercentSize(context, 1)),
                padding: EdgeInsets.symmetric(
                    vertical:
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                child: Stack(
                  children: [
                    Container(
                      width: (subHeight * 1.2),
                      height: subHeight,
                      margin: EdgeInsets.only(top: cellHeight / 2),
                      padding: EdgeInsets.only(
                          left: cellHeight / 2, bottom: cellHeight / 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ConstantWidget.getTextWidget(
                              kg.toString(),
                              Colors.black,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 25)),
                          ConstantWidget.getTextWidget(
                              S.of(context).kg,
                              primaryColor,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ],
                      ),
                    ),
                    Container(
                      width: cellHeight,
                      height: cellHeight,
                      margin: EdgeInsets.only(left: (cellHeight / 2)),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(cellHeight, 30)),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstantData.assetImagesPath + "dumbbell.png",
                          height: ConstantWidget.getPercentSize(cellHeight, 40),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (height * 1.3),
                width: height,
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ConstantWidget.getScreenPercentSize(context, 1)),
                padding: EdgeInsets.symmetric(
                    vertical:
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                child: Stack(
                  children: [
                    Container(
                      width: (subHeight * 1.2),
                      height: subHeight,
                      margin: EdgeInsets.only(top: cellHeight / 2),
                      padding: EdgeInsets.only(
                          left: cellHeight / 2, bottom: cellHeight / 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Expanded(
                          //   child:
                          ConstantWidget.getTextWidget(
                              lbs.toInt().toString(),
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 25)),
                          // ),
                          ConstantWidget.getTextWidget(
                              S.of(context).lbs,
                              primaryColor,
                              TextAlign.end,
                              FontWeight.w300,
                              ConstantWidget.getPercentSize(subHeight, 15)),
                        ],
                      ),
                    ),
                    Container(
                      width: cellHeight,
                      height: cellHeight,
                      margin: EdgeInsets.only(left: (cellHeight / 2)),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              ConstantWidget.getPercentSize(cellHeight, 30)),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          ConstantData.assetImagesPath + "weighing-scale.png",
                          height: ConstantWidget.getPercentSize(cellHeight, 40),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(
              //       ConstantWidget.getScreenPercentSize(context, 1)),
              //   height: subHeight,
              //   width: subHeight,
              //   decoration: BoxDecoration(
              //     color: ConstantData.cellColor,
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(
              //           ConstantWidget.getScreenPercentSize(context, 2)),
              //     ),
              //   ),
              //   padding: EdgeInsets.symmetric(
              //       vertical:
              //           ConstantWidget.getScreenPercentSize(context, 2.5)),
              // )
            ],
          ),

          Center(
            child: Container(
              width: ConstantWidget.getWidthPercentSize(context, 70),
              // decoration: BoxDecoration(
              //   color: ConstantData.cellColor,
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(ConstantWidget.getScreenPercentSize(context,2)),
              //   ),
              // ),

              padding: EdgeInsets.symmetric(
                  vertical: ConstantWidget.getScreenPercentSize(context, 2.5)),

              child: Align(
                alignment: Alignment.topCenter,
                child: NumberPicker(
                  value: kg,
                  minValue: 20,
                  maxValue: 250,
                  textStyle: TextStyle(
                      fontSize: ConstantWidget.getScreenPercentSize(context, 2),
                      color: Colors.black,
                      fontFamily: ConstantData.fontsFamily),
                  selectedTextStyle: TextStyle(
                      fontSize: ConstantWidget.getScreenPercentSize(context, 5),
                      color: primaryColor,
                      fontFamily: ConstantData.fontsFamily),
                  step: 1,
                  haptics: true,
                  onChanged: (value) => setState(() {
                    kg = value;
                    setLbsValue();
                  }),
                ),
              ),
            ),
          ),

          // NumberPicker(
          //   value: 2,
          //   minValue: 80,
          //   maxValue: 350,
          //   step: 10,
          //   haptics: true,
          //   onChanged: (value) => setState(() {
          //
          //   }),
          // ),
        ],
      ),
    );
  }

  Widget firstWidget() {
    return Container(
      margin: EdgeInsets.all(margin!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstantWidget.getTextWidget(
              S.of(context).selectGender,
              Colors.black,
              TextAlign.left,
              FontWeight.bold,
              ConstantWidget.getScreenPercentSize(context, 4.2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 0.5),
          ),
          ConstantWidget.getTextWidget(
              S.of(context).pleaseSelectYourGender,
              Colors.black54,
              TextAlign.left,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 2)),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: getMaleCell(),
                flex: 1,
              ),
              Expanded(
                child: getFemaleCell(),
                flex: 1,
              )
            ],
          )
        ],
      ),
    );
  }

  getMaleCell() {
    double height = ConstantWidget.getWidthPercentSize(context, 50);

    double radius = ConstantWidget.getPercentSize(height, 4);
    double size = ConstantWidget.getPercentSize(height, 40);
    double subImage = ConstantWidget.getPercentSize(size, 60);
    return InkWell(
      child: Container(
        height: height,
        // width: width,
        margin:
            EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 1.5)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: (isMale)
                  ? ConstantData.subPrimaryColor
                  : ConstantData.cellColor,
              width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size,
              width: size,
              margin: EdgeInsets.only(
                  bottom: ConstantWidget.getPercentSize(height, 5)),
              decoration: BoxDecoration(
                  color: ConstantData.subPrimaryColor, shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  ConstantData.assetImagesPath + "male.png",
                  height: subImage,
                ),
              ),
            ),
            ConstantWidget.getTextWidget(
                S.of(context).male,
                Colors.black,
                TextAlign.left,
                FontWeight.w300,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
          ],
        ),
      ),
      onTap: () {
        isMale = true;

        setState(() {});
      },
    );
  }

  getFemaleCell() {
    double height = ConstantWidget.getWidthPercentSize(context, 50);

    double radius = ConstantWidget.getPercentSize(height, 4);
    double size = ConstantWidget.getPercentSize(height, 40);
    double subImage = ConstantWidget.getPercentSize(size, 60);
    return InkWell(
      child: Container(
        height: height,
        // width: width,
        margin:
            EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 1.5)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: (!isMale)
                  ? ConstantData.subPrimaryColor
                  : ConstantData.cellColor,
              width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size,
              width: size,
              margin: EdgeInsets.only(
                  bottom: ConstantWidget.getPercentSize(height, 5)),
              decoration: BoxDecoration(
                  color: ConstantData.subPrimaryColor, shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  ConstantData.assetImagesPath + "female.png",
                  height: subImage,
                ),
              ),
            ),
            ConstantWidget.getTextWidget(
                S.of(context).female,
                Colors.black,
                TextAlign.left,
                FontWeight.w300,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
          ],
        ),
      ),
      onTap: () {
        isMale = false;

        setState(() {});
      },
    );
  }
}

// https://cdn.dribbble.com/users/1246317/screenshots/5393591/bmi-calculator_4x.png?compress=1&resize=400x300
