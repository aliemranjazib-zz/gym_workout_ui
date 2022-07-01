import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/CopyWeek.dart';
import 'package:healtho_app/MyPlanExerciseList.dart';
import 'package:healtho_app/MyWorkoutPlanIntroduction.dart';
import 'package:healtho_app/SelectMuscle.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelMyPlanExercise.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class MyPlanWeekList extends StatefulWidget {
  final ModelAddMyPlan modelAddMyPlan;
final   int getWeek;

  MyPlanWeekList(this.modelAddMyPlan, this.getWeek);

  @override
  _MyPlanWeekList createState() => _MyPlanWeekList();
}

class MyPlanWeekItem extends StatefulWidget {
  final ModelAddMyPlan modelAddMyPlan;
  final int position;
  final int getWeek;

  MyPlanWeekItem(this.modelAddMyPlan, this.position, this.getWeek);

  @override
  _MyPlanWeekItem createState() => _MyPlanWeekItem();
}

class _MyPlanWeekItem extends State<MyPlanWeekItem> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<List<ModelMyPlanExercise>>(
      future: _databaseHelper.getMyPlanExerciseByDay(
          widget.modelAddMyPlan.id!, widget.getWeek, widget.position + 1),
      builder: (context, snapshot) {
        String exercises = "0 ${S.of(context).exercise}";
        int exerciseCount = 0;
        if (snapshot.hasData) {
          exerciseCount = snapshot.data!.length;
          if (exerciseCount > 0 && snapshot.data![0].exerciseId == 0) {
            exercises = S.of(context).rest;
          } else {
            exercises = "$exerciseCount ${S.of(context).exercise}";
          }
        }

        double size = ConstantWidget.getScreenPercentSize(context, 4);
        double iconSize = ConstantWidget.getScreenPercentSize(context, 2.7);
        Color color= (widget.position ==0) ?Colors.white:ConstantData.defColor;
        Color color1= (widget.position ==0) ?Colors.white:Colors.grey;

        return InkWell(
          child: Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: (widget.position ==0)?primaryColor:Colors.white,
            //     boxShadow: [
            //       BoxShadow(color: Colors.grey.shade400, blurRadius: 1.0)
            //     ]
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
                  color: color
                )



                ,
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
                          "${S.of(context).day} ${widget.position + 1}",
                          color,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantData.font15Px),

                      SizedBox(
                        height: 2,
                      ),
                      ConstantWidget.getTextWidget(
                          exercises,
                          (widget.position ==0) ? Colors.white70:Colors.grey,
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
                    (widget.position > 2)? ConstantData.assetImagesPath + "sofa.png":ConstantData.assetImagesPath + "dumbbell.png",
                    height: iconSize,
                    width: iconSize,
                    color: color,
                  ),
                  onTap: () {


                  },
                ),


                SizedBox(width: 8,),
                InkWell(
                  child: Image.asset(
                     ConstantData.assetImagesPath + "copy.png",
                    height: iconSize,
                    width: iconSize,
                    color: color1,
                  ),
                  onTap: () {

                    if (exerciseCount > 0) {
                      List<ModelMyPlanExercise>? planExercises = snapshot.data;
                      String s = jsonEncode(
                          planExercises!.map((i) => i.toMap()).toList())
                          .toString();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return CopyWeek(widget.modelAddMyPlan, widget.getWeek,
                              widget.position + 1, s);
                        },
                      ));
                    } else {
                      showCustomToast(
                          S.of(context).noExerciseAvailableToCopy, context);
                    }
                  },
                ),
                SizedBox(width: 8,),
                InkWell(
                  child: Image.asset(
                    ConstantData.assetImagesPath + "plus.png",
                    height: iconSize,
                    width: iconSize,
                    color:color1,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SelectMuscle(widget.modelAddMyPlan,
                            widget.getWeek, widget.position + 1);
                      },
                    ));

                  },
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
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MyPlanExerciseList(
                    widget.modelAddMyPlan, widget.getWeek, widget.position + 1);
              },
            )).then((value) {
              setState(() {});
            });
          },
        );

        // else {
        //
        // }
      },
    );
  }
}

class _MyPlanWeekList extends State<MyPlanWeekList> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        // appBar: getThemeAppBar("${S.of(context).week} ${widget.getWeek}", () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBarWithColor(
                  context, "${S.of(context).week} ${widget.getWeek}", () {
                onBackClick();
              }),
              Container(
                margin:
                    EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                padding: EdgeInsets.all(7),
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return MyPlanWeekItem(
                        widget.modelAddMyPlan, index, widget.getWeek);
                  },
                  itemCount: 7,
                  scrollDirection: Axis.vertical,
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

  void onBackClick() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) {
    //     return MyWorkoutPlanIntroduction(widget.modelAddMyPlan);
    //   },
    // ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MyWorkoutPlanIntroduction(widget.modelAddMyPlan);
      },
    ));
    // Navigator.of(context).pop();
  }
}
