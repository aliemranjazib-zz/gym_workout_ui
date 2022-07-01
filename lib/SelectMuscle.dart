import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SelectExercise.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'generated/l10n.dart';
import 'model/ModelExerciseDetail.dart';

class SelectMuscle extends StatefulWidget {
  final ModelAddMyPlan modelAddMyPlan;
  final  int getWeek;
  final  int getDay;


  SelectMuscle(this.modelAddMyPlan, this.getWeek, this.getDay);

  @override
  _SelectMuscle createState() => _SelectMuscle();
}

class _SelectMuscle extends State<SelectMuscle> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<ModelExerciseCategory>? _list;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: getThemeAppBar(S.of(context).selectMuscle, () {
        //
        // }),
        body: SafeArea(
          child: Stack(
            children: [


              ConstantWidget.getAppBar(context, S.of(context).exercise, () {
                onBackClick();
              }),


              // Container(
              //     margin:
              //     EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
              //     child: FutureBuilder<List<ModelExerciseCategory>>(
              //       future: _databaseHelper.getAllSubCatList(context),
              //       builder: (context, snapshot) {
              //         _list = [];
              //         if (snapshot.hasData) {
              //           _list = snapshot.data;
              //         }
              //         return snapshot.hasData
              //             ? ListView.builder(
              //           scrollDirection: Axis.vertical,
              //           itemCount: _list!.length,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             Color color = "#F6F6F6".toColor();
              //             String image = "back.png";
              //             //
              //             // if (index % 4 == 0) {
              //             //   color = ConstantData.color1;
              //             //   image = "back_workout.png";
              //             // } else if (index % 4 == 1) {
              //             //   color = ConstantData.color2;
              //             //   image = "leg_workout.png";
              //             // } else if (index % 4 == 2) {
              //             //   color = ConstantData.color3;
              //             //   image = "butt_workout.png";
              //             // }
              //
              //             if (index % 3 == 0) {
              //               color = "#EEF8FE".toColor();
              //
              //             } else if (index % 3 == 1) {
              //               color = "#FFF1E2".toColor();
              //             }
              //
              //             if (index % 8 == 0) {
              //
              //               image = "biceps.png";
              //             } else if (index % 8 == 1) {
              //               image = "calf.png";
              //             } else if (index % 8 == 2) {
              //               image = "chest_workout.png";
              //             }else if (index % 8 == 3) {
              //               image = "for_arms.png";
              //             }else if (index % 8 == 4) {
              //               image = "leg.png";
              //             }else if (index % 8 == 5) {
              //               image = "leg.png";
              //             }else if (index % 8 == 6) {
              //               image = "shape_1213.png";
              //             }else if (index % 8 == 7) {
              //               image = "shoulder.png";
              //             }else if (index % 8 == 8) {
              //               image = "triceps.png";
              //             }
              //
              //
              //
              //
              //
              //             ModelExerciseCategory maincat = _list![index];
              //             return exerciseCatItem(
              //                 maincat, context, color, _list!, maincat.imageName!);
              //           },
              //         )
              //         // new GridView.count(
              //         //     crossAxisCount: 2,
              //         //     childAspectRatio: 1.3,
              //         //     padding: EdgeInsets.all(7),
              //         //     shrinkWrap: true,
              //         //     children: List.generate(_list!.length, (index) {
              //         //       ModelExerciseCategory maincat = _list![index];
              //         //       return exerciseCatItem(maincat, context);
              //         //     }))
              //
              //             : Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       },
              //     ))

              Container(
                  margin:
                  EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                  child: FutureBuilder<List<ModelExerciseCategory>>(
                    future: _databaseHelper.getAllSubCatList(context),
                    builder: (context, snapshot) {
                      _list = [];
                      if (snapshot.hasData) {
                        _list = snapshot.data;
                      }
                      return snapshot.hasData
                          ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _list!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Color color = "#F6F6F6".toColor();

                          if (index % 3 == 0) {
                            color = "#EEF8FE".toColor();

                          } else if (index % 3 == 1) {
                            color = "#FFF1E2".toColor();
                          }






                          ModelExerciseCategory maincat = _list![index];
                          return exerciseCatItem(
                              maincat, context, color, _list!, maincat.imageName!);
                        },
                      )
                      // new GridView.count(
                      //     crossAxisCount: 2,
                      //     childAspectRatio: 1.3,
                      //     padding: EdgeInsets.all(7),
                      //     shrinkWrap: true,
                      //     children: List.generate(_list!.length, (index) {
                      //       ModelExerciseCategory maincat = _list![index];
                      //       return exerciseCatItem(maincat, context);
                      //     }))

                          : Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))

              // Container(
              //   margin: EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: FutureBuilder<List<ModelExerciseCategory>>(
              //     future: _databaseHelper.getAllSubCatList(context),
              //     builder: (context, snapshot) {
              //       // return GridView.count(
              //       //   crossAxisCount: 3,
              //       //   padding: EdgeInsets.all(7),
              //       //   children: List.generate(snapshot.data!.length, (index) {
              //       //     ModelExerciseCategory exerciseCategory = snapshot.data![index];
              //       //     return InkWell(
              //       //       child: Container(
              //       //         margin: EdgeInsets.all(7),
              //       //         width: double.infinity,
              //       //         decoration: BoxDecoration(
              //       //             image: DecorationImage(
              //       //                 image: AssetImage(
              //       //                   ConstantData.assetImagesPath +
              //       //                       exerciseCategory.imageName!,
              //       //                 ),
              //       //                 fit: BoxFit.cover),
              //       //             borderRadius: BorderRadius.circular(7)),
              //       //         child: Align(
              //       //           alignment: Alignment.bottomLeft,
              //       //           child: Wrap(
              //       //             children: [
              //       //               Container(
              //       //                 padding: EdgeInsets.all(7),
              //       //                 decoration: BoxDecoration(
              //       //                     color: Colors.black26,
              //       //                     borderRadius: BorderRadius.only(
              //       //                         bottomRight: Radius.circular(7))),
              //       //                 child: getSmallBoldText(
              //       //                     exerciseCategory.categoryName!, Colors.white),
              //       //               ),
              //       //             ],
              //       //           ),
              //       //           // child: getSmallBoldText(
              //       //           //     exerciseCategory.categoryName, Colors.white),
              //       //         ),
              //       //       ),
              //       //       onTap: () {
              //       //         Navigator.of(context).push(MaterialPageRoute(
              //       //           builder: (context) {
              //       //             return SelectExercise(exerciseCategory,widget.modelAddMyPlan,widget.getWeek,widget.getDay);
              //       //           },
              //       //         ));
              //       //       },
              //       //     );
              //       //   }),
              //       // );
              //
              //
              //       return ListView.builder(
              //         scrollDirection: Axis.vertical,
              //         itemCount: snapshot.data!.length,
              //         shrinkWrap: true,
              //         itemBuilder: (context, index) {
              //           Color color = ConstantData.color4;
              //
              //           String image = "arm_workout.png";
              //
              //           if (index % 4 == 0) {
              //             color = ConstantData.color1;
              //             image = "back_workout.png";
              //           } else if (index % 4 == 1) {
              //             color = ConstantData.color2;
              //             image = "leg_workout.png";
              //           } else if (index % 4 == 2) {
              //             color = ConstantData.color3;
              //             image = "butt_workout.png";
              //           }
              //
              //           ModelExerciseCategory maincat = snapshot.data![index];
              //           return exerciseCatItem(maincat, context, color,snapshot.data,image);
              //         },
              //       );
              //     },
              //   ),
              // )
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


  Widget exerciseCatItem(ModelExerciseCategory category, BuildContext context,
      Color color, List<ModelExerciseCategory> list, String image) {
    double height = ConstantWidget.getScreenPercentSize(context, 17);
    double radius = ConstantWidget.getPercentSize(height, 10);

    return FutureBuilder<List<ModelExerciseDetail>>(
      future: _databaseHelper.getExerciseCount(category.id!, context),
      builder: (context, snapshot) {
        int exercise = 0;
        if (snapshot.hasData) {
          exercise = snapshot.data!.length;
        }


        print("widgetMain----${category.categoryName}----${category.imageName}");
        return Container(
            height: height,
            width: double.infinity,
            margin:
            EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 1)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SelectExercise(category,list,widget.modelAddMyPlan,widget.getWeek,widget.getDay);
                  },
                ));
              },
//             child: Stack(
//               children: [
//                 Container(
//
//
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: Card(
//                     color: Colors.white,
//                     // color: color,
//                     elevation:1.3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                       Radius.circular(
//                           ConstantWidget.getPercentSize(height, 10)),
//                     )),
//                     child: Container(
//                       child: Row(
//                         children: [
//
//                           SizedBox(
//                             width:ConstantWidget.getWidthPercentSize(
//                                 context, 5)
//                           )
// ,
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ConstantWidget.getTextWidget(
//                                     category.categoryName!,
//                                     Colors.black,
//                                     TextAlign.start,
//                                     FontWeight.bold,
//                                     ConstantWidget.getPercentSize(
//                                         remainHeight, 22)),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 ConstantWidget.getTextWidget(
//                                     "$exercise ${S.of(context).exercise}",
//                                     Colors.black,
//                                     TextAlign.start,
//                                     FontWeight.w400,
//                                     ConstantWidget.getPercentSize(
//                                         remainHeight, 18)),
//                               ],
//                             ),
//                           ),
//
//
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: ConstantWidget.getWidthPercentSize(
//                                   context, 5),
//                             ),
//                             child: Stack(
//                               children: [
//
//
//                                 Positioned.fill(
//                                   child: Align(
//                                     alignment: Alignment.bottomRight,
//                                     child:
//                                     Container(
//
//                                         width: ConstantWidget.getWidthPercentSize(
//                                             context, 28),
//                                         height: double.infinity,
//
//
//                                       decoration: BoxDecoration(
//
//                                         borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(radius),
//                                             bottomRight: Radius.circular(radius),topLeft: Radius.circular(radius*2.4),
//
//                                             bottomLeft: Radius.circular(radius*2.4)),
//
//
//                                         gradient: LinearGradient(
//                                             colors: ["#E49D98".toColor(),"#E49D98".toColor()]
//                                         )
//
//
//
//                                       ),
//
//
//
//
//                                       // child: Image.asset(
//                                       //   ConstantData.assetImagesPath + "shape_13.png",
//                                       //   fit: BoxFit.fill,
//                                       //   width: ConstantWidget.getWidthPercentSize(
//                                       //       context, 30),
//                                       //   height: double.infinity,
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//                                 // Positioned.fill(
//                                 //   child:
//
//
//                                 Padding(
//                                   padding:  EdgeInsets.symmetric(vertical: ConstantWidget.getScreenPercentSize(
//                                       context, 1)),
//                                   child: Container(
//                                     width: ConstantWidget.getWidthPercentSize(
//                                         context, 50),
//
//                                     // height: ConstantWidget.getWidthPercentSize(
//                                     //     context, ),
//                                     child:Align(
//                                       alignment: Alignment.centerRight,
//                                       // child: ClipRRect(
//                                       // borderRadius: BorderRadius.only(
//                                       //     topLeft: Radius.circular(radius),
//                                       //     bottomLeft: Radius.circular(radius)),
//                                       child: Image.asset(
//                                         // ConstantData.assetImagesPath + "shape_1213.png",
//                                         ConstantData.assetImagesPath + "shape_1212.png",
//
//                                         fit: BoxFit.fitWidth,
//
//                                         // height: ConstantWidget.getPercentSize(
//                                         //     height, 60),
//                                       ),
//                                       // ),
//                                     ),
//                                   ),
//                                 )
//                                 // ),
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
              child: Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.only(
                    //     top: ConstantWidget.getPercentSize(height, 20)),
                    height: double.infinity,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(radius),
                          )),
                      child: Stack(
                        children: [
                          // Container(
                          //   margin: EdgeInsets.only(left: ConstantWidget.getWidthPercentSize(context, 20)),
                          //   decoration: BoxDecoration(
                          //       color: "#DDEDFA".toColor(),
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(
                          //             ConstantWidget.getPercentSize(height, 10)),
                          //       )),
                          // ),

                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              // bottomLeft:
                              Radius.circular(radius),
                              // topLeft: Radius.circular(radius),
                            ),
                            child: Container(
                              color: "#DDEDFA".toColor(),
                              width: double.infinity,
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: ConstantWidget.getWidthPercentSize(
                                      context, 35),
                                ),
                                // width:ConstantWidget.getWidthPercentSize(context, 60),

                                child: Image.asset(
                                  ConstantData.assetImagesPath + "shape_34.png",
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),

                          // Container(
                          //   width:ConstantWidget.getWidthPercentSize(context, 10),
                          //   decoration: BoxDecoration(
                          //       color: primaryColor,
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(
                          //             ConstantWidget.getPercentSize(height, 10)),
                          //       )),
                          // ),

                          Container(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidget.getTextWidgetWithFont(
                                    category.categoryName! + " Workout",
                                    Colors.white,
                                    TextAlign.start,
                                    FontWeight.w100,
                                    ConstantWidget.getPercentSize(height, 17),
                                    bebasneueFont),
                                SizedBox(
                                  height: 5,
                                ),
                                ConstantWidget.getTextWidget(
                                  "$exercise ${S.of(context).exercise}"
                                      .toUpperCase(),
                                  Colors.white,
                                  TextAlign.start,
                                  FontWeight.w100,
                                  ConstantWidget.getPercentSize(height, 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ConstantData.assetImagesPath + image,
                        fit: BoxFit.fitWidth,
                        width: ConstantWidget.getWidthPercentSize(context, 40),
                        height: double.infinity,
                      ),
                    ),
                  )
                ],
              ),
              // child: Stack(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(
              //           top: ConstantWidget.getPercentSize(height, 20)),
              //       height: double.infinity,
              //       width: double.infinity,
              //       child: Card(
              //         color: color,
              //         elevation: 1,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.all(
              //           Radius.circular(radius),
              //         )),
              //         child: Container(
              //           padding: EdgeInsets.only(
              //               left: 15,
              //               bottom:
              //                   ConstantWidget.getPercentSize(remainHeight, 15)),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               ConstantWidget.getTextWidget(
              //                   category.categoryName!,
              //                   Colors.black,
              //                   TextAlign.start,
              //                   FontWeight.bold,
              //                   ConstantWidget.getPercentSize(remainHeight, 12)),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               ConstantWidget.getTextWidget(
              //                   "$exercise ${S.of(context).exercise}",
              //                   Colors.black,
              //                   TextAlign.start,
              //                   FontWeight.w600,
              //                   ConstantWidget.getPercentSize(remainHeight, 8.5)),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(right: 15, bottom: 3),
              //       child: Align(
              //         alignment: Alignment.bottomRight,
              //         child: Image.asset(
              //           ConstantData.assetImagesPath + "${category.imageName}",
              //           fit: BoxFit.cover,
              //           width: ConstantWidget.getWidthPercentSize(context, 40),
              //           height: double.infinity,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ));
      },
    );
  }

  // Widget exerciseCatItem(ModelExerciseCategory category, BuildContext context,
  //     Color color,var list,String image) {
  //   // double height = ConstantWidget.getScreenPercentSize(context, 25);
  //   double height = ConstantWidget.getScreenPercentSize(context, 12);
  //
  //   double remainHeight = height - ConstantWidget.getPercentSize(height, 20);
  //
  //   return FutureBuilder<List<ModelExerciseDetail>>(
  //     future: _databaseHelper.getExerciseCount(category.id!, context),
  //     builder: (context, snapshot) {
  //       int exercise = 0;
  //       if (snapshot.hasData) {
  //         exercise = snapshot.data!.length;
  //       }
  //       return Container(
  //           height: height,
  //           width: double.infinity,
  //           margin: EdgeInsets.all(10),
  //           child: InkWell(
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                                   builder: (context) {
  //                                     return SelectExercise(exerciseCategory,widget.modelAddMyPlan,widget.getWeek,widget.getDay);
  //                                   },
  //                                 ));
  //             },
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   // margin: EdgeInsets.only(
  //                   //     top: ConstantWidget.getPercentSize(height, 20)),
  //                   height: double.infinity,
  //                   width: double.infinity,
  //                   child: Card(
  //                     // color: Colors.white,
  //                     color: color,
  //                     elevation: 1.3,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(ConstantWidget.getPercentSize(height, 10)),
  //                         )),
  //                     child: Container(
  //
  //
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.only(right: ConstantWidget.getWidthPercentSize(context,5),),
  //                             child: Align(
  //                               alignment: Alignment.bottomRight,
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius
  //                                     .only(
  //                                     topLeft: Radius
  //                                         .circular(
  //                                         radius),
  //                                     bottomLeft: Radius
  //                                         .circular(
  //                                         radius)),
  //                                 child: Image.asset(
  //                                   ConstantData.assetImagesPath + image,
  //                                   fit: BoxFit.cover,
  //                                   width: ConstantWidget.getWidthPercentSize(context, 35),
  //                                   height: double.infinity,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 ConstantWidget.getTextWidget(
  //                                     category.categoryName!,
  //                                     Colors.black,
  //                                     TextAlign.start,
  //                                     FontWeight.bold,
  //                                     ConstantWidget.getPercentSize(remainHeight, 22)),
  //                                 SizedBox(
  //                                   height: 5,
  //                                 ),
  //                                 ConstantWidget.getTextWidget(
  //                                     "$exercise ${S.of(context).exercise}",
  //                                     Colors.black,
  //                                     TextAlign.start,
  //                                     FontWeight.w400,
  //                                     ConstantWidget.getPercentSize(remainHeight, 18)),
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }


  void onBackClick() {
    Navigator.of(context).pop();
  }
}
