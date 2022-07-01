import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/MyPlanWeekList.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelMyPlanExercise.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class CopyDay extends StatefulWidget {
  final ModelAddMyPlan modelAddMyPlan;
  final  int getWeek;
  final  int setWeek;
    final  int getDay;
  final String getData;

  CopyDay(this.modelAddMyPlan, this.getWeek, this.setWeek, this.getDay,
      this.getData);

  @override
  _CopyDay createState() => _CopyDay();
}

class _CopyDay extends State<CopyDay> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<ModelMyPlanExercise> exerciseListData = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        // appBar: getThemeAppBar(widget.modelAddMyPlan.name!, () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBarWithColor(
                  context, widget.modelAddMyPlan.name!, () {
                onBackClick();
              }),
              Container(
                margin:
                EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // getSmallBoldText(
                    //     S.of(context).selectTheWeekInWhichYouWantToCopyThe,
                    //     Colors.grey),

                    ConstantWidget.getTextWidget(
                        S.of(context).selectTheWeekInWhichYouWantToCopyThe,
                        Colors.black87,
                        TextAlign.start,
                        FontWeight.w300,
                        ConstantWidget.getScreenPercentSize(context, 2)),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return FutureBuilder<List<ModelMyPlanExercise>>(
                              future: _databaseHelper.getMyPlanExerciseByDay(
                                  widget.modelAddMyPlan.id!,
                                  widget.setWeek,
                                  index + 1),
                              builder: (context, snapshot) {
                                int exerciseCount = 0;
                                if (snapshot.hasData) {
                                  exerciseListData = snapshot.data!;
                                  exerciseCount = snapshot.data!.length;

                                }
                                return InkWell(

                                  child: getSubItem(index,exerciseCount),
                                  // child: Container(
                                  //   margin: EdgeInsets.all(7),
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       color: Colors.white,
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //             color: Colors.grey, blurRadius: 2.0)
                                  //       ]),
                                  //   padding: EdgeInsets.only(
                                  //       left: 10, right: 10, top: 15, bottom: 15),
                                  //   width: double.infinity,
                                  //   height: 70,
                                  //   child: Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Icon(
                                  //         CupertinoIcons.calendar,
                                  //         color: ConstantData.themeData.primaryColor,
                                  //         size: 40,
                                  //       ),
                                  //       SizedBox(
                                  //         width: 7,
                                  //       ),
                                  //       Expanded(
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //           children: [
                                  //             getSmallBoldText(
                                  //                 "${S.of(context).day} ${index + 1}",
                                  //                 Colors.black),
                                  //             getSmallNormalText(
                                  //                 exercises, Colors.black)
                                  //           ],
                                  //         ),
                                  //         flex: 1,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  onTap: () {

                                    // showCustomToast(
                                    //     S.of(context).noExerciseAvailableToCopy,context);
                                    // if (widget.getData.isEmpty) {
                                    //   if (exerciseCount > 0) {
                                    //     addData(0);
                                    //   } else {
                                    //     showCustomToast(
                                    //         S.of(context).noExerciseAvailableToCopy,context);
                                    //   }
                                    // } else {
                                    //   if (exerciseCount > 0) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext contexts) {
                                            return AlertDialog(
                                              // title: Text("Simple Alert"),
                                              content: Text(S
                                                  .of(context)
                                                  .areYouSureYouWantToCopyOnTheSelected),
                                              actions: [
                                                TextButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    showCustomToast(
                                                                S.of(context).copied,context);
                                                    // _databaseHelper
                                                    //     .removeAllMyPlanExercise(
                                                    //     widget.modelAddMyPlan.id!,
                                                    //     widget.setWeek,
                                                    //     setDay)
                                                    //     .then((value) {
                                                    //   copyToData(setDay);
                                                    // });
                                                    Navigator.of(contexts).pop();
                                                    onBackClick();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("CANCEL"),
                                                  onPressed: () {
                                                    Navigator.of(contexts).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                    //   } else {
                                    //     copyToData(setDay);
                                    //   }
                                    // }
                                  },
                                );

                                // else {
                                //
                                // }
                              },
                            );
                          },
                          itemCount: 7,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
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

  getSubItem(int i, int totalExercise) {
    Color color= (i ==0) ?Colors.white:ConstantData.defColor;

    double size = ConstantWidget.getScreenPercentSize(context, 4);
    double iconSize = ConstantWidget.getScreenPercentSize(context, 2.7);
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ConstantWidget.getWidthPercentSize(context, 3),
          ),

          Image.asset(
            ConstantData.assetImagesPath + "calendar.png",
            height: size,
            width: size,
            color: color,
          ),
          SizedBox(
            width: ConstantWidget.getWidthPercentSize(context, 5),
          ),

          Container(
            height: ConstantWidget.getScreenPercentSize(context, 3),
            width: 2,
            color: color,
          ),

          SizedBox(
            width: ConstantWidget.getWidthPercentSize(context, 3),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidget.getTextWidget(
                    "${S.of(context).day} ${i + 1}",
                    color,
                    TextAlign.start,
                    FontWeight.w600,
                    ConstantData.font15Px),

                SizedBox(
                  height: 2,
                ),
                ConstantWidget.getTextWidget(
                    "10 " + S.of(context).exercise,
                    (i ==0) ? Colors.white70:Colors.grey,
                    TextAlign.start,
                    FontWeight.w600,
                    ConstantData.font12Px),

                // getSmallNormalText(exercises, Colors.black)
              ],
            ),
            flex: 1,
          ),

          InkWell(
            child: Image.asset(
              ConstantData.assetImagesPath + "dumbbell.png",
              height: iconSize,
              width: iconSize,
              color:  color,
            ),
            onTap: () {},
          ),

          // IconButton(
          //   onPressed: () {
          //     if (exerciseCount > 0) {
          //       List<ModelMyPlanExercise>? planExercises = snapshot.data;
          //       String s = jsonEncode(
          //               planExercises!.map((i) => i.toMap()).toList())
          //           .toString();
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) {
          //           return CopyWeek(widget.modelAddMyPlan, widget.getWeek,
          //               widget.position + 1, s);
          //         },
          //       ));
          //     } else {
          //       showCustomToast(
          //           S.of(context).noExerciseAvailableToCopy, context);
          //     }
          //   },
          //   icon: Icon(
          //     Icons.copy,
          //     color: ConstantData.themeData.primaryColor,
          //     size: 40,
          //   ),
          // ),
          // // Container(
          //   height: double.infinity,
          //   width: 2,
          //   color: ConstantData.themeData.primaryColor,
          // ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) {
          //         return SelectMuscle(widget.modelAddMyPlan,
          //             widget.getWeek, widget.position + 1);
          //       },
          //     ));
          //   },
          //   icon: Icon(
          //     CupertinoIcons.add,
          //     color: ConstantData.themeData.primaryColor,
          //     size: 40,
          //   ),
          // ),
        ],
      ),
    );
    // return InkWell(
    //   child: Container(
    //     margin: EdgeInsets.all(12),
    //     padding: EdgeInsets.all(7),
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       color: whiteGray,
    //       borderRadius: BorderRadius.all(Radius.circular(12)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.5),
    //           spreadRadius: 1,
    //           blurRadius: 5,
    //           offset: Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         DecoratedBox(
    //             decoration: BoxDecoration(
    //                 color: ConstantData.themeData.accentColor,
    //                 borderRadius: BorderRadius.all(Radius.circular(12))),
    //             child: Padding(
    //               padding:
    //               EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
    //               child: getMediumBoldText(daysNameList[i], Colors.black),
    //             )),
    //         Expanded(
    //           child: Container(
    //             margin: EdgeInsets.only(left: 12, right: 10, top: 7, bottom: 7),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: getSmallBoldText("Total Exercise", Colors.black),
    //                       flex: 2,
    //                     ),
    //                     Expanded(
    //                       child: getSmallNormalText("10", Colors.black54),
    //                       flex: 1,
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 7,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child:
    //                       getNormalText(14, "Total Exercise", Colors.black),
    //                       flex: 2,
    //                     ),
    //                     Expanded(
    //                       child: getNormalText(14, "10", Colors.black54),
    //                       flex: 1,
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 7,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child:
    //                       getNormalText(14, "Total Exercise", Colors.black),
    //                       flex: 2,
    //                     ),
    //                     Expanded(
    //                       child: getNormalText(14, "10", Colors.black54),
    //                       flex: 1,
    //                     )
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //           flex: 1,
    //         ),
    //         Icon(
    //           CupertinoIcons.right_chevron,
    //           color: Colors.grey,
    //         )
    //       ],
    //     ),
    //   ),
    //   onTap: (){
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(
    //       builder: (context) =>
    //           PlanDaysListNew(widget.week,(i+1),widget.planSubCategory),
    //     ));
    //   },
    // );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }

  void addData(int i) {
    _databaseHelper.copyAllMyPlanExercise1(
            widget.modelAddMyPlan.id!,
            widget.getWeek,
            widget.getDay,
            exerciseListData[i].exerciseId!,
            exerciseListData[i].noSets!,
            exerciseListData[i].noReps!,
            exerciseListData[i].weight!,
            exerciseListData[i].rest!)
        .then((value) {
      if (i < exerciseListData.length - 1) {
        i++;
        addData(i);
      } else {
        showCustomToast("Day added successfully",context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return MyPlanWeekList(widget.modelAddMyPlan, widget.getWeek);
          },
        ));
      }
    });
    // _databaseHelper.addAllMyPlanExercise1(widget.modelAddMyPlan.id, widget.getWeek,widget.getDay,exerciseListData[i].id, intRepsList)
  }

  void copyToData(int day) {
    // List<ModelMyPlanExercise> jsonDecodeTags =new List<ModelMyPlanExercise>.from(widget.getData);
    var getData = jsonDecode(widget.getData) as List;
    // var tagObjsJson = jsonDecode(arrayObjsText)['tags'] as List;
    List<ModelMyPlanExercise> myPlansList =
        getData.map((tagJson) => ModelMyPlanExercise.fromMap(tagJson)).toList();
    copyDatasTo(0, day, myPlansList);
  }

  void copyDatasTo(int i, int days, List<ModelMyPlanExercise> exerciseList) {
    _databaseHelper.copyAllMyPlanExercise1(
            widget.modelAddMyPlan.id!,
            widget.setWeek,
            days,
            exerciseList[i].exerciseId!,
            exerciseList[i].noSets!,
            exerciseList[i].noReps!,
            exerciseList[i].weight!,
            exerciseList[i].rest!)
        .then((value) {
      if (i < exerciseList.length - 1) {
        i++;
        copyDatasTo(i, days, exerciseList);
      } else {
        showCustomToast("Day added successfully",context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return MyPlanWeekList(widget.modelAddMyPlan, widget.getWeek);
          },
        ));
      }
    });
  }
}
