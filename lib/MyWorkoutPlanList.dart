import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/HomeScreen.dart';
import 'package:healtho_app/MyWorkoutPlanIntroduction.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';

class MyWorkoutPlanList extends StatefulWidget {
  @override
  _MyWorkoutPlanList createState() => _MyWorkoutPlanList();
}

class _MyWorkoutPlanList extends State<MyWorkoutPlanList> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        appBar: getThemeAppBar(S.of(context).myPlans, () {
          onBackClick();
        }),
        backgroundColor: ConstantData.themeData.backgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder<List<ModelAddMyPlan>>(
            future: _databaseHelper.getAllMyPlans(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ModelAddMyPlan>? planCategory = snapshot.data;
                return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    padding: EdgeInsets.all(7),
                    shrinkWrap: true,
                    children: List.generate(planCategory!.length, (index) {
                      ModelAddMyPlan challengeCat = planCategory[index];
                      return Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyWorkoutPlanIntroduction(challengeCat),
                              ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: new Color(int.parse(challengeCat.color!)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 5.0)
                                      ]),
                                  // child: ClipRRect(
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  //   child: Image.asset(
                                  //     "${ConstantData.assetImagesPath}${challengeCat.img}",
                                  //     fit: BoxFit.cover,
                                  //     width: double.infinity,
                                  //     height: double.infinity,
                                  //   ),
                                  // ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: IconButton(
                                        onPressed: () {
                                          _databaseHelper
                                              .removeMyPlan(challengeCat.id!)
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: Icon(
                                          CupertinoIcons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                Center(
                                  child: getMediumBoldText(
                                      "${challengeCat.name![0].toUpperCase()}",
                                      Colors.white),
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 1,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            //new Color.fromRGBO(255, 0, 0, 0.0),
                                            borderRadius: new BorderRadius.only(
                                                topRight:
                                                    const Radius.circular(35.0),
                                                bottomLeft:
                                                    Radius.circular(8.0))),
                                        margin: EdgeInsets.only(right: 30),
                                        child: Padding(
                                          // padding: EdgeInsets.all(0),
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                challengeCat.name!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                maxLines: 1,
                                              ),
                                              Text(
                                                "${challengeCat.noWeek} ${S.of(context).week}",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ));
                      // return Text("htyuuyoui");
                    }));
              } else {
                return Center(
                  child: getMediumBoldText("Plan not found", Colors.black),
                );
              }
            },
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return HomeScreen(1);
      },
    ));
    // Navigator.of(context).pop();
  }
}
