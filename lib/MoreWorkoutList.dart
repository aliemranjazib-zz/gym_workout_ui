import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'QuickWorkoutList.dart';
import 'model/WorkoutModel.dart';

class MoreWorkoutList extends StatefulWidget {
  final List<WorkoutModel> planCategory;
  final String title;

  MoreWorkoutList(this.planCategory, this.title);

  @override
  _MoreWorkoutList createState() => _MoreWorkoutList();
}

class _MoreWorkoutList extends State<MoreWorkoutList> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    print("widget-0---${widget.planCategory.length}");
    return WillPopScope(
      child: Scaffold(
        // appBar: getThemeAppBar(widget.planCategory.name!, () {
        //   onBackClick();
        // }),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBar(context, widget.title, () {
                onBackClick();
              }),
              Container(
                margin: EdgeInsets.only(
                  top: ConstantWidget.getMarginTop(context),
                  left: ConstantWidget.getWidthPercentSize(context, 3.5),
                  right: ConstantWidget.getWidthPercentSize(context, 3.5),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    (widget.planCategory.length > 0)
                        ? Expanded(child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.planCategory.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        WorkoutModel subCategory =
                        widget.planCategory[index];

                        double height =
                            SizeConfig.blockSizeVertical! * 22;
                        //
                        // double radius =
                        // ConstantWidget.getPercentSize(height, 5);


                        double imgHeight =
                        ConstantWidget.getPercentSize(
                            height, 8);
                        double radius =
                        ConstantWidget.getPercentSize(
                            height, 8);

                        return InkWell(
                          // child: Container(
                          //   padding: EdgeInsets.symmetric(vertical: 7),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Visibility(child: Container(
                          //         padding: EdgeInsets.symmetric(vertical: 10),
                          //         child: ConstantWidget.getTextWidget(
                          //             (subCategory.subTitle !=null)? subCategory.subTitle!.toUpperCase():"",
                          //             Colors.black,
                          //             TextAlign.start,
                          //             FontWeight.w600,
                          //             ConstantWidget.getScreenPercentSize(context, 2.2)),
                          //       ),visible: (subCategory.subTitle !=null),),
                          //       Stack(
                          //         children: [
                          //           ClipRRect(
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(radius)),
                          //             child: Image.asset(
                          //               ConstantData.assetImagesPath +
                          //                   subCategory.image!,
                          //               width: double.infinity,
                          //               height: height,
                          //               fit: BoxFit.cover,
                          //             ),
                          //           ),
                          //           Container(
                          //             height: height,
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(radius)),
                          //                 gradient: LinearGradient(
                          //                   colors: [
                          //                     Colors.black54,
                          //                     Colors.black45
                          //                   ],
                          //                   begin: Alignment.topCenter,
                          //                   end: Alignment.bottomCenter,
                          //                 )),
                          //           ),
                          //           Positioned.fill(
                          //             child: Align(
                          //               alignment: Alignment.bottomRight,
                          //               child: Wrap(children: [
                          //                 Container(
                          //                     width: double.infinity,
                          //                     padding: EdgeInsets.all(8),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white30,
                          //                     ),
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                       MainAxisAlignment.end,
                          //                       crossAxisAlignment:
                          //                       CrossAxisAlignment.end,
                          //                       children: [
                          //                         ConstantWidget
                          //                             .getTextWidget(
                          //                             subCategory.title!,
                          //                             defPrimaryColor,
                          //                             TextAlign.end,
                          //                             FontWeight.w600,
                          //                             ConstantWidget
                          //                                 .getPercentSize(
                          //                                 height,
                          //                                 11)),
                          //
                          //
                          //
                          //                       ],
                          //                     ))
                          //               ]),
                          //             ),
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),

                          child: Container(
                            color: Colors.white,
                            width:
                            SizeConfig.safeBlockHorizontal! * 65,

                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Visibility(
                                  visible: (subCategory.subTitle !=null),
                                  child: Padding(
                                    padding: EdgeInsets.only(

                                        top: (index > 0) ? 18 : 0),
                                    child:
                                    ConstantWidget.getTextWidget(
                                        (subCategory.subTitle !=null)? subCategory.subTitle!.toUpperCase():"",
                                        Colors.black,
                                        TextAlign.end,
                                        FontWeight.w600,
                                        ConstantWidget
                                            .getPercentSize(
                                            height, 8.3)),
                                  ),
                                ),


                                Container(
                                  height: height,
                                  // color: Colors.red,
                                  margin: EdgeInsets.symmetric(
                                      vertical: ConstantWidget
                                          .getScreenPercentSize(
                                          context, 1.2)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(
                                          Radius.circular(radius),
                                        ),
                                        child: Image.asset(
                                          ConstantData
                                              .assetImagesPath +
                                              subCategory.image!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    radius)),
                                            gradient:
                                            LinearGradient(
                                              colors: [
                                                Colors.black45,
                                                Colors.black54,

                                              ],
                                              begin: Alignment
                                                  .topCenter,
                                              end: Alignment
                                                  .bottomCenter,
                                            )),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment:
                                          Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                ConstantWidget
                                                    .getWidthPercentSize(
                                                    context,
                                                    3),
                                                vertical: ConstantWidget
                                                    .getWidthPercentSize(
                                                    context,
                                                    1)),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius
                                                        .circular(
                                                        radius)),
                                                color:
                                                defPrimaryColor),

                                            child: ConstantWidget
                                                .getTextWidget(
                                                "Free",
                                                Colors.white,
                                                TextAlign
                                                    .center,
                                                FontWeight.w700,
                                                ConstantWidget
                                                    .getPercentSize(
                                                    height,
                                                    6)),
                                            // margin: EdgeInsets.only(
                                            //     top: ConstantWidget.getPercentSize(
                                            //         height,
                                            //         10)),
                                            // child: Stack(
                                            //   children: [
                                            //     Positioned
                                            //         .fill(
                                            //       child:
                                            //       Align(
                                            //         alignment:
                                            //         Alignment.topRight,
                                            //         child:
                                            //         Container(
                                            //           padding:
                                            //           EdgeInsets.only(left: 5),
                                            //           width:
                                            //           double.infinity,
                                            //           height:
                                            //           ConstantWidget.getPercentSize(height, 10),
                                            //           // decoration: BoxDecoration(
                                            //           //     image: new DecorationImage(
                                            //           //       image: new AssetImage(ConstantData.assetImagesPath + "bg_shape.png"),
                                            //           //       fit: BoxFit.fill,
                                            //           //       colorFilter: new ColorFilter.mode(defPrimaryColor, BlendMode.srcIn),
                                            //           //     )),
                                            //           child:
                                            //           Center(
                                            //             child: ConstantWidget.getTextWidget("Free", Colors.white, TextAlign.center, FontWeight.w600, ConstantWidget.getPercentSize(ConstantWidget.getPercentSize(height, 10), 45)),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     )
                                            //   ],
                                            // )
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Align(
                                            alignment:
                                            Alignment.topLeft,
                                            child: Wrap(
                                              children: [
                                                Container(
                                                  width:
                                                  double.infinity,
                                                  padding:
                                                  EdgeInsets.all(8),
                                                  // decoration: BoxDecoration(
                                                  //     color: Colors.black54,
                                                  //     borderRadius: BorderRadius.only(
                                                  //         bottomLeft: Radius
                                                  //             .circular(
                                                  //                 radius),
                                                  //         bottomRight: Radius
                                                  //             .circular(
                                                  //                 radius))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 7,
                                                      ),

                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            ConstantData
                                                                .assetImagesPath +
                                                                "power.png",
                                                            height: imgHeight,
                                                            color: Colors
                                                                .white,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Image.asset(
                                                            ConstantData
                                                                .assetImagesPath +
                                                                "power.png",
                                                            height: imgHeight,
                                                            color: Colors
                                                                .white,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Image.asset(
                                                            ConstantData
                                                                .assetImagesPath +
                                                                "power.png",
                                                            height: imgHeight,
                                                            color: defPrimaryColor,
                                                          )
                                                          ,
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            child: ConstantWidget.getTextWidgetWithFont(
                                                                "Advanced"
                                                                    .toUpperCase(),
                                                                Colors.white,
                                                                TextAlign
                                                                    .start,
                                                                FontWeight
                                                                    .w600,
                                                                ConstantWidget
                                                                    .getPercentSize(
                                                                    height,
                                                                    5.5),meriendaOneFont),
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ConstantWidget.getTextWidgetWithFont(
                                                          subCategory.title!.toUpperCase(),
                                                          Colors.white,
                                                          TextAlign
                                                              .start,
                                                          FontWeight
                                                              .w100,
                                                          ConstantWidget
                                                              .getPercentSize(
                                                              height,
                                                              10),bebasneueFont),

                                                      // ConstantWidget.getCustomText(
                                                      //     _list[index]
                                                      //         .introduction!,
                                                      //     Colors.white,
                                                      //     2,
                                                      //     TextAlign.start,
                                                      //     FontWeight.w500,
                                                      //     ConstantWidget
                                                      //         .getPercentSize(
                                                      //             height,
                                                      //             6)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  QuickWorkoutList(
                                    subCategory.title!,subCategory
                                  ),
                            ));
                          },
                        );
                      },
                    ))
                        : getProgressDialog()

                    // Expanded(
                    //     child: FutureBuilder<List<ModelPlanSubCategory>>(
                    //   future: _databaseHelper.getPlanSubCategory(
                    //       widget.planCategory.id!, context),
                    //   builder: (context, snapshot) {
                    //     if (widget.planCategory.length > 0) {
                    //       List<ModelPlanSubCategory>? planCategory =
                    //           snapshot.data;
                    //       return ListView.builder(
                    //         itemCount: planCategory!.length,
                    //         scrollDirection: Axis.vertical,
                    //         itemBuilder: (context, index) {
                    //           ModelPlanSubCategory subCategory =
                    //               planCategory[index];
                    //
                    //           double height=
                    //           SizeConfig.blockSizeVertical! * 22;
                    //
                    //           double radius = ConstantWidget.getPercentSize(height, 5);
                    //           return InkWell(
                    //             child: Container(
                    //               padding: EdgeInsets.symmetric(vertical: 7),
                    //
                    //
                    //               child: Stack(
                    //                 children: [
                    //                   ClipRRect(
                    //                     borderRadius: BorderRadius.all(Radius.circular(radius)),
                    //                     child: Image.asset(
                    //                       ConstantData.assetImagesPath +
                    //                           subCategory.image!,
                    //                       width: double.infinity,
                    //                       height:
                    //                           height,
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                   ),
                    //
                    //                   Container(
                    //
                    //                     height:
                    //                     height,
                    //                     width: double.infinity,
                    //                     decoration: BoxDecoration(
                    //                         borderRadius: BorderRadius.all(Radius.circular(radius)),
                    //
                    //                         gradient: LinearGradient(
                    //                           colors: [Colors.black54,Colors.black45],
                    //                           begin: Alignment.topCenter,
                    //                           end: Alignment.bottomCenter,
                    //                         )
                    //                     ),
                    //                   ),
                    //                   Positioned.fill(
                    //                     child: Align(
                    //                       alignment: Alignment.bottomRight,
                    //                       child:
                    //                       Wrap(
                    //                         children: [Container(
                    //                         width: double.infinity,
                    //                         padding: EdgeInsets.all(8),
                    //                         decoration: BoxDecoration(
                    //                           color: Colors.white30,
                    //
                    //
                    //
                    //                         ),
                    //
                    //                         child: Column(
                    //                           mainAxisAlignment: MainAxisAlignment.end,
                    //                           crossAxisAlignment: CrossAxisAlignment.end,
                    //                           children: [
                    //                             ConstantWidget.getTextWidget(
                    //                                 subCategory.name!,
                    //                                 Colors.orange,
                    //                                 TextAlign.end,
                    //                                 FontWeight.w600,
                    //                                 ConstantWidget.getPercentSize(height,11)),
                    //
                    //                             SizedBox(height: 5,),
                    //                             ConstantWidget.getTextWidget(
                    //                                 "Intermediate",
                    //                                 Colors.white,
                    //                                 TextAlign.end,
                    //                                 FontWeight.w600,
                    //                                 ConstantWidget.getPercentSize(height,8)),
                    //
                    //                           ],
                    //                         ))]),
                    //
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //             onTap: () {
                    //               // Navigator.of(context).push(MaterialPageRoute(
                    //               //   builder: (context) =>
                    //               //       WorkoutPlanIntroduction(
                    //               //           subCategory, widget.planCategory),
                    //               // ));
                    //             },
                    //           );
                    //         },
                    //       );
                    //     } else {
                    //       return getProgressDialog();
                    //     }
                    //   },
                    // ))
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

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
