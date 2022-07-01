import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SetReps.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'SizeConfig.dart';
import 'generated/l10n.dart';

class SelectExercise extends StatefulWidget {
  final ModelExerciseCategory exerciseCategory;
  final ModelAddMyPlan modelAddMyPlan;
  final int getWeek;
  final int getDay;
  final List<ModelExerciseCategory> list;

  SelectExercise(this.exerciseCategory, this.list, this.modelAddMyPlan,
      this.getWeek, this.getDay);

  // SelectExercise(this.exerciseCategory);

  @override
  _SelectExercise createState() => _SelectExercise();
}

class SelectExerciseItem extends StatefulWidget {
  final ModelExerciseDetail exerciseDetail;
  final Function(ModelExerciseDetail) callback;

  SelectExerciseItem(this.exerciseDetail, this.callback);

  @override
  _SelectExerciseItem createState() => _SelectExerciseItem();
}

class _SelectExerciseItem extends State<SelectExerciseItem> {
  bool valueExercise = false;

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.safeBlockVertical! * 12;
    return Container(
        color: Colors.white,
        height: height,
        width: double.infinity,
        margin: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              // Hero(
              //   tag: category.exerciseImage!,
              Container(
                width: height,
                height: double.infinity,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    ConstantData.assetImagesPath + "abs_1.png",
                    // "assets/videos/${category.exercise_img}",
                    fit: BoxFit.scaleDown
                    ,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantWidget.getTextWidget(
                          widget.exerciseDetail.exerciseName!,
                          Colors.black,
                          TextAlign.start,
                          FontWeight.w600,
                          ConstantWidget.getPercentSize(height, 15)),
                      SizedBox(
                        height: 5,
                      ),
                      ConstantWidget.getTextWidget(
                          "Difficulty: Beginner",
                          Colors.grey,
                          TextAlign.start,
                          FontWeight.w400,
                          ConstantWidget.getPercentSize(height, 14)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Checkbox(
                      value: valueExercise,
                      onChanged: (value) {
                        setState(() {
                          print("change==$value");
                          valueExercise = value!;
                          widget.callback(widget.exerciseDetail);
                        });
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
    // return InkWell(
    //   child: Container(
    //     margin: EdgeInsets.all(7),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(7)),
    //         image: DecorationImage(
    //             image: AssetImage(
    //               ConstantData.assetImagesPath + "abs_1.png",
    //             ),
    //             fit: BoxFit.cover)),
    //     width: double.infinity,
    //     child: Stack(
    //       children: [
    //         Align(
    //             alignment: Alignment.bottomCenter,
    //             child: Wrap(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.all(7),
    //                   decoration: BoxDecoration(
    //                       color: Colors.black38,
    //                       borderRadius: BorderRadius.only(
    //                           bottomLeft: Radius.circular(7),
    //                           bottomRight: Radius.circular(7))),
    //                   width: double.infinity,
    //                   child: Center(
    //                       child: Text(
    //                     widget.exerciseDetail.exerciseName!,
    //                     style: getTextStyles(Colors.white, 15),
    //                     maxLines: 1,
    //                   )),
    //                 ),
    //               ],
    //             )
    //             // child: Container(
    //             //   decoration: BoxDecoration(
    //             //       borderRadius: BorderRadius.only(
    //             //           bottomLeft: Radius.circular(7),
    //             //           bottomRight: Radius.circular(7))),
    //             //   width: double.infinity,
    //             //   child: Center(
    //             //     child: getSmallBoldText(
    //             //         widget.exerciseDetail.exerciseName, Colors.white),
    //             //   ),
    //             // ),
    //             ),
    //         Align(
    //           alignment: Alignment.topRight,
    //           child: Checkbox(
    //             value: valueExercise,
    //             onChanged: (value) {
    //               setState(() {
    //                 print("change==$value");
    //                 valueExercise = value!;
    //                 widget.callback(widget.exerciseDetail);
    //               });
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    //   onTap: () {},
    // );
  }
}

class _SelectExercise extends State<SelectExercise>
    with TickerProviderStateMixin {
  List<ModelExerciseDetail> stringList = [];
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  ModelExerciseCategory? exerciseCategory;
  AnimationController? animationController;

  @override
  void initState() {
    setState(() {
      exerciseCategory = widget.exerciseCategory;
    });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  callback(ModelExerciseDetail id) {
    if (stringList.contains(id)) {
      stringList.remove(id);
    } else {
      stringList.add(id);
    }
    // setState(() {
    //   abc = newAbc;
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 6);
    return WillPopScope(
      onWillPop: () async {
        onBackClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: getThemeAppBar(widget.exerciseCategory.categoryName!, () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBar(context, S.of(context).exercise, () {
                onBackClick();
              }),
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: ConstantWidget.getMarginTop(context) - 8),
                  margin: EdgeInsets.all(7),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: height,
                            child: ListView.builder(
                              itemCount: widget.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                bool isSelected = (exerciseCategory!.id ==
                                    widget.list[index].id);
                                return InkWell(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ConstantWidget.getTextWidget(
                                              widget.list[index].categoryName!,
                                              (isSelected)
                                                  ? Colors.black
                                                  : Colors.black54,
                                              TextAlign.start,
                                              (isSelected)
                                                  ? FontWeight.w800
                                                  : FontWeight.w500,
                                              ConstantWidget.getPercentSize(
                                                  height, 35)),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            height: 5,
                                            width: ConstantWidget
                                                .getWidthPercentSize(
                                                    context, 5),
                                            color: (isSelected)
                                                ? primaryColor
                                                : Colors.transparent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      exerciseCategory = widget.list[index];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: FutureBuilder<List<ModelExerciseDetail>>(
                            future: _databaseHelper.getExerciseCount(
                                widget.exerciseCategory.id!, context),
                            builder: (context, snapshot) {
                              List<ModelExerciseDetail> exerciseDetail = [];
                              if (snapshot.hasData) {
                                exerciseDetail = snapshot.data!;
                              }
                              return (snapshot.hasData)
                                  ? getGridLIst(exerciseDetail)
                                  : getProgressDialog();
                              // return GridView.builder(
                              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //       crossAxisCount: 2, childAspectRatio: 1.2),
                              //   itemCount: snapshot.data!.length,
                              //   itemBuilder: (context, index) {
                              //     ModelExerciseDetail exerciseDetail =
                              //     snapshot.data![index];
                              //     return SelectExerciseItem(exerciseDetail, callback);
                              //   },
                              // );
                            },
                          ))
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,


                        child: InkWell(
                          // label: Text("Next"),



                          child: Container(

                            margin: EdgeInsets.all(10),

                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 7, bottom: 7),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(ConstantWidget.getScreenPercentSize(context, 20)),
                              ),
                            ),
                            child: Wrap(
                              children: [
                                getMediumNormalText("Next", Colors.white),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),

                          onTap: () {
                            if (stringList.length > 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return SetReps(
                                      widget.exerciseCategory,
                                      stringList,
                                      widget.modelAddMyPlan,
                                      widget.getWeek,
                                      widget.getDay);
                                },
                              ));
                            } else {
                              showCustomToast(
                                  "Select at least one exercise", context);
                            }
                          },
                        ),
                      )
                    ],
                  )
                  // child: FutureBuilder<List<ModelExerciseDetail>>(
                  //   future: _databaseHelper.getExerciseCount(
                  //       widget.exerciseCategory.id, context),
                  //   builder: (context, snapshot) {
                  //     return GridView.builder(
                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2, childAspectRatio: 1.2),
                  //       itemCount: snapshot.data.length,
                  //       itemBuilder: (context, index) {
                  //         ModelExerciseDetail exerciseDetail = snapshot.data[index];
                  //         return SelectExerciseItem(exerciseDetail, callback);
                  //       },
                  //     );
                  //   },
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  getGridLIst(List<ModelExerciseDetail> _list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ModelExerciseDetail category = _list[index];
        final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
          // Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / _list.length) * index, 1.0,
                curve: Curves.fastOutSlowIn),
          ),
        );
        animationController!.forward();

        return AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 50 * (1.0 - animation.value), 0.0),
                  child: SelectExerciseItem(category, callback),
                ));
          },
        );
      },
      // itemCount: 3,
      itemCount: _list.length,
    );

    // return GridView.count(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1.3,
    //     padding: EdgeInsets.all(7),
    //     shrinkWrap: true,
    //     children: List.generate(_list.length, (index) {
    //       ModelExerciseDetail maincat = _list[index];
    //       print("size==$index---${_list.length}");
    //       return ExerciseCatItem(maincat, context);
    //     }));
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
