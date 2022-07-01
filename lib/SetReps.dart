import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healtho_app/ConstantColors.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/MyPlanWeekList.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class SetReps extends StatefulWidget {
  final ModelExerciseCategory modelExerciseCategory;
  final List<ModelExerciseDetail> exerciseDetailList;
  final  ModelAddMyPlan modelAddMyPlan;
  final  int getWeek;
  final  int getDay;

  SetReps(this.modelExerciseCategory, this.exerciseDetailList,
      this.modelAddMyPlan, this.getWeek, this.getDay);

  // SetReps(this.modelExerciseCategory, this.exerciseDetailList);

  @override
  _SetReps createState() => _SetReps();
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () {
                onPageSelected!(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}

class _SetReps extends State<SetReps> {
  List<List<int>> intList = [];
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingController1 = new TextEditingController();
  int duration = 10;

  @override
  void initState() {
    for (int i = 0; i < widget.exerciseDetailList.length; i++) {
      List<int> _lis = [];
      _lis.add(ConstantData.defaultRepsCount);
      intList.add(_lis);
    }
    textEditingController.text = "10";
    textEditingController1.text = "10";
    textEditingController2.text = "10";
    setState(() {});
    super.initState();
  }


  int selectedPos = 0;
  TextEditingController textEditingController2 = new TextEditingController();
  int setSize = 1;

  @override
  Widget build(BuildContext context) {
    double imgHeight = ConstantWidget.getScreenPercentSize(context, 12);
    double defWidth = ConstantWidget.getWidthPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 2);

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: getThemeAppBar("dyt5r", () {
        //   onBackClick();
        // }),

        resizeToAvoidBottomInset: false,

        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBar(
                  context, widget.modelExerciseCategory.categoryName!, () {
                onBackClick();
              }),
              Container(
                  margin: EdgeInsets.only(
                      top: ConstantWidget.getMarginTop(context) - 8),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: imgHeight,
                        child: ListView.builder(
                          itemCount: widget.exerciseDetailList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPos = index;
                                });
                              },
                              child: Container(
                                height: imgHeight,
                                width: imgHeight,
                                margin: EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      ConstantData.assetImagesPath +
                                          "abs_1.png",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                    Visibility(
                                      child: Container(
                                        color: Colors.white.withOpacity(0.5),
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      visible: (selectedPos == index),
                                    ),
                                    Visibility(
                                      child: Center(
                                        child: Icon(
                                          Icons.check_box_outlined,
                                          color: Colors.black,
                                          size: ConstantWidget.getPercentSize(
                                              imgHeight, 30),
                                        ),
                                      ),
                                      visible: (selectedPos == index),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Container()),
                              ConstantWidget.getTextWidget(
                                  S.of(context).rest + ":",
                                  Colors.black,
                                  TextAlign.start,
                                  FontWeight.w300,
                                  ConstantData.font18Px),
                              Container(
                                  width: imgHeight,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  // height: ConstantWidget
                                  //     .getScreenPercentSize(context, 4),
                                  child: TextField(
                                    controller: textEditingController2,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                      disabledBorder: OutlineInputBorder(),
                                      isDense: true,
                                      // Added this
                                      contentPadding:
                                          EdgeInsets.all(8), // Added this
                                    ),
                                  )),
                              ConstantWidget.getTextWidget(
                                  S.of(context).seconds,
                                  Colors.black,
                                  TextAlign.start,
                                  FontWeight.w300,
                                  ConstantData.font15Px),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConstantWidget.getTextWidget(
                              "Sets & Reps",
                              Colors.black,
                              TextAlign.start,
                              FontWeight.bold,
                              ConstantData.font15Px),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Row(
                              children: [
                                Container(
                                  width: defWidth,
                                  child: ConstantWidget.getTextWidget(
                                      "Sets",
                                      ConstantData.defColor,
                                      TextAlign.start,
                                      FontWeight.w600,
                                      ConstantData.font15Px),
                                ),
                                Expanded(
                                  child: Center(
                                    child: ConstantWidget.getTextWidget(
                                        "Reps",
                                        ConstantData.defColor,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantData.font15Px),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: ConstantWidget.getTextWidget(
                                        "Weight(Kg)",
                                        ConstantData.defColor,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantData.font15Px),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            itemCount: setSize,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                 elevation: 2,
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(6))
                                 ),
                                margin: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 15),
                                  // decoration: BoxDecoration(
                                  //     color: ConstantData.cellColor,
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(6))),

                                  child: Row(
                                    children: [
                                      Container(
                                        width: defWidth,
                                        child: ConstantWidget.getTextWidget(
                                            "Sets " + ((index + 1).toString()),
                                            ConstantData.defColor,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantData.font15Px),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          height:
                                              ConstantWidget.getScreenPercentSize(
                                                  context, 4),
                                          child: TextField(
                                            style: TextStyle(
                                                fontFamily:
                                                    ConstantData.fontsFamily,
                                                fontSize: ConstantData.font12Px),
                                            controller: textEditingController1,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            textAlign: TextAlign.center,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                              OutlineInputBorder(),
                                              disabledBorder:
                                              OutlineInputBorder(),
                                              isDense: true,
                                              // Added this
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              child: Container(
                                                margin: EdgeInsets.only(right: 5),
                                                height: height,
                                                width: height,
                                                color: Colors.grey.shade600,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: ConstantData.cellColor,
                                                    size: ConstantWidget.getPercentSize(height, 70),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                // setState.setState(() {

                                                setState(() {
                                                  if (duration > 0) {
                                                    duration--;
                                                    textEditingController.text =
                                                        duration.toString();
                                                  }
                                                });
                                              },
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                height:   ConstantWidget.getScreenPercentSize(
                                                    context, 4),
                                                child: TextField(
                                                  controller:
                                                      textEditingController,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(r'[0-9]')),
                                                  ],
                                                  style: TextStyle(
                                                      fontFamily: ConstantData
                                                          .fontsFamily,
                                                      fontSize:
                                                          ConstantData.font12Px),
                                                  textAlign: TextAlign.center,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(),
                                                    disabledBorder:
                                                        OutlineInputBorder(),
                                                    isDense: true,
                                                    // Added this
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  duration = duration + 1;
                                                  textEditingController.text =
                                                      duration.toString();
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5),
                                                height: height,
                                                width: height,
                                                color: Colors.grey.shade600,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: ConstantData.cellColor,
                                                    size: ConstantWidget
                                                        .getPercentSize(
                                                            height, 70),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                      Container(
                        height: height * 2.5,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    setSize++;
                                  });
                                },
                                child: Container(
                                  height: height * 2.5,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ConstantWidget.getTextWidget(
                                          S.of(context).addSet,
                                          Colors.white,
                                          TextAlign.start,
                                          FontWeight.w600,
                                          ConstantData.font15Px),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (setSize > 1) {
                                      setSize--;
                                    }
                                  });
                                },
                                child: Container(
                                  height: height * 2.5,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      color: ConstantData.cellColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      ConstantWidget.getTextWidget(
                                          S.of(context).removeSet,
                                          Colors.grey,
                                          TextAlign.start,
                                          FontWeight.w600,
                                          ConstantData.font15Px),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (widget.exerciseDetailList.length > 0) {
                              addDatas(0);
                              _databaseHelper
                                  .addAllMyPlanExercise(
                                      widget.modelAddMyPlan.id!,
                                      widget.getWeek,
                                      widget.getDay,
                                      widget.exerciseDetailList,
                                      intList)
                                  .then((value) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return MyPlanWeekList(
                                        widget.modelAddMyPlan, widget.getWeek);
                                  },
                                ));
                              });
                            }

                            //
                            // Navigator.of(context)
                            //     .pushReplacement(MaterialPageRoute(
                            //   builder: (context) {
                            //     return MyPlanWeekList(
                            //         widget.modelAddMyPlan, widget.getWeek);
                            //   },
                            // ));
                          },
                          child: Container(
                            height: height * 2.5,
                            width:
                                ConstantWidget.getWidthPercentSize(context, 30),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            child: Center(
                                child: ConstantWidget.getTextWidget(
                                    "Done",
                                    Colors.white,
                                    TextAlign.start,
                                    FontWeight.w600,
                                    ConstantData.font18Px)),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

//                       Expanded(
//                         child: PageView.builder(
//                           controller: _controller,
//                           itemCount: widget.exerciseDetailList.length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return SetRepsItem(widget.exerciseDetailList[index],
//                                 widget.modelExerciseCategory, intList[index]);
//                           },
//                         ),
//                         flex: 1,
//                       ),
//                       new Container(
//                         padding: const EdgeInsets.all(20.0),
//                         child: new Center(
//                           child: new DotsIndicator(
//                             color: ConstantData.themeData.accentColor,
//                             controller: _controller,
//                             itemCount: widget.exerciseDetailList.length,
//                             onPageSelected: (int page) {
//                               _controller.animateToPage(
//                                 page,
//                                 duration: _kDuration,
//                                 curve: _kCurve,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(7),
//                             child: RaisedButton(
//                               padding: EdgeInsets.all(10),
//                               color: ConstantData.themeData.primaryColor,
//                               onPressed: () {
//                                 int currentPageValue = _controller.page!.toInt();
//                                 if (currentPageValue > 0) {
//                                   setState(() {
//                                     int pos = currentPageValue - 1;
//                                     _controller.animateToPage(
//                                       pos,
//                                       duration: _kDuration,
//                                       curve: _kCurve,
//                                     );
//                                     // _controller.jumpToPage(pos);
// // for animated jump. Requires a curve and a duration
//                                   });
//                                 }
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     CupertinoIcons.chevron_left,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   getSmallBoldText("Previous", Colors.white),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: SizedBox(),
//                             flex: 1,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(7),
//                             child: RaisedButton(
//                               padding: EdgeInsets.all(10),
//                               color: ConstantData.themeData.primaryColor,
//                               onPressed: () {
//                                 if (widget.exerciseDetailList.length > 0) {
//                                   addDatas(0);
//                                   //   _databaseHelper
//                                   //       .addAllMyPlanExercise(
//                                   //       widget.modelAddMyPlan.id,
//                                   //       widget.getWeek,
//                                   //       widget.getDay,
//                                   //       widget.exerciseDetailList,
//                                   //       intList)
//                                   //       .then((value) {
//                                   //     Navigator.of(context).pushReplacement(
//                                   //         MaterialPageRoute(builder: (context) {
//                                   //           return MyPlanWeekList(
//                                   //               widget.modelAddMyPlan, widget.getWeek);
//                                   //         },));
//                                   //   });
//                                 }
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.save,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   getSmallBoldText("Save", Colors.white),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       )
                    ],
                  )

                  // PageView.builder(
                  //   itemCount: widget.exerciseDetailList.length,
                  //
                  // ),
                  )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        onBackClick();
        return false;
      },
    );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }

  void addDatas(int i) {
    _databaseHelper
        .addAllMyPlanExercise1(widget.modelAddMyPlan.id!, widget.getWeek,
            widget.getDay, widget.exerciseDetailList[i].id!, intList[i])
        .then((value) {
      print("addval==$i==${widget.exerciseDetailList.length - 1}==$value");
      if (i < widget.exerciseDetailList.length - 1) {
        i++;
        addDatas(i);
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return MyPlanWeekList(widget.modelAddMyPlan, widget.getWeek);
          },
        ));
      }
    });
    //   _databaseHelper
    //       .addAllMyPlanExercise(
    //       widget.modelAddMyPlan.id,
    //       widget.getWeek,
    //       widget.getDay,
    //       widget.exerciseDetailList,
    //       intList)
    //       .then((value) {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) {
    //           return MyPlanWeekList(
    //               widget.modelAddMyPlan, widget.getWeek);
    //         },));
    //   });
  }
}

class SetRepsItem extends StatefulWidget {
 final ModelExerciseDetail modelExerciseDetail;
 final  ModelExerciseCategory _modelExerciseCategory;
 final List<int> repsList ;

  SetRepsItem(
      this.modelExerciseDetail, this._modelExerciseCategory, this.repsList);

  @override
  _SetRepsItem createState() => _SetRepsItem();
}

class _SetRepsItem extends State<SetRepsItem> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey)]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getMediumBoldText(S.of(context).muscle, Colors.black87),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      height: SizeConfig.safeBlockVertical! * 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(ConstantData.assetImagesPath +
                                widget._modelExerciseCategory.imageName!),
                            fit: BoxFit.cover),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(7),
                          // decoration: BoxDecoration(
                          //   color:
                          // ),
                          color: Colors.black38,
                          child: getSmallBoldText(
                              widget._modelExerciseCategory.categoryName!,
                              Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getMediumBoldText(S.of(context).exercise, Colors.black87),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      height: SizeConfig.safeBlockVertical! * 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(ConstantData.assetImagesPath +
                                widget._modelExerciseCategory.imageName!),
                            fit: BoxFit.cover),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            padding: EdgeInsets.all(7),
                            // decoration: BoxDecoration(
                            //   color:
                            // ),
                            color: Colors.black38,
                            child: Text(
                              widget.modelExerciseDetail.exerciseName!,
                              style: getTextStyles(Colors.white, 16),
                              maxLines: 1,
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: getMediumBoldText("Sets", Colors.grey),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: getMediumBoldText("Reps", Colors.grey),
                  )),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView(
              children: List.generate(widget.repsList.length, (index) {
                return Container(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  margin: EdgeInsets.all(5),
                  color: whiteGray,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: getSmallNormalText(
                            "Set ${index + 1}", Colors.black87),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                int i = widget.repsList[index];
                                if (i > 1) {
                                  i--;
                                  setState(() {
                                    widget.repsList[index] = i;
                                  });
                                }
                              },
                              icon: Icon(
                                CupertinoIcons.minus_circle,
                                color: primaryColor,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: getSmallNormalText(
                                      "${widget.repsList[index]}",
                                      Colors.black87),
                                )),
                            IconButton(
                              onPressed: () {
                                int i = widget.repsList[index];
                                i++;
                                setState(() {
                                  widget.repsList[index] = i;
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.add_circled,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
              }),
            ),
            flex: 1,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    // color: ConstantData.themeData.primaryColor,
                    onPressed: () {
                      setState(() {
                        widget.repsList.add(ConstantData.defaultRepsCount);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: getSmallBoldText("Add Set", Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: ConstantData.themeData.primaryColor,

                    child: InkWell(

                      onTap: () {
                        if (widget.repsList.length > 1) {
                          setState(() {
                            widget.repsList.removeLast();
                          });
                        }
                      },

                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.minus,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: getSmallBoldText("Remove Set", Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
