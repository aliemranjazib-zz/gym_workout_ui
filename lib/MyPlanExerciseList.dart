import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/CopyWeek.dart';
import 'package:healtho_app/SelectMuscle.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/model/ModelMyPlanExercise.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'ExerciseDetailScreen.dart';

class MyPlanExerciseList extends StatefulWidget {
  final ModelAddMyPlan modelAddMyPlan;
  final int week;
  final int getDay;

  MyPlanExerciseList(this.modelAddMyPlan, this.week, this.getDay);

  @override
  _MyPlanExerciseList createState() => _MyPlanExerciseList();
}

class MyPlanExerciseItem extends StatefulWidget {
  final ModelMyPlanExercise modelMyPlanExercise;
  final Function callBack;

  MyPlanExerciseItem(this.modelMyPlanExercise, this.callBack);

  @override
  _MyPlanExerciseItem createState() => _MyPlanExerciseItem();
}

class _MyPlanExerciseItem extends State<MyPlanExerciseItem> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<TextEditingController> txtEditController = [];
  var _controller = TextEditingController();
  var _controllerWeight = TextEditingController();
  var _controllerRest = TextEditingController();

  // var _controllerReps = TextEditingController();
  bool isEnableSet = false;
  bool isEnableReps = false;
  double edtMargin = 2;
  double edtSize = 50;
  double fontSize = 12;
  bool valueExercise = false;
  List<bool> isShowList = [];
  bool isVisibleEdit = true;
  List<bool> isShowListVal = [];
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    print("gtedata22===true");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    txtEditController.add(new TextEditingController());
    // showPosition(1);
    print("gtedata===true");
    updatedatas();
    showPosition(widget.modelMyPlanExercise.noSets!);

    super.initState();
  }

  getCell(String s, String s1) {
    return Row(
      children: [
        Container(
          width: ConstantWidget.getWidthPercentSize(context, 15),
          child: ConstantWidget.getTextWidget(s, Colors.black, TextAlign.start,
              FontWeight.w300, ConstantData.font12Px),
        ),
        ConstantWidget.getTextWidget(":  " + s1, Colors.black, TextAlign.start,
            FontWeight.w300, ConstantData.font12Px)
      ],
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
                                                  controller: textEditingController2,
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
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                                color: ConstantData.cellColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),

                                            child: Row(
                                              children: [
                                                Container(
                                                  width: defWidth,
                                                  child: ConstantWidget
                                                      .getTextWidget(
                                                      "Sets "+((index+1).toString()),
                                                      ConstantData.defColor,
                                                      TextAlign.start,
                                                      FontWeight.w600,
                                                      ConstantData.font15Px),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                    height: ConstantWidget
                                                        .getScreenPercentSize(
                                                        context, 3),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontFamily: ConstantData.fontsFamily,
                                                          fontSize: ConstantData.font12Px

                                                      ),
                                                      controller:
                                                      textEditingController1,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                            RegExp(r'[0-9]')),
                                                      ],
                                                      textAlign: TextAlign.center,
                                                      textAlignVertical:
                                                      TextAlignVertical
                                                          .center,
                                                      decoration: InputDecoration(
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
                                                          margin: EdgeInsets.only(
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
                                                                  height, 70),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          // setState.setState(() {

                                                          setState(() {
                                                            if (duration > 0) {
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
                                                              horizontal: 7),
                                                          height: ConstantWidget
                                                              .getScreenPercentSize(
                                                              context, 3),
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
                                                                fontFamily: ConstantData.fontsFamily,
                                                                fontSize: ConstantData.font12Px

                                                            ),
                                                            textAlign:
                                                            TextAlign.center,
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
                                                          margin: EdgeInsets.only(
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
                                          );
                                        },),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: height * 2.5,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){

                                                    setState((){
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
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        Icon(Icons.add,color: Colors.white,),
                                                        SizedBox(width: 5,),
                                                        ConstantWidget
                                                            .getTextWidget(
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
                                                  onTap:(){
                                                    setState((){
                                                     if(setSize> 1){
                                                       setSize--;
                                                     }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: height * 2.5,
                                                    margin: EdgeInsets.only(left: 5),
                                                    decoration: BoxDecoration(
                                                        color: ConstantData
                                                            .cellColor,
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(7))),

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        Icon(Icons.remove,color: Colors.grey,),
                                                        SizedBox(width: 5,),
                                                        ConstantWidget
                                                            .getTextWidget(
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
                                            onTap:(){
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: height * 2.5,
                                              width: ConstantWidget.getWidthPercentSize(context,30),

                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(7))),

                                              child: Center(
                                               child: ConstantWidget
                                                   .getTextWidget(
                                                   S.of(context).update,
                                                   Colors.white,
                                                   TextAlign.start,
                                                   FontWeight.w600,
                                                   ConstantData.font18Px)
                                              ),
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

  @override
  Widget build(BuildContext context) {
    print("getdatas223344===true");
    SizeConfig().init(context);
    return FutureBuilder<ModelExerciseDetail>(
      future: _databaseHelper.getExerciseDetailByid(
          widget.modelMyPlanExercise.id!, context),
      builder: (context, snapshot) {
        String name = "";
        if (snapshot.hasData) {
          name = snapshot.data!.exerciseName!;
        }
        if (isFirst) {
          updatedatas();
          int? sets = widget.modelMyPlanExercise.noSets;
          _controller.text = sets.toString();
          _controllerWeight.text = widget.modelMyPlanExercise.weight.toString();
          _controllerRest.text = widget.modelMyPlanExercise.rest.toString();

          if (widget.modelMyPlanExercise.noReps!.isNotEmpty) {
            var getData = jsonDecode(widget.modelMyPlanExercise.noReps!);
            List<int> lists = List<int>.from(getData);
            for (int i = 0; i < lists.length; i++) {
              txtEditController[i].text = lists[i].toString();
            }
          }
          // showPosition(sets);

          // _controllerReps.text = widget.modelMyPlanExercise.no_reps;
        }
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => ExerciseDetailScreen(),
                builder: (context) => ExerciseDetailScreen(
                  exerciseDetail: snapshot.data,
                ),
              ),
            );
          },
          child: Container(
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(7),
            //     boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)]),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  ConstantData.assetImagesPath + "abs_1.png",
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  height: SizeConfig.safeBlockHorizontal! * 25,
                ),
                SizedBox(
                  width: 15,
                ),

                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantWidget.getTextWidget(name, Colors.black,
                        TextAlign.start, FontWeight.w500, ConstantData.font15Px),
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

                          // child: InkWell(
                          //   child: Image.asset(valueExercise?ConstantData.assetImagesPath+"checked.png":
                          //   ConstantData.assetImagesPath+"uncheck.png",
                          //   color:valueExercise?primaryColor:Colors.grey),
                          // ),

                              child: InkWell(

                                onTap: (){

                                      _databaseHelper
                                          .addCompleteMyPlanExercise(
                                              widget.modelMyPlanExercise.week!,
                                              widget.modelMyPlanExercise.day!,
                                              widget.modelMyPlanExercise.exerciseId
                                              !,
                                              widget.modelMyPlanExercise.myPlanId!)
                                          .then((value) {
                                        setState(() {
                                          print("change==$value");
                                          // valueExercise = valueExercise!;

                                          if(valueExercise){
                                            valueExercise=false;
                                          }else{
                                            valueExercise=true;
                                          }
                                        });
                                      });
                                },

                                child: Image.asset(valueExercise?ConstantData.assetImagesPath+"checked.png":
                                ConstantData.assetImagesPath+"uncheck.png",
                                  color:valueExercise?primaryColor:Colors.grey,height: ConstantData.font22Px,),
                              ),


                          // child: Checkbox(
                          //   value: valueExercise,
                          //   onChanged: (values) {
                          //     _databaseHelper
                          //         .addCompleteMyPlanExercise(
                          //             widget.modelMyPlanExercise.week!,
                          //             widget.modelMyPlanExercise.day!,
                          //             widget.modelMyPlanExercise.exercise_id!,
                          //             widget.modelMyPlanExercise.my_plan_id!)
                          //         .then((value) {
                          //       setState(() {
                          //         print("change==$value");
                          //         valueExercise = values!;
                          //       });
                          //     });
                          //   },
                          // ),
                        ))
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
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: ConstantWidget.getTextWidget(
                                  S.of(context).edit,
                                  Colors.white,
                                  TextAlign.center,
                                  FontWeight.w500,
                                  ConstantData.font15Px),
                            ),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: ConstantWidget.getTextWidget(
                                  S.of(context).delete,
                                  Colors.white,
                                  TextAlign.center,
                                  FontWeight.w500,
                                  ConstantData.font15Px),
                            ),
                          ),
                        )),
                        Expanded(child: Container()),
                      ],
                    )
                  ],
                ))

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           ConstantData.assetImagesPath + "abs_1.png",
                //           width: SizeConfig.safeBlockHorizontal! * 20,
                //           height: SizeConfig.safeBlockHorizontal! * 20,
                //         ),
                //         SizedBox(
                //           width: 7,
                //         ),
                //         Expanded(
                //           flex: 1,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 name,
                //                 style: getTextStyles(Colors.black54, 16),
                //                 overflow: TextOverflow.ellipsis,
                //                 maxLines: 1,
                //               ),
                //               Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Text(
                //                     "Sets: ",
                //                     style: getTextStyles(Colors.black54, 14),
                //                     maxLines: 1,
                //                   ),
                //
                //                   Container(
                //                     margin: EdgeInsets.all(edtMargin),
                //                     width: edtSize,
                //                     height: edtSize,
                //                     child: TextField(
                //                       enabled: isEnableReps,
                //                       controller: _controller,
                //                       keyboardType: TextInputType.number,
                //                       style: TextStyle(fontSize: fontSize),
                //                       decoration: InputDecoration(
                //                         counterText: "",
                //                         border: OutlineInputBorder(
                //                           borderRadius: BorderRadius.circular(5),
                //                           borderSide: BorderSide(color: Colors.grey),
                //                         ),
                //                       ),
                //                       onChanged: (value) {
                //                         print("getval==$value");
                //                         int getVal = int.parse(value);
                //                         _controller.text = value;
                //                         isFirst = false;
                //                         setState(() {
                //                           showPosition(getVal);
                //                         });
                //                       },
                //                       maxLength: 1,
                //                       textAlign: TextAlign.center,
                //                     ),
                //                   ),
                //
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Text(
                //                     "Reps: ",
                //                     style: getTextStyles(Colors.black54, 14),
                //                     maxLines: 1,
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[0],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[0],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[0],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[1],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[1],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[1],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[2],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[2],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Text(
                //                     "Reps: ",
                //                     style: getTextStyles(Colors.transparent, 14),
                //                     maxLines: 1,
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[3],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[3],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[2],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[4],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[4],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[3],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[5],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[5],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Text(
                //                     "Reps: ",
                //                     style: getTextStyles(Colors.transparent, 14),
                //                     maxLines: 1,
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[6],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[6],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[4],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[7],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[7],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                   Visibility(
                //                     child: getSmallBoldText("X", Colors.grey),
                //                     visible: isShowListVal[5],
                //                   ),
                //                   Visibility(
                //                     visible: isShowList[8],
                //                     child: Container(
                //                       margin: EdgeInsets.all(edtMargin),
                //                       width: edtSize,
                //                       height: edtSize,
                //                       child: TextField(
                //                         keyboardType: TextInputType.number,
                //                         enabled: isEnableReps,
                //                         controller: txtEditController[8],
                //                         style: TextStyle(fontSize: fontSize),
                //                         decoration: InputDecoration(
                //                           counterText: "",
                //                           border: OutlineInputBorder(
                //                             borderRadius: BorderRadius.circular(5),
                //                             borderSide:
                //                             BorderSide(color: Colors.grey),
                //                           ),
                //                         ),
                //                         maxLength: 2,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               // Expanded(
                //               //   child: Visibility(
                //               //     visible: true,
                //               //     child: RaisedButton(
                //               //       color: ConstantData.themeData.primaryColor,
                //               //       child: Center(
                //               //         child: getSmallBoldText("Edit", Colors.white),
                //               //       ),
                //               //       onPressed: () {
                //               //         setState(() {
                //               //           isEnableReps = true;
                //               //         });
                //               //       },
                //               //     ),
                //               //   ),
                //               //   flex: 1,
                //               // )
                //
                //               // Container(child:  AutoSizeTextField(
                //               //   controller: _controller,
                //               //   fullwidth: false,
                //               //   style:getTextStyles(Colors.grey, 15),
                //               //   maxLines: 1,
                //               //   cu
                //               //   maxFontSize: 15,
                //               //   keyboardType: TextInputType.number,
                //               // ))
                //
                //               // Expanded(child: TextField(autofocus: true)),
                //               // new Flexible(
                //               //   child: new TextField(
                //               //     decoration: const/ InputDecoration(helperText: "Enter App ID"),
                //               //     style: Theme.of(context).textTheme.body1,
                //               //   ),
                //               // ),
                //               // Expanded(
                //               //   flex: 1,
                //               //   child:Wrap(
                //               //     direction: Axis.horizontal,
                //               //     spacing: 10,
                //               //     children: <Widget>[
                //               //     TextField(
                //               //         enabled: isEnableSet,
                //               //         controller: _controller,
                //               //         keyboardType: TextInputType.number,
                //               //       ),Expanded(flex: 1,child: SizedBox(),)
                //               //       // Text('One'),
                //               //       // Text('Two'),
                //               //       // Text('Three'),
                //               //       // Text('Four'),
                //               //     ],
                //               //   ),
                //               // )
                //               // Expanded(
                //               //   flex: 1,
                //               //
                //               //   child: TextField(
                //               //     enabled: isEnableSet,
                //               //     controller: _controller,
                //               //     keyboardType: TextInputType.number,
                //               //     maxLines: 1,
                //               //   ),
                //               // )
                //               // TextField(
                //               //   enabled: isEnableSet,
                //               //   controller: _controller,
                //               //   keyboardType: TextInputType.number,
                //               //   maxLines: 1,
                //               // )
                //             ],
                //           ),
                //         ),
                //
                //         // Expanded(
                //         //   flex: 1,
                //         //   child: Column(
                //         //     children: [
                //         //       Text(snapshot.data.exerciseName,style: getTextStyles(Colors.black54,16),maxLines: 1,),
                //         //       Row(
                //         //         mainAxisSize: MainAxisSize.max,
                //         //         children: [
                //         //           Text("Sets: ",style: getTextStyles(Colors.black54,14),maxLines: 1,),
                //         //           TextField(
                //         //             enabled: isEnableSet,
                //         //             controller: _controller,
                //         //             keyboardType: TextInputType.number,
                //         //             maxLines: 1,
                //         //           )
                //         //         ],
                //         //       ),
                //         //       // Wrap(
                //         //       //   direction: Axis.horizontal,
                //         //       //   children: [
                //         //       //     getSmallNormalText("Reps: ", Colors.black54),
                //         //       //     TextField(
                //         //       //       enabled: isEnableReps,
                //         //       //       controller: _controllerReps,
                //         //       //       keyboardType: TextInputType.number,
                //         //       //       maxLines: 1,
                //         //       //     )
                //         //       //   ],
                //         //       // )
                //         //     ],
                //         //   ),
                //         // )
                //         // ,
                //         Column(
                //           children: [
                //             Checkbox(
                //               value: valueExercise,
                //               onChanged: (values) {
                //                 _databaseHelper
                //                     .addCompleteMyPlanExercise(
                //                     widget.modelMyPlanExercise.week!,
                //                     widget.modelMyPlanExercise.day!,
                //                     widget.modelMyPlanExercise.exercise_id!,
                //                     widget.modelMyPlanExercise.my_plan_id!)
                //                     .then((value) {
                //                   setState(() {
                //                     print("change==$value");
                //                     valueExercise = values!;
                //
                //                     // widget.callback(widget.exerciseDetail);
                //                   });
                //                 });
                //               },
                //             ),
                //             // Expanded(
                //             //   child: SizedBox(),
                //             //   flex: 1,
                //             // ),
                //             IconButton(
                //               icon: Icon(
                //                 CupertinoIcons.delete,
                //                 color: ConstantData.themeData.primaryColor,
                //               ),
                //               onPressed: () {
                //                 _databaseHelper
                //                     .removeMyPlanById(widget.modelMyPlanExercise.id!)
                //                     .then((value) {
                //                   print("deleteenable==$value");
                //                   // setState(() {
                //                   widget.callBack();
                //                   // });
                //                 });
                //               },
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Visibility(
                //           visible: (isEnableReps)
                //               ? true
                //               : ((widget.modelMyPlanExercise.weight! > 0)
                //               ? true
                //               : false),
                //
                //           // visible: (widget.modelMyPlanExercise.weight > 0) ? true : false,
                //           child: Expanded(
                //               child: Center(
                //                 child: Row(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Text(
                //                       "Weight: ",
                //                       style: getTextStyles(Colors.grey, 14),
                //                     ),
                //                     Container(
                //                       width: 60,
                //                       height: 40,
                //                       child: TextField(
                //                         enabled: isEnableReps,
                //                         controller: _controllerWeight,
                //                         decoration: InputDecoration(counterText: ""),
                //                         keyboardType: TextInputType.number,
                //                         textAlign: TextAlign.center,
                //                         maxLength: 3,
                //                       ),
                //                     ),
                //                     Text(
                //                       "kg",
                //                       style: getTextStyles(Colors.grey, 14),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //               flex: 1),
                //         ),
                //         Visibility(
                //           visible: (isEnableReps)
                //               ? true
                //               : ((widget.modelMyPlanExercise.rest! > 0)
                //               ? true
                //               : false),
                //           child: Expanded(
                //               child: Center(
                //                 child: Row(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Text(
                //                       "Rest: ",
                //                       style: getTextStyles(Colors.grey, 14),
                //                     ),
                //                     Container(
                //                       width: 60,
                //                       height: 40,
                //                       child: TextField(
                //                         enabled: isEnableReps,
                //                         controller: _controllerRest,
                //                         decoration: InputDecoration(counterText: ""),
                //                         keyboardType: TextInputType.number,
                //                         textAlign: TextAlign.center,
                //                         maxLength: 3,
                //                       ),
                //                     ),
                //                     Text(
                //                       "sec",
                //                       style: getTextStyles(Colors.grey, 14),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //               flex: 1),
                //         )
                //       ],
                //     ),
                //     Visibility(
                //       visible: isVisibleEdit,
                //       child: RaisedButton(
                //         color: ConstantData.themeData.primaryColor,
                //         child: Center(
                //           child: getSmallBoldText("Edit", Colors.white),
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             isEnableReps = true;
                //             isVisibleEdit = false;
                //           });
                //         },
                //       ),
                //     ),
                //     Visibility(
                //         visible: !isVisibleEdit,
                //         child: Column(
                //           children: [
                //             Row(
                //               children: [
                //                 Expanded(
                //                   flex: 1,
                //                   child: RaisedButton(
                //                     color: ConstantData.themeData.primaryColor,
                //                     child: Center(
                //                       child: getSmallBoldText("Done", Colors.white),
                //                     ),
                //                     onPressed: () {
                //                       int weight = 0;
                //                       int rest = 0;
                //
                //                       String getSetval =
                //                       _controller.value.text.toString();
                //                       String getWeight =
                //                       _controllerWeight.value.text.toString();
                //                       String getRest =
                //                       _controllerRest.value.text.toString();
                //
                //                       if (getRest.isNotEmpty) {
                //                         rest = int.parse(getRest);
                //                       }
                //
                //                       if (getWeight.isNotEmpty) {
                //                         weight = int.parse(getWeight);
                //                       }
                //                       int set = 1;
                //                       if (getSetval.isNotEmpty) {
                //                         set = int.parse(getSetval);
                //                       }
                //
                //                       List<int> intlist = [];
                //                       for (int i = 0; i < set; i++) {
                //                         String getVal = txtEditController[i]
                //                             .value
                //                             .text
                //                             .toString();
                //                         if (getVal.isEmpty) {
                //                           intlist.add(1);
                //                         } else {
                //                           intlist.add(int.parse(getVal));
                //                         }
                //                       }
                //                       String s = jsonEncode(intlist);
                //
                //                       print("gteset==$set");
                //                       _databaseHelper
                //                           .updateMyPlanRestData(set, s, weight, rest,
                //                           widget.modelMyPlanExercise.id!)
                //                           .then((value) {
                //                         setState(() {
                //                           widget.modelMyPlanExercise.no_reps = s;
                //                           widget.modelMyPlanExercise.no_sets = set;
                //                           widget.modelMyPlanExercise.weight = weight;
                //                           widget.modelMyPlanExercise.rest = rest;
                //
                //                           isEnableReps = false;
                //                           isFirst = true;
                //                           isVisibleEdit = true;
                //                         });
                //                       });
                //                     },
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 7,
                //                 ),
                //                 Expanded(
                //                   flex: 1,
                //                   child: RaisedButton(
                //                     color: ConstantData.themeData.primaryColor,
                //                     child: Center(
                //                       child: getSmallBoldText("Cancel", Colors.white),
                //                     ),
                //                     onPressed: () {
                //                       setState(() {
                //                         isEnableReps = false;
                //                         isVisibleEdit = true;
                //                       });
                //                     },
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ],
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  void showPosition(int setPos) {
    isShowListVal = [];
    isShowList = [];
    for (int i = 0; i < 9; i++) {
      if (i < setPos) {
        isShowList.add(true);
      } else {
        isShowList.add(false);
      }
    }

    // for (int j = 0; j < 6; j++) {
    //   if (j < (setPos - 1)) {
    //     isShowListVal.add(true);
    //   } else {
    //     isShowListVal.add(false);
    //   }
    // }

    for (int j = 0; j < 6; j++) {
      int checkpos = ((j > 3)
          ? (setPos - 3)
          : (j > 1)
              ? (setPos - 2)
              : (setPos - 1));
      print("setpos==${setPos - 1}==$j");
      // if (j < (setPos - 1)) {
      if (j < (checkpos)) {
        isShowListVal.add(true);
      } else {
        isShowListVal.add(false);
      }
    }
    setState(() {});
    // isShowList.add(true);
    // isShowList.add(true);
    // isShowList.add(true);
    // isShowList.add(true);
  }

  void updatedatas() {
    _databaseHelper
        .isMyExerciseCompleted(
            widget.modelMyPlanExercise.week!,
            widget.modelMyPlanExercise.day!,
            widget.modelMyPlanExercise.exerciseId!,
            widget.modelMyPlanExercise.myPlanId!)
        .then((value) {
      setState(() {
        if (value > 0) {
          valueExercise = true;
        } else {
          valueExercise = false;
        }
      });
    });
  }
}

class _MyPlanExerciseList extends State<MyPlanExerciseList> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  bool isRest = false;

  // bool isData = false;

  void refreshMainList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = ConstantWidget.getWidthPercentSize(context, 25);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [


              FutureBuilder<List<ModelMyPlanExercise>>(
                future: _databaseHelper.getMyPlanExerciseByDay(
                    widget.modelAddMyPlan.id!, widget.week, widget.getDay),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || isRest) {
                    return ConstantWidget.getAppBar(context, "", () {
                      onBackClick();
                    });
                  } else {
                    print("getdatas22===${snapshot.data}");

                    return ConstantWidget.getAppBarWithAction(
                        context, "", "plus.png", () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SelectMuscle(widget.modelAddMyPlan,
                              widget.week, widget.getDay);
                        },
                      ));
                    }, () {
                      onBackClick();
                    });
                  }
                },
              ),



              Padding(
                padding: EdgeInsets.only(
                    left: ConstantWidget.getWidthPercentSize(context, 5),top: ConstantWidget.getMarginTop(context)),
                child: Row(
                  children: [
                    ConstantWidget.getTextWidget(
                        S.of(context).week + " " + widget.week.toString(),
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
                        S.of(context).day +
                            " " +
                            widget.getDay.toString(),
                        ConstantData.defColor,
                        TextAlign.start,
                        FontWeight.w800,
                        ConstantData.font18Px)
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: ConstantWidget.getMarginTop(context) *1.3),
                child: Column(
                  children: [

                    FutureBuilder<List<ModelMyPlanExercise>>(
                      future: _databaseHelper.getMyPlanExerciseByDay(
                          widget.modelAddMyPlan.id!,
                          widget.week,
                          widget.getDay),
                      builder: (context, snapshot) {
                        print("getdatas===${snapshot.data}");

                        if (snapshot.hasData) {
                          if (snapshot.data![0].exerciseId == 0) {
                            isRest = true;
                          } else {
                            isRest = false;
                          }
                        }
                        if (!snapshot.hasData || isRest) {
                          return getNoData();
                          // return SizedBox(
                          //   width: 5,
                          // );
                        } else {
                          print("getdatas22===${snapshot.data}");

                          return Expanded(
                              child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    refreshMainList();
                                  },
                                  child: Container(
                                    // width: 200,
                                    width: width,
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 15),
                                    // height: 50,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: ConstantWidget.getTextWidget(
                                          S.of(context).update,
                                          Colors.white,
                                          TextAlign.center,
                                          FontWeight.w500,
                                          ConstantWidget.getPercentSize(
                                              width, 12)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  print("getdatas2233===${snapshot.data}");

                                  return MyPlanExerciseItem(
                                      snapshot.data![index], refreshMainList);
                                },
                              ))
                            ],
                          ));
                        }
                      },
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

  void onBackClick() {
    Navigator.of(context).pop();
  }

  Widget getNoData() {
    // return Center(
    //   child:

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // direction: Axis.vertical,
        children: [
          // Center(
          //   child: Icon(CupertinoIcons.square_favorites),
          // ),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 5),
          ),

          Image.asset(
            ConstantData.assetImagesPath + "fitness.png",
            height: ConstantWidget.getScreenPercentSize(context, 10),
            color: Colors.grey,
          ),
          // Icon(
          //   CupertinoIcons.square_favorites,
          //   size: 60,
          //   color: Colors.grey,
          // ),
          Center(
            child: ConstantWidget.getTextWidget(
                "No exercise added.\nPress button to add an exercise.",
                Colors.grey,
                TextAlign.center,
                FontWeight.w300,
                ConstantData.font15Px),
          ),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 5),
          ),

          Padding(
            padding: EdgeInsets.all(7),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SelectMuscle(
                          widget.modelAddMyPlan, widget.week, widget.getDay);
                    },
                  ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    getSmallBoldText(S.of(context).addExercises, Colors.white)
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: !isRest,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(12),

                decoration: BoxDecoration(
                    color: ConstantData.cellColor,
                    borderRadius: BorderRadius.circular(10)),
                // onPressed: () {
                //   _databaseHelper
                //       .addRestDay(
                //           widget.modelAddMyPlan.id!, widget.week, widget.getDay)
                //       .then((value) {
                //     onBackClick();
                //   });
                // },
                child: InkWell(
                  onTap: () {
                    _databaseHelper
                        .addRestDay(widget.modelAddMyPlan.id!, widget.week,
                            widget.getDay)
                        .then((value) {
                      onBackClick();
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   CupertinoIcons.bed_double,
                      //   color: Colors.white,
                      // ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Center(
                      //     child: getSmallBoldText(
                      //         S.of(context).setAsResDay, Colors.white),
                      //   ),
                      // )

                      Icon(
                        Icons.king_bed_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 3,
                      ),

                      getSmallBoldText(S.of(context).setAsResDay, Colors.grey)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(7),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(12),

              decoration: BoxDecoration(
                  color: ConstantData.cellColor,
                  borderRadius: BorderRadius.circular(10)),
              // onPressed: () {

              //

              // },
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CopyWeek(widget.modelAddMyPlan, widget.week,
                          widget.getDay, "");
                    },
                  ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_copy,
                      color: Colors.grey,
                    ),

                    SizedBox(
                      width: 3,
                    ),
                    getSmallBoldText(S.of(context).copyAnotherDay, Colors.grey)
                    // Expanded(
                    //   flex: 1,
                    //   child: Center(
                    //     child: getSmallBoldText(
                    //         S.of(context).copyAnotherDay, Colors.white),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          )
        ],
        // ),
        //   child: ListView(
        // scrollDirection: Axis.vertical,
        // children: [
        //   Center(
        //     child: Icon(CupertinoIcons.square_favorites),
        //   ),
        //   Center(
        //     child: getSmallNormalText(
        //         "No exercise added. Press + icon to add exercise.", Colors.grey),
        //   )
        // ],
        // )
      ),
    );
  }
}
