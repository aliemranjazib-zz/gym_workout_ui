
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';


class EditPlan extends StatefulWidget {
  @override
  _EditPlan createState() => _EditPlan();
}

class _EditPlan extends State<EditPlan> {
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

  // List<String> country = [
  //   "America",
  //   "Brazil",
  //   "Canada",
  //   "India",
  //   "Mongalia",
  //   "USA",
  //   "China",
  //   "Russia",
  //   "Germany"
  // ];

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
        // appBar: getThemeAppBar("Add Plan", () {
        //   onBackClick();
        // }),
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
                        child: ConstantWidget.getTextWidget(S.of(context).editPlan,Colors.white, TextAlign.start,
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
                    // getSizeBox,

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
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintStyle: getTextStyle(),
                          hintText: S.of(context).typeHere),
                    ),
                    getSizeBox,

                    getSizeBox,
                    Wrap(
                      children: [
                         Center(

                           child: Container(

                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal! * 15,
                                vertical: SizeConfig.safeBlockHorizontal! * 2.8),


                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(ConstantWidget.getScreenPercentSize(context,1.2)))
                            ),

                            child: ConstantWidget.getCustomText(S.of(context).updatePlan, Colors.white, 1, TextAlign.center, FontWeight.bold,
                                ConstantData.font18Px),


                        ),
                         ),
                      ],
                    )


                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
