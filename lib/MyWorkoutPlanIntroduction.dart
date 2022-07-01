import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/DetailPlan.dart';
import 'package:healtho_app/EditPlan.dart';
import 'package:healtho_app/HomeScreen.dart';
import 'package:healtho_app/MyPlanWeekList.dart';

import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'model/ModelMyPlanExercise.dart';

class MyWorkoutPlanIntroduction extends StatefulWidget {
  final ModelAddMyPlan planSubCategory;

  MyWorkoutPlanIntroduction(this.planSubCategory);

  @override
  _MyWorkoutPlanIntroduction createState() => _MyWorkoutPlanIntroduction();
}

class _MyWorkoutPlanIntroduction extends State<MyWorkoutPlanIntroduction> {
  double paddingSize = 7;
  int progress = 0;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  String name = "";

  // ModelPlanCategory planCategory;

  @override
  void initState() {
    super.initState();
    // _databaseHelper.getWorkingDays(1,1).then((value){
    //   print("val==$value");
    // });
    getProgressVal();
    _databaseHelper
        .getWorkoutPlanById(widget.planSubCategory.planCatId!, context)
        .then((value) {
      setState(() {
        name = value.name!;
        // planCategory=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        //   title: getHeaderTitle(""),
        //   backgroundColor: primaryColor,
        //   elevation: 0,
        //   leading: Builder(
        //     builder: (BuildContext context) {
        //       return IconButton(
        //         icon: Icon(Icons.keyboard_backspace_rounded),
        //         onPressed: () {
        //           onBackClick();
        //         },
        //         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //       );
        //     },
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: () {
        //
        //         Navigator.push(context,MaterialPageRoute(builder: (context) => EditPlan(),));
        //
        //       },
        //     )
        //   ],
        // ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [

              Stack(
                children: [



                  Container(
                    height: SizeConfig.blockSizeVertical! * 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ConstantData.assetImagesPath +
                                "complete_beginner_program.webp",),
                            fit: BoxFit.cover)),


                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstantWidget.getTransparentAppBar(context, "", (){
                      onBackClick();
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child:  Container(
                      height: ConstantWidget.getScreenPercentSize(context, 7.5),
                      margin: EdgeInsets.only(right: ConstantWidget.getWidthPercentSize(context, 5)),
                      child: InkWell(
                        child: Icon(Icons.edit,color: Colors.white,),
                        onTap: () {

                          Navigator.push(context,MaterialPageRoute(builder: (context) => EditPlan(),));

                        },
                      ),
                    ),
                  )
                ],
              ),
              // Container(
              //   height: SizeConfig.blockSizeVertical! * 25,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //     image: new ExactAssetImage(
              //       ConstantData.assetImagesPath +
              //           "complete_beginner_program.webp",
              //     ),
              //     fit: BoxFit.cover,
              //   )),
              //   child: Container(
              //     height: double.infinity,
              //     width: double.infinity,
              //     color: "#CC000000".toColor(),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: primaryColor,
                child: Row(
                  children: [
                    getCell(S.of(context).goal, "Build Muscles"),
                    Center(
                      child: Container(
                        height: 20,
                        width: 2.5,
                        color: Colors.white,
                      ),
                    ),
                    getCell(S.of(context).duration,
                        "${widget.planSubCategory.noWeek} ${S.of(context).weeks}"),
                    Center(
                      child: Container(
                        height: 20,
                        width: 2.5,
                        color: Colors.white,
                      ),
                    ),
                    getCell(S.of(context).level, "Intermediate"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: paddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ConstantWidget.getTextWidget(
                        widget.planSubCategory.name!,
                        ConstantData.defColor,
                        TextAlign.start,
                        FontWeight.w500,
                        ConstantWidget.getScreenPercentSize(context, 2)),
                    SizedBox(
                      height: paddingSize + 15,
                    ),
                    getSmallBoldText(S.of(context).introduction, Colors.black),
                    SizedBox(
                      height: 5,
                    ),
                    ConstantWidget.getTextWidget(
                        widget.planSubCategory.description!,
                        Colors.black54,
                        TextAlign.start,
                        FontWeight.w500,
                        ConstantWidget.getScreenPercentSize(context, 1.9)),
                    SizedBox(
                      height: 7,
                    ),
                    InkWell(
                      child: ConstantWidget.getTextWidget(
                          S.of(context).readMore,
                          primaryColor,
                          TextAlign.start,
                          FontWeight.w800,
                          ConstantWidget.getScreenPercentSize(context, 2)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPlan(),
                            ));
                      },
                    ),
                    SizedBox(
                      height: paddingSize,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "$progress% ${S.of(context).complete}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: ConstantData.fontsFamily,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: paddingSize,
                    ),
                    LinearProgressIndicator(
                      minHeight: 7,
                      value: progress / 100,
                      // value: 0.2,
                      backgroundColor: Colors.black12,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(
                      height: paddingSize,
                    ),
                    ConstantWidget.getTextWidget(
                        S.of(context).weekPlanner,
                        primaryColor,
                        TextAlign.start,
                        FontWeight.w800,
                        ConstantWidget.getScreenPercentSize(context, 2)),
                    Container(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.planSubCategory.noWeek,
                        itemBuilder: (context, index) {
                          // List<String> dayList=[];
                          //   getDayList(index).then((value) {
                          //   dayList = value;
                          //
                          // });




                          double circle =
                              ConstantWidget.getScreenPercentSize(context, 4);
                          double fontSize =
                              ConstantWidget.getPercentSize(circle, 43);

                          return FutureBuilder<List<int>>(
                            future: _databaseHelper.getAllExercise(widget.planSubCategory.id!,(index+1)),
                            builder: (context, snapshot) {
                              List<int> dayList=[];
                              if(snapshot.hasData){

                                if(snapshot.data!=null){
                                  dayList = snapshot.data!;
                                }
                              }





                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.all(
                                    ConstantWidget.getScreenPercentSize(
                                        context, 2)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ConstantWidget.getTextWidget(
                                            S.of(context).week +
                                                " " +
                                                (index + 1).toString(),
                                            Colors.black,
                                            TextAlign.start,
                                            FontWeight.w300,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.8)),
                                        Container(
                                          width: 0.8,
                                          height: 15,
                                          color: ConstantData.defColor,
                                          margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                        ),
                                        ConstantWidget.getTextWidget(
                                            dayList.length.toString()+" " + S.of(context).days,
                                            primaryColor,
                                            TextAlign.start,
                                            FontWeight.w300,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.8)),
                                      ],
                                    ),

                                    SizedBox(height: 15),






                                    (dayList.length > 0)
                                        ? Container(
                                      height: circle,
                                      child:  ListView.builder(
                                        itemCount: dayList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {


                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              (index> 0)?Container(width: ConstantWidget.getWidthPercentSize(context,4),
                                              height: 0.5,color: Colors.black,):Container(),
                                              Container(
                                                height: circle,
                                                width: circle,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ConstantData.cellColor),
                                                child: Center(
                                                  child: ConstantWidget.getTextWidget(dayList[index].toString(),
                                                      Colors.black, TextAlign.center, FontWeight.w600, fontSize),
                                                ),
                                              ),


                                            ],
                                          );
                                      },),
                                    )
                                        :
                                    Container(
                                      height: circle,
                                      width: circle,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ConstantData.cellColor),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: fontSize,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //     color: whiteGray,
                              //     // border: Border.all(color: Colors.grey),
                              //     borderRadius:
                              //     BorderRadius.all(Radius.circular(12)),
                              //   ),
                              //   margin: EdgeInsets.all(10),
                              //   padding: EdgeInsets.only(
                              //       left: 10, right: 10, top: 15, bottom: 15),
                              //   width: double.infinity,
                              //   // height: SizeConfig.blockSizeVertical * 10,
                              //   child: Row(
                              //     crossAxisAlignment:
                              //     CrossAxisAlignment.start,
                              //     mainAxisSize: MainAxisSize.max,
                              //     children: [
                              //       getMediumBoldText(
                              //           "0${index + 1}", Colors.grey),
                              //       Expanded(
                              //         child: Column(
                              //           crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //           children: [
                              //             Padding(
                              //               padding: EdgeInsets.only(left: 7),
                              //               child: getMediumBoldText(
                              //                   S.of(context).week,
                              //                   Colors.black87),
                              //             ),
                              //             SizedBox(
                              //               height: 7,
                              //             ),
                              //             Padding(
                              //               padding: EdgeInsets.only(left: 7),
                              //               child: Text(
                              //                 widget.planSubCategory
                              //                     .description!,
                              //                 style: getTextStyles(
                              //                     Colors.black38, 12),
                              //                 maxLines: 1,
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //         // child: Wrap(
                              //         //   children: [
                              //         //     getMediumBoldText("Week", Colors.black87),
                              //         //     Text(
                              //         //       widget.planSubCategory.introduction,
                              //         //       style: getTextStyles(Colors.black38, 12),
                              //         //       maxLines: 1,
                              //         //     )
                              //         //   ],
                              //         //   direction: Axis.vertical,
                              //         // ),
                              //         flex: 1,
                              //       ),
                              //       Column(
                              //         mainAxisSize: MainAxisSize.max,
                              //         crossAxisAlignment:
                              //         CrossAxisAlignment.center,
                              //         children: [
                              //           Icon(
                              //             CupertinoIcons.right_chevron,
                              //             color: Colors.grey,
                              //           )
                              //         ],
                              //       )
                              //     ],
                              //   ),
                              // ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => MyPlanWeekList(
                                      widget.planSubCategory, (index + 1)),
                                ))
                                    .then((value) {
                                  getProgressVal();
                                });
                              },
                            );
                          },);
                        },
                      ),
                    )
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



Future<List<String>>  getDayList(int index) async {
    List<String> dayList = [];




    for(int n=0;n<7;n++){


       _databaseHelper.getMyPlanExerciseByDay(
          widget.planSubCategory.id!, (index + 1), n + 1).then((value) {

        List<ModelMyPlanExercise> list =value;

        int exerciseCount = 0;

        exerciseCount = list.length;

        if (exerciseCount > 0) {
          dayList.add((n + 1).toString());
        }

      });


    }

    print("dayList12----${dayList.length}");
    return dayList;
  }

  getCell(String s, String s1) {
    return Expanded(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidget.getTextWidget(
                    s,
                    Colors.white,
                    TextAlign.start,
                    FontWeight.w500,
                    ConstantWidget.getScreenPercentSize(context, 1.3)),
                ConstantWidget.getTextWidget(
                    s1,
                    Colors.white,
                    TextAlign.start,
                    FontWeight.w500,
                    ConstantWidget.getScreenPercentSize(context, 1.8))
              ],
            ),
          ),
        ));
  }

  void onBackClick() {
    // Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return HomeScreen(1);
      },
    ));
  }

  void getProgressVal() {
    _databaseHelper
        .getMyWorkoutProgressPercentage(widget.planSubCategory.id!)
        .then((value) {
      setState(() {
        progress = value;
      });
    });
  }
}
