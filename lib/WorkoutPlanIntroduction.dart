
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/IntroducationPage.dart';
import 'package:healtho_app/PLanWeekList.dart';
import 'package:healtho_app/PlanDescription.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/model/ModelPlanSubCategory.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class WorkoutPlanIntroduction extends StatefulWidget {
  final ModelPlanSubCategory planSubCategory;
  final ModelPlanCategory planCategory;

  WorkoutPlanIntroduction(this.planSubCategory, this.planCategory);

  @override
  _WorkoutPlanIntroduction createState() => _WorkoutPlanIntroduction();
}

class _WorkoutPlanIntroduction extends State<WorkoutPlanIntroduction> {
  double paddingSize = 7;
  int progress = 0;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    // _databaseHelper.getWorkingDays(1,1).then((value){
    //   print("val==$value");
    // });
    getProgressVal();
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // dom.Document document = htmlparser.parse(widget.planSubCategory.introduction,);

    return WillPopScope(
      child: Scaffold(
        // appBar: getThemeAppBar("", () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

               Stack(
                 children: [



                   Container(
                     height: SizeConfig.blockSizeVertical! * 30,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         image: DecorationImage(
                             image: AssetImage(ConstantData.assetImagesPath +
                                 widget.planSubCategory.image!),
                             fit: BoxFit.cover)),
                     // child: Align(
                     //   alignment: Alignment.bottomCenter,
                     //   child: Container(
                     //     padding: EdgeInsets.all(7),
                     //     width: SizeConfig.safeBlockHorizontal! * 90,
                     //     decoration: BoxDecoration(
                     //         color: ConstantData.themeData.accentColor,
                     //         borderRadius: BorderRadius.only(
                     //             topLeft: Radius.circular(35),
                     //             topRight: Radius.circular(35))),
                     //     child: Row(
                     //       mainAxisSize: MainAxisSize.max,
                     //       children: [
                     //         // Expanded(
                     //         //   child: Column(
                     //         //     mainAxisSize: MainAxisSize.min,
                     //         //     children: [
                     //         //       getSmallBoldText(
                     //         //           S.of(context).goal, Colors.black),
                     //         //       // getNormalText(16, S.of(context).goal, Colors.black),
                     //         //       SizedBox(
                     //         //         height: 5,
                     //         //       ),
                     //         //       getNormalText(
                     //         //           14, widget.planCategory.name!, Colors.black)
                     //         //     ],
                     //         //   ),
                     //         //   flex: 1,
                     //         // ),
                     //         Expanded(
                     //           child: Column(
                     //             mainAxisSize: MainAxisSize.min,
                     //             children: [
                     //               getSmallBoldText(
                     //                   S.of(context).duration, Colors.black),
                     //               SizedBox(
                     //                 height: 5,
                     //               ),
                     //               getNormalText(
                     //                   14,
                     //                   "${widget.planSubCategory.no_week} ${S.of(context).weeks}",
                     //                   Colors.black)
                     //               // 14, "${widget.planSubCategory.no_week} Weeks", Colors.black)
                     //             ],
                     //           ),
                     //           flex: 1,
                     //         ),
                     //         Expanded(
                     //           child: Column(
                     //             mainAxisSize: MainAxisSize.min,
                     //             children: [
                     //               getSmallBoldText(
                     //                   S.of(context).level, Colors.black),
                     //               SizedBox(
                     //                 height: 5,
                     //               ),
                     //               getNormalText(
                     //                   14,
                     //                   ConstantData.getExerciseTypeStr(
                     //                       widget.planSubCategory.type!, context),
                     //                   Colors.black)
                     //             ],
                     //           ),
                     //           flex: 1,
                     //         )
                     //       ],
                     //     ),
                     //     // ),
                     //   ),
                     // ),
                   ),
                   Align(
                     alignment: Alignment.topCenter,
                     child: ConstantWidget.getTransparentAppBar(context, "", (){
                       onBackClick();
                     }),
                   )
                 ],
               ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child:  Row(
                    children: [
                      getCell(S.of(context).goal, "Loss Weight"),
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
                  color: primaryColor,
                ),

                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getSmallBoldText(
                            widget.planSubCategory.name!, ConstantData.defColor),

                        SizedBox(
                          height: paddingSize + 10,
                        ),
                        // getSmallNormalText(
                        //     S.of(context).introduction, ConstantData.defColor),

                        ConstantWidget.getTextWidget(
                          S.of(context).introduction,
                          ConstantData.defColor,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantWidget.getScreenPercentSize(context, 1.8),
                        ),

                        SizedBox(
                          height: 7,
                        ),

                        ConstantWidget.getTextWidget(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          Colors.grey,
                          TextAlign.start,
                          FontWeight.w300,
                          ConstantData.font15Px,
                        ),

                        SizedBox(
                          height: 3,
                        ),

                        InkWell(
                          child: ConstantWidget.getTextWidget(
                            S.of(context).readMore,
                            primaryColor,
                            TextAlign.start,
                            FontWeight.w600,
                            ConstantWidget.getScreenPercentSize(context, 2),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => IntroducationPage(),));
                          },
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: paddingSize, right: paddingSize),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Expanded(
                        //         flex: 1,
                        //         child: getSmallBoldText(
                        //             S.of(context).introduction, Colors.black),
                        //       ),
                        //       Icon(
                        //         CupertinoIcons.right_chevron,
                        //         color: Colors.black,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: paddingSize,
                        ),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: paddingSize, right: paddingSize),
                            // child: Html(
                            //   data: widget.planSubCategory.introduction,
                            // document: document,
                            //
                            //
                            // defaultTextStyle:
                            //     getTextStyles(Colors.black87, 15),
                            // )
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlanDescription(
                                  widget.planSubCategory, widget.planCategory),
                            ));
                          },
                        ),
                        SizedBox(
                          height: paddingSize * 2,
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: paddingSize, right: paddingSize),
                              child: Text(
                                "$progress% ${S.of(context).complete}",
                                textAlign: TextAlign.right,
                                style: getTextStyles(Colors.black54, 12),
                              )),
                        ),
                        SizedBox(
                          height: paddingSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: paddingSize, right: paddingSize),
                          child: LinearProgressIndicator(
                            minHeight: 7,
                            value: progress / 100,
                            // value: 0.2,
                            backgroundColor: Colors.black12,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        SizedBox(
                          height: paddingSize*
                              2,
                        ),

                        ConstantWidget.getTextWidget(
                          S.of(context).weekPlanner,
                          ConstantData.defColor,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantWidget.getScreenPercentSize(context,2),
                        ),
                        SizedBox(
                          height: paddingSize*2,
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: widget.planSubCategory.noWeek,
                            itemBuilder: (context, index) {

                              double circle =
                              ConstantWidget.getScreenPercentSize(context, 4);
                              double fontSize =
                              ConstantWidget.getPercentSize(circle, 43);

                              return InkWell(
                                child: Column(
                                  children: [

                                    Container(
                                      padding: EdgeInsets.only(left: paddingSize),

                                      child: Row(
                                        children: [
                                          ConstantWidget.getTextWidget(
                                            S.of(context).week+" "+(index+1).toString(),
                                            ConstantData.defColor,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantData.font15Px,
                                          ),

                                          Container(height: ConstantWidget.getScreenPercentSize(context, 2),
                                          color: ConstantData.defColor,
                                          width: ConstantWidget.getWidthPercentSize(context, 0.2),
                                          margin: EdgeInsets.symmetric(horizontal: 5),),


                                          ConstantWidget.getTextWidget(
                                            "4 Days",
                                            primaryColor,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantData.font15Px,
                                          ),

                                        ],
                                      ),
                                    )
                                    ,

                                    Container(
                                      padding: EdgeInsets.only(left: paddingSize*2),
                                      margin: EdgeInsets.symmetric(vertical: ConstantData.font22Px),
                                      height: circle,
                                      child:  ListView.builder(
                                        itemCount: 4,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {


                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              (i> 0)?Container(width: ConstantWidget.getWidthPercentSize(context,4),
                                                height: 0.5,color: Colors.black,):Container(),
                                              Container(

                                                height: circle,
                                                width: circle,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:(i==0 && index==0)?Colors.green: ConstantData.cellColor),
                                                child: Center(
                                                  child: ConstantWidget.getTextWidget((i+1).toString(),
                                                      (i==0 && index==0)?Colors.white:  Colors.black, TextAlign.center, FontWeight.w400, fontSize),
                                                ),
                                              ),


                                            ],
                                          );
                                        },),
                                    )
,

                                    SizedBox(
                                      height: paddingSize,
                                    ),

                                    // Container(
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
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
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
                                    //                     .introduction!,
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
                                    // )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => PlanWeekList(
                                        widget.planSubCategory, (index + 1)),
                                  ))
                                      .then((value) {
                                    getProgressVal();
                                  });
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
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

  void getProgressVal() {
    _databaseHelper
        .getProgressPercentage(
            widget.planSubCategory.catId!, widget.planSubCategory.id!)
        .then((value) {
      setState(() {
        progress = value;
      });
    });
  }
}
