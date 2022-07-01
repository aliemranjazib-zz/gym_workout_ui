import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtho_app/ConstantColors.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/model/ModelPlanExerciseData.dart';
import 'package:healtho_app/model/ModelPlanExerciseTime.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'ExerciseDetailScreen.dart';

class PlanDaysListNew extends StatefulWidget {
  final int week, day;
  // final ModelPlanSubCategory planSubCat;

  PlanDaysListNew(this.week, this.day, );
  // PlanDaysListNew(this.week, this.day, this.planSubCat);

  @override
  _PlanDaysListNew createState() => _PlanDaysListNew();
}

class ListDataWidget extends StatefulWidget {
  final List<ModelPlanExerciseData> data;
  final List<ModelExerciseDetail> listDetail;
  final weeks;

  ListDataWidget(this.data, this.listDetail, this.weeks);

  @override
  _ListDataWidget createState() => _ListDataWidget();
}

class ListItemDataWidget extends StatefulWidget {
  final ModelPlanExerciseData data;
  final ModelExerciseDetail exerciseDetail;
  final weeks;
  final modelPlanExerciseTime;

  ListItemDataWidget(
      this.data, this.exerciseDetail, this.weeks, this.modelPlanExerciseTime);

  @override
  _ListItemDataWidget createState() => _ListItemDataWidget();
}

class _ListItemDataWidget extends State<ListItemDataWidget> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  bool isDone = false;
  bool fromUpdate = false;

  @override
  void initState() {
    super.initState();
    print("inititem=true");
    // setCompleteData();
  }

  @override
  void didChangeDependencies() {
    // setCompleteData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // if (fromUpdate) {
    //   fromUpdate = false;
    setCompleteData();
    // }
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
    //   child: Column(
    //     children: [
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(8.0),
    //             child: Image.asset(
    //               ConstantData.assetImagesPath + "abs_1.png",
    //               // ConstantData.assetImagesPath +exerciseDetail.exerciseImage,
    //               width: SizeConfig.safeBlockHorizontal! * 20,
    //               height: SizeConfig.safeBlockHorizontal! * 20,
    //               fit: BoxFit.fill,
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               margin:
    //                   EdgeInsets.only(left: 12, right: 10, top: 7, bottom: 7),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     widget.exerciseDetail.exerciseName!,
    //                     style: getTextStyles(Colors.black54, 16),
    //                     maxLines: 1,
    //                   ),
    //                   SizedBox(
    //                     height: 7,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: getNormalText(14, "Sets", Colors.black),
    //                         flex: 1,
    //                       ),
    //                       Expanded(
    //                         child: getNormalText(
    //                             14,
    //                             "${widget.ModelPlanExerciseTime.set}",
    //                             Colors.black54),
    //                         flex: 2,
    //                       )
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 7,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: getNormalText(14, "Reps", Colors.black),
    //                         flex: 1,
    //                       ),
    //                       Expanded(
    //                         child: getNormalText(
    //                             14,
    //                             "${widget.ModelPlanExerciseTime.reps_count}"
    //                                 .replaceAll("[", "")
    //                                 .replaceAll("]", "")
    //                                 .replaceAll(",", " - ")
    //                                 .trim(),
    //                             Colors.black54),
    //                         flex: 2,
    //                       )
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: 7,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: getNormalText(14, "Rest", Colors.black),
    //                         flex: 1,
    //                       ),
    //                       Expanded(
    //                         child: getNormalText(
    //                             14,
    //                             "${widget.ModelPlanExerciseTime.rest_time} ${S.of(context).sec}",
    //                             Colors.black54),
    //                         flex: 2,
    //                       )
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             flex: 1,
    //           ),
    //           Icon(
    //             CupertinoIcons.right_chevron,
    //             color: Colors.grey,
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       new Divider(
    //         height: 1,
    //         color: Colors.grey,
    //       ),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       new InkWell(
    //         child: Center(
    //           child: Wrap(
    //             crossAxisAlignment: WrapCrossAlignment.center,
    //             direction: Axis.horizontal,
    //             children: [
    //               Icon(
    //                 CupertinoIcons.check_mark_circled_solid,
    //                 color: (isDone) ? Colors.green : Colors.grey,
    //               ),
    //               SizedBox(
    //                 width: 5,
    //               ),
    //               getMediumBoldText("Mark as completed",
    //                   (isDone) ? Colors.green : Colors.grey)
    //             ],
    //           ),
    //         ),
    //         onTap: () {
    //           _databaseHelper
    //               .addCompleteData(widget.data.id!, widget.data.cat_id!,
    //                   widget.data.sub_cat_id!, widget.weeks, widget.data.day!)
    //               .then((value) {
    //
    //             setState(() {
    //               fromUpdate = true;
    //             });
    //           });
    //         },
    //       ),
    //     ],
    //   ),
    // );

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => ExerciseDetailScreen(),
            builder: (context) => ExerciseDetailScreen(
              exerciseDetail: widget.exerciseDetail,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        child: Row(
          children: [

            Container(
              width: SizeConfig.safeBlockHorizontal! * 30,
              height: SizeConfig.safeBlockVertical! * 16,
              child:  Image.asset(

                ConstantData.assetImagesPath + "abs_1.png",
                fit: BoxFit.scaleDown
                ,

              ),
            ),

            SizedBox(
              width: ConstantWidget.getWidthPercentSize(context, 5),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidget.getTextWidget(
                    widget.exerciseDetail.exerciseName!,
                    Colors.black,
                    TextAlign.start,
                    FontWeight.w700,
                    ConstantData.font15Px),
                SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        getCell("Sets", "1"),
                        getCell("Reps", "10"),
                        getCell("Weight", "10"),
                        getCell("Rest", "30 Sec"),
                      ],
                    ),


                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,

                    child: InkWell(

                      onTap: (){

                              _databaseHelper
                                  .addCompleteData(
                                      widget.data.id!,
                                      widget.data.catId!,
                                      widget.data.subCatId!,
                                      widget.weeks,
                                      widget.data.day!)
                                  .then((value) {
                                setState(() {
                                  isDone = true;
                                });
                              });

                      },

                      child: Image.asset(isDone?ConstantData.assetImagesPath+"checked.png":
                      ConstantData.assetImagesPath+"uncheck.png",
                          color:isDone?primaryColor:Colors.grey,height: ConstantData.font22Px,),
                    ),

                  ))
                    // Positioned.fill(
                    //     child: Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Checkbox(
                    //     value: isDone,
                    //     onChanged: (values) {
                    //       _databaseHelper
                    //           .addCompleteData(
                    //               widget.data.id!,
                    //               widget.data.cat_id!,
                    //               widget.data.sub_cat_id!,
                    //               widget.weeks,
                    //               widget.data.day!)
                    //           .then((value) {
                    //         setState(() {
                    //           isDone = true;
                    //         });
                    //       });
                    //
                    //
                    //     },
                    //   ),
                    // ))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        showEditDialog(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: ConstantWidget.getTextWidget(
                              S.of(context).editWeight,
                              Colors.white,
                              TextAlign.center,
                              FontWeight.w500,
                              ConstantData.font12Px),
                        ),
                      ),
                    )),
                    Expanded(child: Container()),
                    Expanded(child: Container()),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingController1 = new TextEditingController();
  TextEditingController textEditingController2 = new TextEditingController();
  int duration = 10;
  int setSize = 1;


  void showEditDialog(BuildContext context) {
    double apBarHeight = ConstantWidget.getScreenPercentSize(context, 10);
    double circle = ConstantWidget.getPercentSize(apBarHeight, 30);
    double radius = ConstantWidget.getScreenPercentSize(context, 1.2);
    double imgHeight = ConstantWidget.getScreenPercentSize(context, 10);
    double defWidth = ConstantWidget.getWidthPercentSize(context, 12);
    double height = ConstantWidget.getScreenPercentSize(context, 2);

    textEditingController.text = "10";
    textEditingController1.text = "10";
    textEditingController2.text = "10";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            child: Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              backgroundColor: Colors.transparent,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(radius))),
                        child: Stack(
                          children: [
                            Container(
                              height: apBarHeight,
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                            (ConstantWidget.getPercentSize(
                                                apBarHeight, 90)))
                                        // ,topRight: Radius.circular(radius),topLeft: Radius.circular(radius),
                                        // bottomLeft: Radius.circular(radius)
                                        )),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: ConstantWidget.getTextWidget(
                                            S.of(context).setsAndReps,
                                            Colors.white,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantWidget.getPercentSize(
                                                apBarHeight, 22)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        child: Container(
                                          height: circle,
                                          width: circle,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                          margin:
                                              EdgeInsets.only(right: 8, top: 5),
                                          child: Center(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size:
                                                  ConstantWidget.getPercentSize(
                                                      circle, 80),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: apBarHeight),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstantWidget.getTextWidget(
                                      "Biceps",
                                      Colors.black,
                                      TextAlign.start,
                                      FontWeight.w600,
                                      ConstantData.font18Px),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 7),
                                          height: imgHeight,
                                          width: imgHeight,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                ConstantData.assetImagesPath +
                                                    "abs_1.png",
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                              Container(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                              Center(
                                                child: Icon(
                                                  Icons.check_box_outlined,
                                                  color: Colors.black,
                                                  size: ConstantWidget
                                                      .getPercentSize(
                                                          imgHeight, 30),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        ConstantWidget.getTextWidget(
                                            "Barbell Curl",
                                            Colors.black,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantData.font12Px),
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
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                // height: ConstantWidget
                                                //     .getScreenPercentSize(context, 4),
                                                child: TextField(
                                                  controller:
                                                      textEditingController2,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(),
                                                    disabledBorder:
                                                        OutlineInputBorder(),
                                                    isDense: true,
                                                    // Added this
                                                    contentPadding:
                                                        EdgeInsets.all(
                                                            8), // Added this
                                                  ),
                                                )

                                                //
                                                //     TextField(
                                                //       textAlign: TextAlign.center,
                                                //       textAlignVertical: TextAlignVertical.center,
                                                //       keyboardType: TextInputType.number,
                                                //   decoration: InputDecoration(
                                                //       contentPadding:  EdgeInsets.symmetric(vertical: 2),
                                                //       border: OutlineInputBorder(
                                                //         borderRadius:
                                                //             BorderRadius.circular(2),
                                                //         borderSide: BorderSide(
                                                //             color: Colors.grey,width: 1),
                                                //       ),
                                                //       hintText: ''),
                                                // ),
                                                ),
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
                                        Padding(
                                          padding: EdgeInsets.only(left: 7),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: defWidth,
                                                child: ConstantWidget
                                                    .getTextWidget(
                                                        "Sets",
                                                        ConstantData.defColor,
                                                        TextAlign.start,
                                                        FontWeight.w600,
                                                        ConstantData.font15Px),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getTextWidget(
                                                          "Reps",
                                                          ConstantData.defColor,
                                                          TextAlign.start,
                                                          FontWeight.w600,
                                                          ConstantData
                                                              .font15Px),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getTextWidget(
                                                          "Weight(Kg)",
                                                          ConstantData.defColor,
                                                          TextAlign.start,
                                                          FontWeight.w600,
                                                          ConstantData
                                                              .font15Px),
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
                                            return Container(
                                              // height: 60,
                                              padding: EdgeInsets.all(7),
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                  color: ConstantData.cellColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),

                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: defWidth,
                                                    child: ConstantWidget
                                                        .getTextWidget(
                                                            "Sets " +
                                                                ((index + 1)
                                                                    .toString()),
                                                            ConstantData
                                                                .defColor,
                                                            TextAlign.start,
                                                            FontWeight.w600,
                                                            ConstantData
                                                                .font15Px),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      height: ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 3),
                                                      child: TextField(
                                                        style: TextStyle(
                                                            fontFamily:
                                                                ConstantData
                                                                    .fontsFamily,
                                                            fontSize:
                                                                ConstantData
                                                                    .font12Px),
                                                        controller:
                                                            textEditingController1,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[0-9]')),
                                                        ],
                                                        textAlign:
                                                            TextAlign.center,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          focusedBorder:
                                                              OutlineInputBorder(),
                                                          disabledBorder:
                                                              OutlineInputBorder(),
                                                          isDense: true,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            height: height,
                                                            width: height,
                                                            color: Colors
                                                                .grey.shade600,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: ConstantData
                                                                    .cellColor,
                                                                size: ConstantWidget
                                                                    .getPercentSize(
                                                                        height,
                                                                        70),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            // setState.setState(() {

                                                            setState(() {
                                                              if (duration >
                                                                  0) {
                                                                duration--;
                                                                textEditingController
                                                                        .text =
                                                                    duration
                                                                        .toString();
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        7),
                                                            height: ConstantWidget
                                                                .getScreenPercentSize(
                                                                    context,
                                                                3),
                                                            child: TextField(
                                                              controller:
                                                                  textEditingController,
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9]')),
                                                              ],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      ConstantData
                                                                          .fontsFamily,
                                                                  fontSize:
                                                                      ConstantData
                                                                          .font12Px),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              enabled: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
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
                                                              duration =
                                                                  duration + 1;
                                                              textEditingController
                                                                      .text =
                                                                  duration
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            height: height,
                                                            width: height,
                                                            color: Colors
                                                                .grey.shade600,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: ConstantData
                                                                    .cellColor,
                                                                size: ConstantWidget
                                                                    .getPercentSize(
                                                                        height,
                                                                        70),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),

                                        Center(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: height * 2.5,
                                              width: ConstantWidget
                                                  .getWidthPercentSize(
                                                      context, 30),
                                              decoration: BoxDecoration(
                                                  color:
                                                      primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7))),
                                              child: Center(
                                                  child: ConstantWidget
                                                      .getTextWidget(
                                                          S.of(context).update,
                                                          Colors.white,
                                                          TextAlign.start,
                                                          FontWeight.w600,
                                                          ConstantData
                                                              .font18Px)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            onWillPop: () => Future.value(false),
          );
        });
  }

  getCell(String s, String s1) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Container(
            width: ConstantWidget.getWidthPercentSize(context, 15),
            child: ConstantWidget.getTextWidget(s, Colors.black, TextAlign.start,
                FontWeight.w300, ConstantData.font15Px),
          ),
          ConstantWidget.getTextWidget(":  " + s1, Colors.black, TextAlign.start,
              FontWeight.w300, ConstantData.font15Px)
        ],
      ),
    );
  }

  void setCompleteData() {
    _databaseHelper
        .isPlanCompleted(
      widget.data.id!,
      widget.weeks,
    )
        .then((value) {


          if(mounted){
            setState(() {
              isDone = value;
              print("checkres2=$value");
            });
          }
    });
  }
}

class _ListDataWidget extends State<ListDataWidget> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {


        return FutureBuilder<ModelPlanExerciseTime>(
          future: _databaseHelper.getPlanExerciseTime(
              widget.weeks, widget.data[index].id!),
          builder: (context, snapshot) {
            print("daysdata2==${snapshot.data}");
            ModelExerciseDetail exerciseDetail = widget.listDetail[index];

            if (snapshot.hasData) {}
            print(
                "exerciseImage==${ConstantData.assetImagesPath}${exerciseDetail.exerciseImage}");
            return (snapshot.hasData)
                ? ListItemDataWidget(widget.data[index], exerciseDetail,
                    widget.weeks, snapshot.data)
                : getProgressDialog();
          },
        );
      },
    );
  }
}

class _PlanDaysListNew extends State<PlanDaysListNew> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double width = ConstantWidget.getWidthPercentSize(context, 25);

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: getThemeAppBarWithOption(
        //     "${S.of(context).week} ${widget.week}-${S.of(context).day} ${widget.day}",
        //     () {
        //   onBackClick();
        // }, <Widget>[
        //   // Padding(
        //   //     padding: EdgeInsets.only(right: 20.0),
        //   //     child: GestureDetector(
        //   //       onTap: () {
        //   //         _databaseHelper
        //   //             .resetPlanData(widget.planSubCat.cat_id!,
        //   //                 widget.planSubCat.id!, widget.week, widget.day)
        //   //             .then((value) {
        //   //           setState(() {
        //   //             print("resetPlanData=true");
        //   //           });
        //   //         });
        //   //       },
        //   //       child: Center(child: getSmallBoldText("Reset", Colors.white)),
        //   //     )),
        //
        // ]),
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBar(context, "", () {
                onBackClick();
              }),
              Container(
                margin: EdgeInsets.only(
                    top: ConstantWidget.getMarginTop(context) -
                        ConstantData.font15Px),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left:
                                ConstantWidget.getWidthPercentSize(context, 5)),
                        child: Row(
                          children: [
                            ConstantWidget.getTextWidget(
                                S.of(context).week +
                                    " " +
                                    widget.week.toString(),
                                ConstantData.defColor,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantData.font18Px),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              height: 20,
                              color: ConstantData.defColor,
                              width: 2,
                            ),
                            ConstantWidget.getTextWidget(
                                S.of(context).day + " " + widget.day.toString(),
                                ConstantData.defColor,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantData.font18Px),
                            new Spacer(),
                            InkWell(
                              onTap: () {

                                  Navigator.of(context).pop();
                              },
                              child: Container(
                                // width: 200,
                                width: width,
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                // height: 50,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: ConstantWidget.getTextWidget(
                                      S.of(context).update,
                                      Colors.white,
                                      TextAlign.center,
                                      FontWeight.w500,
                                      ConstantWidget.getPercentSize(width, 12)),
                                ),
                              ),
                            )
                          ],
                        )),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.only(
                          top: ConstantWidget.getScreenPercentSize(
                              context, 1.5)),
                      child: FutureBuilder<List<ModelPlanExerciseData>>(
                        future: _databaseHelper.getAllExerciseData(
                            // widget.planSubCat.cat_id!,
                            // widget.planSubCat.id!,
                            widget.day),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return getExerciseDetailData(snapshot.data!);
                          } else {
                            return getProgressDialog();
                          }

                        },
                      ),
                    ))
                  ],
                ),
              ),
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

  getGridLIst(
      List<ModelPlanExerciseData> data, List<ModelExerciseDetail> listDetail) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        bool isDone = false;
        _databaseHelper
            .isPlanCompleted(
          data[index].id!,
          widget.week,
        )
            .then((value) {
          isDone = value;
          // if (!value) {
          //   colorDone = Colors.green;
          // }
          print("checkres2=$value");
        });
        // ModelExerciseDetail exerciseDetail;
        // _databaseHelper
        //     .getExerciseDetailByid(data[index].exercise_id, context)
        //     .then((value) {
        //   setState(() {
        //     exerciseDetail = value;
        //   });
        // });
        // return FutureBuilder<List<ModelPlanExerciseTime>>(
        return FutureBuilder<ModelPlanExerciseTime>(
          future:
              _databaseHelper.getPlanExerciseTime(widget.week, data[index].id!),
          builder: (context, snapshot) {
            print("daysdata2==${snapshot.data}");
            ModelExerciseDetail exerciseDetail = listDetail[index];

            if (snapshot.hasData) {}
            print(
                "exerciseImage==${ConstantData.assetImagesPath}${exerciseDetail.exerciseImage}");
            // _databaseHelper
            //     .getExerciseDetailByid(data[index].exercise_id, context)
            //     .then((value) {
            //   setState(() {
            //     exerciseDetail = value;
            //   });
            // });
            return (snapshot.hasData)
                ? Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteGray,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                ConstantData.assetImagesPath + "abs_1.png",
                                // ConstantData.assetImagesPath +exerciseDetail.exerciseImage,
                                width: SizeConfig.safeBlockHorizontal! * 20,
                                height: SizeConfig.safeBlockHorizontal! * 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 12, right: 10, top: 7, bottom: 7),
                                child: Column(
                                  children: [
                                    Text(
                                      exerciseDetail.exerciseName!,
                                      style: getTextStyles(Colors.black54, 16),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: getNormalText(
                                              14, "Sets", Colors.black),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: getNormalText(
                                              14,
                                              "${snapshot.data!.set}",
                                              Colors.black54),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: getNormalText(
                                              14, "Reps", Colors.black),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: getNormalText(
                                              14,
                                              "${snapshot.data!.repsCount}"
                                                  .replaceAll("[", "")
                                                  .replaceAll("]", "")
                                                  .replaceAll(",", " - ")
                                                  .trim(),
                                              Colors.black54),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: getNormalText(
                                              14, "Rest", Colors.black),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: getNormalText(
                                              14,
                                              "${snapshot.data!.restTime} ${S.of(context).sec}",
                                              Colors.black54),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        new Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        new InkWell(
                          child: Center(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: (isDone) ? Colors.green : Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                getMediumBoldText("Mark as completed",
                                    (isDone) ? Colors.green : Colors.blue)
                              ],
                            ),
                          ),
                          onTap: () {
                            _databaseHelper
                                .addCompleteData(
                                    data[index].id!,
                                    data[index].catId!,
                                    data[index].subCatId!,
                                    widget.week,
                                    data[index].day!)
                                .then((value) {
                              setState(() {});
                            });
                          },
                        )
                      ],
                    ),
                  )
                : getProgressDialog();
          },
        );
      },
    );
  }

  Widget getExerciseDetailData(List<ModelPlanExerciseData> data) {
    return FutureBuilder<List<ModelExerciseDetail>>(
      future: _databaseHelper.getAllExerciseListData(data, context),
      builder: (context, snapshot) {
        print("exercisedetaillength==${snapshot.data}");
        return (snapshot.hasData)
            ? ListDataWidget(data, snapshot.data!, widget.week)
            : getProgressDialog();
        // return (snapshot.hasData)
        //     ? getGridLIst(data, snapshot.data)
        //     : getProgressDialog();
      },
    );
  }
}
