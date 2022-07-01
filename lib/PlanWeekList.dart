import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/PlanDaysListNew.dart';
import 'package:healtho_app/RestDayPage.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelPlanExerciseData.dart';
import 'package:healtho_app/model/ModelPlanSubCategory.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class PlanWeekList extends StatefulWidget {
  final ModelPlanSubCategory planSubCategory;
  final int week;

  PlanWeekList(this.planSubCategory,
      this.week); // PlanWeekList(this.planSubCategory,this.week);

  @override
  _PlanWeekList createState() => _PlanWeekList();
}

class _PlanWeekList extends State<PlanWeekList> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  var daysNameList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    daysNameList = [
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wed,
      S.of(context).thu,
      S.of(context).fri,
      S.of(context).sat,
      S.of(context).sun
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        // appBar: getThemeAppBar("${S.of(context).week} ${widget.week}", () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBarWithColor(
                  context, "${S.of(context).week} ${widget.week}", () {
                onBackClick();
              }),
              Container(
                margin:
                    EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return FutureBuilder<List<ModelPlanExerciseData>>(
                      future: _databaseHelper.getAllPlanExerciseData(
                          widget.planSubCategory.catId!,
                          widget.planSubCategory.id!,
                          (index + 1)),
                      builder: (context, snapshot) {
                        print("gteweekdata--${snapshot.data}");
                        if (snapshot.hasData) {
                          print("gteweekdata1--${snapshot.data}");
                          return getSubItem(index, snapshot.data!.length);
                        } else {
                          return getRestItem(index);
                        }
                      },
                    );
                  },
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
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:(i ==0) ?primaryColor:Colors.white,
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
                color: color,
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
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PlanDaysListNew(widget.week, (i + 1)),
              // PlanDaysListNew(widget.week, (i + 1), widget.planSubCategory),
        ));
      },
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

  getRestItem(int i) {
    double size = ConstantWidget.getScreenPercentSize(context, 4);
    double iconSize = ConstantWidget.getScreenPercentSize(context, 2.7);
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:Colors.white,

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
              color: ConstantData.defColor,
            ),
            SizedBox(
              width: ConstantWidget.getWidthPercentSize(context, 5),
            ),
            Container(
              height: ConstantWidget.getScreenPercentSize(context, 3),
              width: 2,
              color: primaryColor,
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
                      Colors.black,
                      TextAlign.start,
                      FontWeight.w600,
                      ConstantData.font15Px),

                  SizedBox(
                    height: 2,
                  ),
                  ConstantWidget.getTextWidget(
                      S.of(context).restDay,
                      Colors.grey,
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
                ConstantData.assetImagesPath + "sofa.png",
                height: iconSize,
                width: iconSize,
                color: ConstantData.defColor,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestDayPage((i + 1), widget.week),
            ));
      },
    );

    // return Container(
    //   margin: EdgeInsets.all(12),
    //   padding: EdgeInsets.all(7),
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //     color: whiteGray,
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 1,
    //         blurRadius: 5,
    //         offset: Offset(0, 3), // changes position of shadow
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       DecoratedBox(
    //           decoration: BoxDecoration(
    //               color: ConstantData.themeData.accentColor,
    //               borderRadius: BorderRadius.all(Radius.circular(12))),
    //           child: Padding(
    //             padding:
    //                 EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
    //             child: getMediumBoldText(daysNameList[i], Colors.black),
    //           )),
    //       Expanded(
    //         child: Container(
    //           margin: EdgeInsets.only(left: 12, right: 10, top: 7, bottom: 7),
    //           child: Column(
    //             children: [
    //               Container(
    //                 width: double.infinity,
    //                 child: getMediumBoldText("REST", Colors.blueGrey),
    //               ),
    //
    //               SizedBox(
    //                 height: 7,
    //               ),
    //               Container(
    //                 width: double.infinity,
    //                 child: getNormalText(
    //                     14, "For The Muscle Recovery", Colors.black),
    //               ),
    //               SizedBox(
    //                 height: 19,
    //               ),
    //               // getNormalText(12, "Total Exercise", Colors.black)
    //
    //               // Row(
    //               //   children: [
    //               //     Expanded(
    //               //       child: getSmallBoldText("Total Exercise", Colors.black),
    //               //       flex: 2,
    //               //     ),
    //               //     Expanded(
    //               //       child: getSmallNormalText("10", Colors.black54),
    //               //       flex: 1,
    //               //     )
    //               //   ],
    //               // ),
    //               // SizedBox(height: 7,),
    //               // Row(
    //               //   children: [
    //               //     Expanded(
    //               //       child:
    //               //       getNormalText(14,"Total Exercise", Colors.black),
    //               //       flex: 2,
    //               //     ),
    //               //     Expanded(
    //               //       child: getNormalText(14,"10", Colors.black54),
    //               //       flex: 1,
    //               //     )
    //               //   ],
    //               // ),
    //               // SizedBox(height: 7,),
    //               // Row(
    //               //   children: [
    //               //     Expanded(
    //               //       child:
    //               //           getNormalText(14,"Total Exercise", Colors.black),
    //               //       flex: 2,
    //               //     ),
    //               //     Expanded(
    //               //       child: getNormalText(14,"10", Colors.black54),
    //               //       flex: 1,
    //               //     )
    //               //   ],
    //               // )
    //             ],
    //           ),
    //         ),
    //         flex: 1,
    //       ),
    //       Icon(
    //         CupertinoIcons.right_chevron,
    //         color: Colors.grey,
    //       )
    //     ],
    //   ),
    // );
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
