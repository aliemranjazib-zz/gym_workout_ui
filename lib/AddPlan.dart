import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'MyWorkoutPlanIntroduction.dart';
// import 'package:toast/toast.dart';


class AddPlan extends StatefulWidget {
  @override
  _AddPlan createState() => _AddPlan();
}

class _AddPlan extends State<AddPlan> {
  TextEditingController controllerName = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerWeeks = TextEditingController();
  String dropdownValue = 'One';
  String? goalType="";
  String? catType="Home Workout";
  String? levelType="Beginner";
  List<String> goalList = [];
  List<String> levelList = ["Beginner","Intermediate","Advanced"];
  List<String> catList = ["Home Workout","Gym Workout"];
  List<ModelPlanCategory> planCategoryList = [];


  Widget getSizeBox = SizedBox(
    height: 20,
  );

  @override
  void initState() {
    super.initState();
    _databaseHelper.getAllWorkoutPlans(context).then((value) {
      planCategoryList.addAll(value);
      value.forEach((element) {
        goalList.add(element.name!);
      });

      goalType = goalList[0];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = ConstantWidget.getScreenPercentSize(context, 10);
    double circle = ConstantWidget.getPercentSize(height, 30);
    return WillPopScope(
      onWillPop: () async {
        onBackClick();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: height,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular((ConstantWidget.getPercentSize(height,
                        90))))
                  ),

                  child: Stack(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15),child: Align(
                        alignment: Alignment.centerLeft,
                        child: ConstantWidget.getTextWidget(S.of(context).addPlan,Colors.white, TextAlign.start,
                            FontWeight.w600, ConstantWidget.getPercentSize(height, 30)),
                      ),),

                      Align(alignment: Alignment.topRight,
                      child: InkWell(
                        child: Container(
                          height: circle,
                          width: circle,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle
                          ),
                          margin: EdgeInsets.only(right: 8),
                          child: Center(
                            child: Icon(Icons.close,color: Colors.white,size: ConstantWidget.getPercentSize(circle, 80),),
                          ),
                        ),
                        onTap: (){
                          onBackClick();
                        },
                      ),)
                    ],
                  ),
                ),



              )
,


              Container(
                margin: EdgeInsets.only(top: height),
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(18),
                  children: [
                    getTitle(S.of(context).planName),

                    TextField(
                      controller: controllerName,
                      style: getTextStyle(),
                      decoration: InputDecoration
                        (
                          border: UnderlineInputBorder(),
                          hintStyle: getTextStyle(),
                          hintText: S.of(context).davidsSummerPlan),
                    ),
                    getSizeBox,
                    getTitle(S.of(context).description),
                    TextField(
                      style: getTextStyle(),
                      controller: controllerDesc,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintStyle: getTextStyle(),
                          hintText: S.of(context).typeHere),
                    ),
                    getSizeBox,

                    getTitle(S.of(context).category1),
                    Container(

                      child: DropdownButton(
                        hint: Text(S.of(context).selectCategory),

                        isExpanded: true,
                        items: catList.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        value: catType,
                        onTap: (){
                          FocusScope.of(context).unfocus();

                        },
                        onChanged: (value) {
                          setState(() {
                            catType = value as String;
                          });
                        },
                      ),
                    ),
                    getSizeBox,



                    getTitle(S.of(context).goal),
                    Container(

                      child: DropdownButton(
                        hint: Text(""),

                        isExpanded: true,
                        items: goalList.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onTap: (){
                          FocusScope.of(context).unfocus();

                        },
                        value: goalType,
                        onChanged: (value) {
                          setState(() {
                            goalType = value as String;
                          });
                        },
                      ),
                    ),
                    getSizeBox,
                    getTitle(S.of(context).level1),
                    Container(

                      child: DropdownButton(
                        hint: Text(""),

                        isExpanded: true,
                        items: levelList.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onTap: (){
                          FocusScope.of(context).unfocus();

                        },
                        value: levelType,
                        onChanged: (value) {
                          setState(() {
                            levelType = value as String;
                          });
                        },
                      ),
                    ),
                    getSizeBox,

                    getTitle(S.of(context).durationweeks1),
                    TextField(
                      style: getTextStyle(),
                      controller: controllerWeeks,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintStyle: getTextStyle(),
                          hintText: S.of(context).typeHere),
                    ),
                    getSizeBox,


                    // TextField(
                    //   controller: controllerWeeks,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       hintText: 'Duration(Weeks)'),
                    // ),
                    getSizeBox,

                    new Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal! * 15,
                          right: SizeConfig.safeBlockHorizontal! * 15),
                      child: getCircularButton(primaryColor, 10, S.of(context).addPlan, Colors.black, () {
                            print("inerrr==");
                            if (controllerName.value.text.isEmpty) {
                              showError();
                              print("inerrr==1");
                            } else if (controllerDesc.value.text.isEmpty) {
                              showError();
                              print("inerrr==2");
                            } else if (controllerWeeks.value.text.isEmpty) {
                              showError();
                              print("inerrr==3");
                            } else if (goalType!.isEmpty) {
                              showError();
                              print("inerrr==4");
                            } else {
                              print("inerrr==5${controllerName.value.text}");
                              int index = goalList.indexOf(goalType!);
                              int type = planCategoryList[index].id!;
                              String name = controllerName.value.text;
                              String desc = controllerDesc.value.text;
                              int week = int.parse(controllerWeeks.value.text);


                              Color setColor=Colors.primaries[Random().nextInt(Colors.primaries.length)];

                              _databaseHelper
                                  .addMyPlan(name, desc, type, week, setColor.value.toString(), 0)
                                  .then((value) {


                                Fluttertoast.showToast(
                                    msg: S.of(context).planAddedSuccessfully,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                );
                                
                                _databaseHelper.getCustomPlanById(value).then((value) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyWorkoutPlanIntroduction(value),
                                  ));
                                });

                               

                                
                              });
                            }
                          }),

                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  showError(){

    Fluttertoast.showToast(
        msg: S.of(context).pleaseEnterValue,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  getTextStyle(){
    return TextStyle(fontSize: ConstantWidget.getScreenPercentSize(context, 1.8),color: Colors.black54,fontFamily: ConstantData.fontsFamily);
  }
  getTitle(String s){
    return ConstantWidget.getTextWidget(s,ConstantData.defColor, TextAlign.start,
        FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 2.3));
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
