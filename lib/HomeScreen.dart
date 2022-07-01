import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:healtho_app/AboutDetailWidget.dart';
import 'package:healtho_app/AddPlan.dart';
import 'package:launch_review/launch_review.dart';

import 'package:healtho_app/ChallengesIntroduction.dart';
import 'package:healtho_app/ConstantColors.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/EditProfilePage.dart';
import 'package:healtho_app/ExerciseCategoryList.dart';
import 'package:healtho_app/MoreWorkoutList.dart';
import 'package:healtho_app/MoreWorkoutPlanList.dart';
import 'package:healtho_app/NotificationPage.dart';
import 'package:healtho_app/ReminderList.dart';
import 'package:healtho_app/SignUpPage.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/WorkoutPlanIntroduction.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelChallengeMainCat.dart';
import 'package:healtho_app/model/ModelExerciseCategory.dart';
import 'package:healtho_app/model/ModelExerciseDetail.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/model/ModelPlanSubCategory.dart';
import 'package:healtho_app/model/ServicesModel.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/DataFile.dart';
import 'package:healtho_app/utils/MotionTabBarView.dart';
import 'package:healtho_app/utils/MotionTabController.dart';
import 'package:healtho_app/utils/PrefData.dart';
import 'package:healtho_app/utils/motiontabbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';

import 'ChallengeList.dart';
import 'HealthDetailPage.dart';
import 'MyWorkoutPlanIntroduction.dart';
import 'QuickWorkoutList.dart';
import 'TermsAndConditionWidget.dart';
import 'model/HealthModel.dart';
import 'model/ModelAddMyPlan.dart';
import 'model/SliderModel.dart';
import 'model/WorkoutModel.dart';
// import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  final int currentIndex1;

  HomeScreen(this.currentIndex1);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Locale? _userLocale;
  int index = 0;
  MotionTabController? _tabController;

  MotionTabBar? motionTabBar;

  @override
  void didChangeDependencies() {
    // 3
    final newLocale = Localizations.localeOf(context);

    if (newLocale != _userLocale) {
      _userLocale = newLocale;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new MotionTabController(
        initialIndex: widget.currentIndex1, length: s.length, vsync: this);

    // _widgetOptions = <Widget>[
    //   HomeWidget((i) {
    //     if (i == 1) {
    //       setState(() {
    //
    //         index = 1;
    //       });
    //     } else {
    //       requestPop();
    //     }
    //   }),
    //   ExerciseWidget((i) {
    //     requestPop();
    //   }),
    //   WorkoutPlanWidget((i) {
    //     requestPop();
    //   }),
    //   ChallengeWidget((i) {
    //     requestPop();
    //   }),
    //   MoreSettingWidget((i) {
    //     requestPop();
    //   }),
    // ];
    index = widget.currentIndex1;
    setState(() {});
  }

  void requestPop() {
    if (index == 0) {
      exitApp();
      // Future.delayed(const Duration(milliseconds: 200), () {
      //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
    } else {
      setState(() {
        _tabController!.index = 0;
        index = 0;
      });
    }
  }

  List<String> s = [
    "Home",
    "Exercise",
    "Workout",
    "Fitness Tips",
    "BMR",
    "Setting",
  ];

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    print("langcode${myLocale.languageCode}");

    motionTabBar = new MotionTabBar(
      labels: s,
      initialSelectedTab: s[index],
      tabIconColor: Colors.black,
      tabSelectedColor: primaryColor,
      selectedIndex: index,
      onTabItemSelected: (int value) {
        print(value);
        setState(() {
          _tabController!.index = value;
          index = value;
        });
      },
      assetIcons: [
        "home.png",
        "dumbell_2.png",
        "add.png",
        "dumbell_5.png",
        "bmr.png",
        "more.png",
      ],
      icons: [
        Icons.home,
        Icons.help_outline,
        Icons.directions_car_rounded,
        Icons.settings,
        Icons.settings,
        Icons.abc,
      ],
      textStyle: TextStyle(
          color: Colors.transparent,
          fontSize: 0,
          fontFamily: ConstantData.fontsFamily),
    );

    return WillPopScope(
      child: Scaffold(
        key: _drawerKey,
        body: SafeArea(
            child: MotionTabBarView(
          controller: _tabController!,
          children: <Widget>[
            HomeWidget((value) {
              if (value > 0) {
                setState(() {
                  _tabController!.index = value;
                  index = value;
                });
              } else {
                requestPop();
              }
            }),
            ExerciseWidget((value) {
              requestPop();
            }),
            WorkoutPlanWidget((i) {
              requestPop();
            }),
            ChallengeWidget((i) {
              requestPop();
            }),
            MetricSystem((i) {
              requestPop();
            }),
            MoreSettingWidget((i) {
              requestPop();
            }),
          ],
        )),
        bottomNavigationBar: motionTabBar,
      ),
      onWillPop: () async {
        print("inback===true${widget.currentIndex1}");
        requestPop();
        return false;
      },
    );
  }

  getBottomBarItem(String s, int position) {
    double height = ConstantWidget.getScreenPercentSize(context, 2.5);

    Color color = (position == index) ? defPrimaryColor : bottomIconColor;
    return IconButton(
        icon: Image.asset(
          ConstantData.assetHomeImagesPath + s,
          fit: BoxFit.cover,
          color: color,
          height: height,
        ),
        color: color,
        onPressed: () {
          if (position >= 0) {
            setState(() {
              index = position;
            });
          }
        });
  }

  void backAlertDialog(BuildContext contexts) {
    showCupertinoDialog(
      context: contexts,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          S.of(context).exit,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        content: Text(
          S.of(context).areYouSureWantToExitApp,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              S.of(context).yes,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            // onPressed: () => Navigator.pop(context,true),
            onPressed: () {
              // Navigator.of(context).pop();
              // Navigator.pop(context,true);
              // SystemNavigator.pop();
              // Future.delayed(const Duration(milliseconds: 200), () {
              //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              // });
              exitApp();
              //   // Navigator.of(context).pop(true);
              //   // toast('Cancel');
              //   // finish(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              S.of(context).no,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);

              // toast('Logout');
              // finish(context);
            },
          )
        ],
      ),
    );
  }
}

class MoreSettingWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  MoreSettingWidget(this.onChanged);

  @override
  _MoreSettingWidget createState() => _MoreSettingWidget();
}

double marginMain = 10;
double paddingImage = 10;
double padding = 7;
double radius = 10;
int boxWidth = 3;

class _MoreSettingWidget extends State<MoreSettingWidget> {
  Future<void> share() async {
    Share.share(S.of(context).app_name, subject: S.of(context).app_name);
  }

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.desk.feelit_fitness',
    // googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1491556149',
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      _rateMyApp.conditions.forEach((condition) {
        if (condition is DebuggableCondition) {
          // print(condition.valuesAsString());
          // We iterate through our list of conditions and we print all debuggable ones.
        }
      });

      print('Are all conditions met ? ' +
          (_rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

      // if (_rateMyApp.shouldOpenDialog) _buildShowStarRateDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                ConstantWidget.getAppBar(context, S.of(context).settings, () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(2),
                  //     ));

                  widget.onChanged(0);
                }),
                Container(
                  margin: EdgeInsets.only(
                      top: ConstantWidget.getMarginTop(context)),
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView(
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).editProfile, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ));
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.timer,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).reminder, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ReminderList();
                            },
                          ));
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.notifications,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).notification, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return NotificationPage();
                            },
                          ));
                        },
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.info,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).aboutUs, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutDetailWidget(),
                              ));
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.privacy_tip_outlined,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).termsConditions,
                                      Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsAndConditionWidget(),
                              ));
                        },
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.security,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).privacyPolicy,
                                      Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          launchURL();
                        },
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.share,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).share, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          share();
                        },
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.star_rate,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).rateUs, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          LaunchReview.launch();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.feedback,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).feedback, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          // BetterFeedback.of(context).show();

                          final Email email = Email(
                            body: 'Email body',
                            subject: 'Email subject',
                            recipients: ['example@example.com'],
                            cc: ['cc@example.com'],
                            bcc: ['bcc@example.com'],
                            attachmentPaths: ['/path/to/attachment.zip'],
                            isHTML: false,
                          );
                          //
                          await FlutterEmailSender.send(email);
                        },
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(marginMain),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: whiteGray),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(paddingImage),
                                  child: Icon(
                                    Icons.logout,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! *
                                      boxWidth,
                                ),
                                Expanded(
                                  child: getSmallNormalText(
                                      S.of(context).logOut, Colors.black),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          PrefData.setIsSignIn(false);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ));
                        },
                      ),
                      // GestureDetector(
                      //   child: Container(
                      //     margin: EdgeInsets.all(marginMain),
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(radius),
                      //         color: whiteGray),
                      //     child: Padding(
                      //       padding: EdgeInsets.only(top: padding, bottom: padding),
                      //       child: Row(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.all(paddingImage),
                      //             child: Icon(
                      //               Icons.star_rate_outlined,
                      //               color: Theme
                      //                   .of(context)
                      //                   .accentColor,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: SizeConfig.safeBlockHorizontal * boxWidth,
                      //           ),
                      //           Expanded(
                      //             child: getSmallNormalText(S.of(context).rateUs, Colors.black),
                      //             flex: 1,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     _buildShowStarRateDialog(context);
                      //     },
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          widget.onChanged(0);

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomeScreen(2),
          //     ));
          return false;
        });
  }
}

class MetricSystem extends StatefulWidget {
  final ValueChanged<int> onChanged;

  MetricSystem(this.onChanged);
  @override
  _MetricSystemState createState() => _MetricSystemState();
}

class _MetricSystemState extends State<MetricSystem> {
  List<DropdownMenuItem<String>> dropdownGenderList = [];
  List<DropdownMenuItem<String>> dropdownEquationList = [];
  List<DropdownMenuItem<String>> dropdownActivityList = [];
  List<String> dropdownGender = ["Female", "Male"];
  List<String> dropdownEquation = ["Mifflin-St Jeor", "Harris-Benedict"];
  List<String> dropdownActivity = [
    "I am sedentary",
    "I am lightly active",
    "I am moderately active",
    "I am very active",
    "I am super active"
  ];
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? selected,
      selected1,
      selected2,
      genderController,
      equationController,
      activityController;
  int age = 0, height = 0, weight = 0, bmrTotal = 0, calories = 0;
  double bmrDouble = 0.0;
  double? caloriesDouble;

  @override
  Widget build(BuildContext context) {
    loadGender();
    loadEquation();
    loadActivity();
    return new Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(
                //   'assets/images/bmr.png',
                //   scale: 1,
                // ),
                SizedBox(
                  height: 50,
                ),
                // GestureDetector(
                //     onTap: _onClick,
                //     child: Text('Unfamiliar with the Metric system?',
                //         style: TextStyle(fontSize: 16))),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    // padding: EdgeInsets.all(8.0),
                    // decoration: BoxDecoration(
                    //   color: Colors.grey.withOpacity(0.2),
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: new DropdownButton(
                      borderRadius: BorderRadius.circular(20),
                      value: selected,
                      items: dropdownGenderList,
                      hint: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: new Text("Gender"),
                      ),
                      // icon: Icon(Icons.arrow_drop_down_circle),
                      // iconSize: 15,
                      iconEnabledColor: Colors.black,
                      // elevation: 100,
                      // style: TextStyle(color: Colors.orange),
                      underline: Container(
                        height: 0.7,
                        color: Colors.black,
                      ),
                      onChanged: (String? genderValue) {
                        selected = genderValue;
                        setState(() {
                          genderController = genderValue;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    child: new DropdownButton(
                      value: selected1,
                      items: dropdownEquationList,
                      hint: new Text("Equation method"),
                      // icon: Icon(Icons.arrow_drop_down_circle),
                      // iconSize: 15,
                      iconEnabledColor: Colors.black,
                      elevation: 20,
                      style: TextStyle(color: Colors.orange),
                      underline: Container(
                        height: 0.7,
                        color: Colors.black,
                      ),
                      onChanged: (String? equationChoice) {
                        selected1 = equationChoice;
                        setState(() {
                          equationController = equationChoice;
                        });
                      },
                    ),
                  ),
                ),
                TextField(
                  style: new TextStyle(
                      fontSize: 15.0, height: 1.5, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _ageController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _heightController,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _weightController,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    child: new DropdownButton(
                      value: selected2,
                      items: dropdownActivityList,
                      hint: new Text("Level of Activeness"),
                      // icon: Icon(Icons.),
                      // iconSize: 15,
                      iconEnabledColor: Colors.black,
                      // elevation: 20,
                      style: TextStyle(color: Colors.orange),
                      underline: Container(
                        height: 0.7,
                        color: Colors.black,
                      ),
                      onChanged: (String? activityChoice) {
                        selected2 = activityChoice;
                        setState(() {
                          activityController = activityChoice;
                        });
                      },
                    ),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minWidth: 300,
                  height: 50,
                  child: Text('Calculate BMR'),
                  color: Colors.cyan,
                  textColor: Colors.black,
                  elevation: 5,
                  onPressed: _onPress,
                ),
                SizedBox(height: 8),

                Text("Your results are as follows:"),
                SizedBox(height: 8),
                Text(
                  "Your BMR is $bmrTotal",
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Recommended Calorie intake is $calories"),
                SizedBox(
                  height: 8,
                ),
              ],
            )));
  }

  void loadGender() {
    dropdownGenderList = [];
    dropdownGenderList = dropdownGender
        .map((values) => new DropdownMenuItem<String>(
              child: new Text(values),
              value: values,
            ))
        .toList();
  }

  void loadEquation() {
    dropdownEquationList = [];
    dropdownEquationList = dropdownEquation
        .map((values) => new DropdownMenuItem<String>(
              child: new Text(values),
              value: values,
            ))
        .toList();
  }

  void loadActivity() {
    dropdownActivityList = [];
    dropdownActivityList = dropdownActivity
        .map((values) => new DropdownMenuItem<String>(
              child: new Text(values),
              value: values,
            ))
        .toList();
  }

  void _onPress() {
    setState(() {
      age = int.parse(_ageController.text);
      height = int.parse(_heightController.text);
      weight = int.parse(_weightController.text);

      if (genderController == "Male") {
        if (equationController == "Mifflin-St Jeor") {
          bmrDouble = (10 * weight) + (6.25 * height) - (5 * age) + 5;
        } else if (equationController == "Harris-Benedict") {
          bmrDouble =
              66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
        }
      } else if (genderController == "Female") {
        if (equationController == "Mifflin-St Jeor") {
          bmrDouble = (10 * weight) + (6.25 * height) - (5 * age) - 161;
        } else if (equationController == "Harris-Benedict") {
          bmrDouble =
              655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
        }
      }
      bmrTotal = (bmrDouble.round());
      if (activityController == "I am sedentary") {
        caloriesDouble = (bmrTotal * 1.2);
      } else if (activityController == "I am lightly active") {
        caloriesDouble = (bmrTotal * 1.375);
      } else if (activityController == "I am moderately active") {
        caloriesDouble = (bmrTotal * 1.55);
      } else if (activityController == "I am very active") {
        caloriesDouble = (bmrTotal * 1.725);
      } else if (activityController == "I am super active") {
        caloriesDouble = (bmrTotal * 1.9);
      }
      calories = (caloriesDouble!.round());
    });
  }

  // void _onClick() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ImperialSystem()),
  //   );
  // }
}

class BMRWidhet extends StatefulWidget {
  final ValueChanged<int> onChanged;

  BMRWidhet(this.onChanged);

  @override
  State<BMRWidhet> createState() => _BMRWidhetState();
}

class _BMRWidhetState extends State<BMRWidhet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class WorkoutPlanWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  WorkoutPlanWidget(this.onChanged);

  @override
  _WorkoutPlanWidget createState() => _WorkoutPlanWidget();
}

class _WorkoutPlanWidget extends State<WorkoutPlanWidget> {
  List<ModelAddMyPlan>? planCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper.getAllMyPlans().then((value) {
      planCategory = value;
      setState(() {});
    });

    print("plan----${planCategory!.length}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = ConstantWidget.getScreenPercentSize(context, 12);
    double height1 = ConstantWidget.getScreenPercentSize(context, 15);
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          ConstantWidget.getAppBar(context, S.of(context).workout, () {
            // Future.delayed(const Duration(milliseconds: 200), () {
            //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            // });

            widget.onChanged(0);
          }),
          Container(
            margin: EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
            child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstantWidget.getTextWidget(
                            S.of(context).createMyOwnPlan,
                            Colors.black,
                            TextAlign.start,
                            FontWeight.w600,
                            ConstantData.font18Px),
                        new SizedBox(
                          height: 12,
                        ),
                        Container(
                          color: Colors.white,
                          height: (planCategory!.length > 0) ? height1 : height,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  child: Container(
                                    width: ConstantWidget.getWidthPercentSize(
                                        context, 45),
                                    height: height1,
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: ConstantData.cellColor,
                                            borderRadius: BorderRadius.circular(
                                                ConstantWidget.getPercentSize(
                                                    height1, 10))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.black54,
                                              size:
                                                  ConstantWidget.getPercentSize(
                                                      height1, 30),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ConstantWidget.getTextWidget(
                                                S.of(context).createMyOwnPlan,
                                                Colors.black,
                                                TextAlign.start,
                                                FontWeight.w600,
                                                ConstantWidget.getPercentSize(
                                                    height1, 12)),
                                          ],
                                        )),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return AddPlan();
                                      },
                                    )).then((value) {
                                      planCategory = [];
                                      _databaseHelper
                                          .getAllMyPlans()
                                          .then((value) {
                                        planCategory = value;
                                        setState(() {});
                                      });
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: (planCategory!.length > 0)
                                    ? height1
                                    : height,
                                color: Colors.white,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: planCategory!.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    ModelAddMyPlan challengeCat =
                                        planCategory![index];
                                    return InkWell(
                                      onTap: () {
                                        print("index---$index");
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              MyWorkoutPlanIntroduction(
                                                  challengeCat),
                                        ));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: ConstantWidget
                                              .getWidthPercentSize(context, 45),
                                          height: height1,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ConstantWidget
                                                      .getPercentSize(
                                                          height1, 8))),
                                              image: DecorationImage(
                                                image: new ExactAssetImage(
                                                  ConstantData.assetImagesPath +
                                                      "complete_beginner_program.webp",
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          ConstantWidget
                                                              .getPercentSize(
                                                                  height1, 8))),
                                                  color: "#CC000000".toColor(),
                                                ),
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: ConstantWidget
                                                          .getPercentSize(
                                                              height1, 15),
                                                    ),
                                                    onTap: () {},
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ConstantWidget
                                                          .getTextWidget(
                                                              planCategory![
                                                                      index]
                                                                  .name!,
                                                              defPrimaryColor,
                                                              TextAlign.start,
                                                              FontWeight.w600,
                                                              ConstantWidget
                                                                  .getPercentSize(
                                                                      height1,
                                                                      9.5)),
                                                      ConstantWidget
                                                          .getTextWidget(
                                                              "Beginner",
                                                              Colors.white,
                                                              TextAlign.start,
                                                              FontWeight.w600,
                                                              ConstantWidget
                                                                  .getPercentSize(
                                                                      height1,
                                                                      8.5)),
                                                      ConstantWidget
                                                          .getTextWidget(
                                                              planCategory![
                                                                      index]
                                                                  .noWeek
                                                                  .toString(),
                                                              Colors.white,
                                                              TextAlign.start,
                                                              FontWeight.w600,
                                                              ConstantWidget
                                                                  .getPercentSize(
                                                                      height1,
                                                                      8.5)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        new SizedBox(
                          height: 12,
                        ),
                        FutureBuilder<List<ModelPlanCategory>>(
                          future: _databaseHelper.getAllWorkoutPlans(context),
                          builder: (context, snapshot) {
                            print("dataget1==${snapshot.data}");
                            if (snapshot.hasData) {
                              List<ModelPlanCategory>? categoryList =
                                  snapshot.data;
                              return Container(
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: categoryList!.length,
                                  itemBuilder: (context, index) {
                                    ModelPlanCategory planCategory =
                                        categoryList[index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: getSmallBoldText(
                                                    planCategory.name!,
                                                    Colors.black),
                                                flex: 1,
                                              ),
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    getSmallBoldText(
                                                        S.of(context).seeAll,
                                                        primaryColor),
                                                    Icon(
                                                      Icons.navigate_next,
                                                      color: primaryColor,
                                                      size: ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 3),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MoreWorkoutPlanList(
                                                            planCategory),
                                                  ));
                                                },
                                              )
                                            ],
                                          ),
                                          FutureBuilder<
                                              List<ModelPlanSubCategory>>(
                                            future: _databaseHelper
                                                .getPlanSubCategory(
                                                    planCategory.id!, context),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                List<ModelPlanSubCategory>?
                                                    subCategoryList =
                                                    snapshot.data;

                                                double height = SizeConfig
                                                        .safeBlockVertical! *
                                                    23;
                                                double width = SizeConfig
                                                        .safeBlockHorizontal! *
                                                    65;

                                                double sWidth = width / 2;
                                                double iconSize = ConstantWidget
                                                    .getPercentSize(sWidth, 10);
                                                return Container(
                                                  height: height,
                                                  child: ListView.builder(
                                                    itemCount:
                                                        subCategoryList!.length,
                                                    primary: false,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      ModelPlanSubCategory
                                                          subCategory =
                                                          subCategoryList[
                                                              index];

                                                      double radius =
                                                          ConstantWidget
                                                              .getPercentSize(
                                                                  height, 8);
                                                      return InkWell(
                                                        child: Container(
                                                          // color: Colors.red,
                                                          width: SizeConfig
                                                                  .safeBlockHorizontal! *
                                                              65,
                                                          height: height,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),

                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        radius),
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    ConstantData
                                                                            .assetImagesPath +
                                                                        subCategory
                                                                            .image!,
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              radius)),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              Colors.black54,
                                                                              Colors.black87,
                                                                            ],
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end:
                                                                                Alignment.bottomCenter,
                                                                          )),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: ConstantWidget.getWidthPercentSize(
                                                                            context,
                                                                            3),
                                                                        vertical: ConstantWidget.getWidthPercentSize(
                                                                            context,
                                                                            1)),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topRight: Radius.circular(
                                                                                radius)),
                                                                        color:
                                                                            defPrimaryColor),
                                                                    child: ConstantWidget.getTextWidget(
                                                                        "Free",
                                                                        Colors
                                                                            .white,
                                                                        TextAlign
                                                                            .center,
                                                                        FontWeight
                                                                            .w700,
                                                                        ConstantWidget.getPercentSize(
                                                                            height,
                                                                            6)),
                                                                  ),
                                                                ),
                                                                // Positioned.fill(
                                                                //     child: Align(
                                                                //   alignment: Alignment
                                                                //       .bottomRight,
                                                                //   child: Wrap(
                                                                //     children: [
                                                                //       Container(
                                                                //         width: double
                                                                //             .infinity,
                                                                //         padding:
                                                                //             EdgeInsets
                                                                //                 .all(
                                                                //                     8),
                                                                //         decoration: BoxDecoration(
                                                                //             color: Colors
                                                                //                 .black45,
                                                                //             borderRadius: BorderRadius.only(
                                                                //                 bottomRight: Radius.circular(
                                                                //                     radius),
                                                                //                 bottomLeft:
                                                                //                     Radius.circular(radius))),
                                                                //         child: Column(
                                                                //           mainAxisAlignment:
                                                                //               MainAxisAlignment
                                                                //                   .end,
                                                                //           crossAxisAlignment:
                                                                //               CrossAxisAlignment
                                                                //                   .center,
                                                                //           children: [
                                                                //             ConstantWidget.getTextWidget(
                                                                //                 "Total Fat Blaster Workout",
                                                                //                 defPrimaryColor,
                                                                //                 TextAlign
                                                                //                     .center,
                                                                //                 FontWeight
                                                                //                     .bold,
                                                                //                 ConstantWidget.getPercentSize(
                                                                //                     height,
                                                                //                     8)),
                                                                //             SizedBox(
                                                                //                 height: ConstantWidget.getPercentSize(
                                                                //                     height,
                                                                //                     2)),
                                                                //             Row(
                                                                //               crossAxisAlignment:
                                                                //                   CrossAxisAlignment.center,
                                                                //               children: [
                                                                //                 Expanded(
                                                                //                   child:
                                                                //                       Row(
                                                                //                     crossAxisAlignment: CrossAxisAlignment.center,
                                                                //                     children: [
                                                                //                       Image.asset(
                                                                //                         ConstantData.assetImagesPath + "dumbbell.png",
                                                                //                         height: iconSize,
                                                                //                         width: iconSize,
                                                                //                         color: Colors.white,
                                                                //                       ),
                                                                //                       SizedBox(width: ConstantWidget.getPercentSize(sWidth, 5)),
                                                                //                       ConstantWidget.getTextWidget("Beginner", Colors.white, TextAlign.start, FontWeight.w600, ConstantWidget.getPercentSize(sWidth, 8)),
                                                                //                     ],
                                                                //                   ),
                                                                //                 ),
                                                                //                 Expanded(
                                                                //                   child:
                                                                //                       Row(
                                                                //                     crossAxisAlignment: CrossAxisAlignment.center,
                                                                //                     mainAxisAlignment: MainAxisAlignment.end,
                                                                //                     children: [
                                                                //                       Image.asset(
                                                                //                         ConstantData.assetImagesPath + "calendar.png",
                                                                //                         height: iconSize,
                                                                //                         width: iconSize,
                                                                //                         color: Colors.white,
                                                                //                       ),
                                                                //                       SizedBox(width: ConstantWidget.getPercentSize(sWidth, 5)),
                                                                //                       ConstantWidget.getTextWidget("4 Week", Colors.white, TextAlign.start, FontWeight.w600, ConstantWidget.getPercentSize(sWidth, 8)),
                                                                //                     ],
                                                                //                   ),
                                                                //                 ),
                                                                //               ],
                                                                //             )
                                                                //           ],
                                                                //         ),
                                                                //       )
                                                                //     ],
                                                                //   ),
                                                                // )),

                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getTextWidgetWithFont(
                                                                          "Total Fat Blaster Workout"
                                                                              .toUpperCase(),
                                                                          Colors
                                                                              .white,
                                                                          TextAlign
                                                                              .start,
                                                                          FontWeight
                                                                              .w600,
                                                                          ConstantWidget.getPercentSize(
                                                                              height,
                                                                              6),
                                                                          meriendaOneFont),
                                                                      SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image.asset(
                                                                                ConstantData.assetImagesPath + "dumbbell.png",
                                                                                height: iconSize,
                                                                                width: iconSize,
                                                                                color: Colors.white,
                                                                              ),
                                                                              SizedBox(width: ConstantWidget.getPercentSize(sWidth, 5)),
                                                                              ConstantWidget.getTextWidget("Beginner", Colors.white, TextAlign.start, FontWeight.w100, ConstantWidget.getPercentSize(sWidth, 8)),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Image.asset(
                                                                                ConstantData.assetImagesPath + "calendar.png",
                                                                                height: iconSize,
                                                                                width: iconSize,
                                                                                color: Colors.white,
                                                                              ),
                                                                              SizedBox(width: ConstantWidget.getPercentSize(sWidth, 5)),
                                                                              ConstantWidget.getTextWidget("4 Week", Colors.white, TextAlign.start, FontWeight.w100, ConstantWidget.getPercentSize(sWidth, 8)),
                                                                            ],
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
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                WorkoutPlanIntroduction(
                                                                    subCategory,
                                                                    planCategory),
                                                          ));
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    )),
                Container(
                  height: ConstantWidget.getScreenPercentSize(context, 6),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  ExerciseWidget(this.onChanged);

  @override
  _ExerciseWidget createState() => _ExerciseWidget();
}

class ChallengeWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  ChallengeWidget(this.onChanged);

  @override
  _ChallengeWidget createState() => _ChallengeWidget();
}

DatabaseHelper _databaseHelper = DatabaseHelper.instance;
List<ModelExerciseCategory>? _list;

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseCategoryList(category, list),
                ),
              );
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

class _ExerciseWidget extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onChanged(0);

        return false;
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: mPage(context, widget.onChanged),
      ),
    );
  }

  mPage(BuildContext context, var onChanged) {
    Widget widget;
    widget = Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          ConstantWidget.getAppBar(context, S.of(context).exercise, () {
            onChanged(0);
          }),
          Container(
            margin: EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
            child: ListView(
              children: [
                Container(
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Color color = "#F6F6F6".toColor();

                              if (index % 3 == 0) {
                                color = "#EEF8FE".toColor();
                              } else if (index % 3 == 1) {
                                color = "#FFF1E2".toColor();
                              }

                              ModelExerciseCategory maincat = _list![index];
                              return exerciseCatItem(maincat, context, color,
                                  _list!, maincat.imageName!);
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
                )),
                Container(
                  height: ConstantWidget.getScreenPercentSize(context, 6),
                )
              ],
            ),
          )
        ],
      ),
    );
    return widget;
  }
}

class _ChallengeWidget extends State<ChallengeWidget> {
  List<HealthModel> healthList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      healthList = DataFile.getHealthList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        widget.onChanged(0);

        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              ConstantWidget.getAppBar(context, S.of(context).naturalTips, () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HomeScreen(2),
                //     ));

                widget.onChanged(0);
              }),
              Container(
                margin:
                    EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                child: ListView(
                  children: [
                    Container(
                      child: Container(
                          // child: FutureBuilder<List<ModelChallengeMainCat>>(
                          //   future: _databaseHelper.getAllChallengeCatList(context),
                          //   builder: (context, snapshot) {
                          //     List<ModelChallengeMainCat> _list = [];
                          //     if (snapshot.hasData) {
                          //       _list = snapshot.data!;
                          //     }
                          //     return snapshot.hasData
                          //         ? Container(
                          //             child: ListView.builder(
                          //               itemCount: _list.length,
                          //               primary: false,
                          //               scrollDirection: Axis.vertical,
                          //               itemBuilder: (context, index) {
                          //                 ModelChallengeMainCat subCategory =
                          //                     _list[index];
                          //
                          //                 double radius =
                          //                     ConstantWidget.getPercentSize(height, 8);
                          //                 String name = "Build Muscles Challenge";
                          //
                          //                 if (index == 1) {
                          //                   name = "Challenge For Beginner";
                          //                 }
                          //                 return Container(
                          //                   color: Colors.white,
                          //                   width: SizeConfig.safeBlockHorizontal! * 65,
                          //                   margin: EdgeInsets.symmetric(
                          //                       horizontal:
                          //                           ConstantWidget.getScreenPercentSize(
                          //                               context, 2)),
                          //                   child: Column(
                          //                     mainAxisAlignment: MainAxisAlignment.start,
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Visibility(
                          //                         visible: (index == 0 || index == 1),
                          //                         child: Padding(
                          //                           padding: EdgeInsets.only(
                          //                               bottom: 10,
                          //                               top: (index > 0) ? 10 : 0),
                          //                           child: ConstantWidget.getTextWidget(
                          //                               name.toUpperCase(),
                          //                               Colors.black,
                          //                               TextAlign.end,
                          //                               FontWeight.w600,
                          //                               ConstantWidget.getPercentSize(
                          //                                   height, 8.3)),
                          //                         ),
                          //                       ),
                          //                       InkWell(
                          //                         child: Container(
                          //                           height: height,
                          //                           // color: Colors.red,
                          //                           margin: EdgeInsets.symmetric(
                          //                               vertical: ConstantWidget
                          //                                   .getScreenPercentSize(
                          //                                       context, 1.2)),
                          //                           child: Stack(
                          //                             children: [
                          //                               ClipRRect(
                          //                                 borderRadius: BorderRadius.all(
                          //                                   Radius.circular(radius),
                          //                                 ),
                          //                                 child: Image.asset(
                          //                                   ConstantData.assetImagesPath +
                          //                                       subCategory.img!,
                          //                                   width: double.infinity,
                          //                                   height: double.infinity,
                          //                                   fit: BoxFit.cover,
                          //                                 ),
                          //                               ),
                          //                               Container(
                          //                                 height: double.infinity,
                          //                                 width: double.infinity,
                          //                                 decoration: BoxDecoration(
                          //                                     borderRadius:
                          //                                         BorderRadius.all(
                          //                                             Radius.circular(
                          //                                                 radius)),
                          //                                     gradient: LinearGradient(
                          //                                       colors: [
                          //                                         Colors.black54,
                          //                                         Colors.black45
                          //                                       ],
                          //                                       begin:
                          //                                           Alignment.topCenter,
                          //                                       end: Alignment
                          //                                           .bottomCenter,
                          //                                     )),
                          //                               ),
                          //                               Positioned.fill(
                          //                                 child: Align(
                          //                                   alignment: Alignment.topRight,
                          //                                   child: Container(
                          //                                     // height: ConstantWidget
                          //                                     //     .getPercentSize(
                          //                                     //         height, 10),
                          //                                     // width: ConstantWidget
                          //                                     //     .getWidthPercentSize(
                          //                                     //         context, 10),
                          //
                          //                                     padding: EdgeInsets.symmetric(
                          //                                         horizontal: ConstantWidget
                          //                                             .getWidthPercentSize(
                          //                                                 context, 3),
                          //                                         vertical: ConstantWidget
                          //                                             .getWidthPercentSize(
                          //                                                 context, 1)),
                          //                                     decoration: BoxDecoration(
                          //                                         borderRadius:
                          //                                             BorderRadius.only(
                          //                                                 topRight: Radius
                          //                                                     .circular(
                          //                                                         radius)),
                          //                                         color: defPrimaryColor),
                          //
                          //                                     child: ConstantWidget
                          //                                         .getTextWidget(
                          //                                             "Free",
                          //                                             Colors.white,
                          //                                             TextAlign.center,
                          //                                             FontWeight.w700,
                          //                                             ConstantWidget
                          //                                                 .getPercentSize(
                          //                                                     height, 6)),
                          //                                     // margin: EdgeInsets.only(
                          //                                     //     top: ConstantWidget.getPercentSize(
                          //                                     //         height,
                          //                                     //         10)),
                          //                                     // child: Stack(
                          //                                     //   children: [
                          //                                     //     Positioned
                          //                                     //         .fill(
                          //                                     //       child:
                          //                                     //       Align(
                          //                                     //         alignment:
                          //                                     //         Alignment.topRight,
                          //                                     //         child:
                          //                                     //         Container(
                          //                                     //           padding:
                          //                                     //           EdgeInsets.only(left: 5),
                          //                                     //           width:
                          //                                     //           double.infinity,
                          //                                     //           height:
                          //                                     //           ConstantWidget.getPercentSize(height, 10),
                          //                                     //           // decoration: BoxDecoration(
                          //                                     //           //     image: new DecorationImage(
                          //                                     //           //       image: new AssetImage(ConstantData.assetImagesPath + "bg_shape.png"),
                          //                                     //           //       fit: BoxFit.fill,
                          //                                     //           //       colorFilter: new ColorFilter.mode(defPrimaryColor, BlendMode.srcIn),
                          //                                     //           //     )),
                          //                                     //           child:
                          //                                     //           Center(
                          //                                     //             child: ConstantWidget.getTextWidget("Free", Colors.white, TextAlign.center, FontWeight.w600, ConstantWidget.getPercentSize(ConstantWidget.getPercentSize(height, 10), 45)),
                          //                                     //           ),
                          //                                     //         ),
                          //                                     //       ),
                          //                                     //     )
                          //                                     //   ],
                          //                                     // )
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                               Positioned.fill(
                          //                                   child: Align(
                          //                                 alignment:
                          //                                     Alignment.bottomRight,
                          //                                 child: Wrap(
                          //                                   children: [
                          //                                     Container(
                          //                                       width: double.infinity,
                          //                                       padding:
                          //                                           EdgeInsets.all(8),
                          //                                       decoration: BoxDecoration(
                          //                                           color: Colors.black54,
                          //                                           borderRadius: BorderRadius.only(
                          //                                               bottomLeft: Radius
                          //                                                   .circular(
                          //                                                       radius),
                          //                                               bottomRight: Radius
                          //                                                   .circular(
                          //                                                       radius))),
                          //                                       child: Column(
                          //                                         mainAxisAlignment:
                          //                                             MainAxisAlignment
                          //                                                 .end,
                          //                                         crossAxisAlignment:
                          //                                             CrossAxisAlignment
                          //                                                 .end,
                          //                                         children: [
                          //                                           ConstantWidget.getTextWidget(
                          //                                               _list[index]
                          //                                                   .title!,
                          //                                               defPrimaryColor,
                          //                                               TextAlign.end,
                          //                                               FontWeight.bold,
                          //                                               ConstantWidget
                          //                                                   .getPercentSize(
                          //                                                       height,
                          //                                                       8)),
                          //                                           SizedBox(
                          //                                             height: 3,
                          //                                           ),
                          //                                           ConstantWidget.getCustomText(
                          //                                               _list[index]
                          //                                                   .introduction!,
                          //                                               Colors.white,
                          //                                               2,
                          //                                               TextAlign.end,
                          //                                               FontWeight.w500,
                          //                                               ConstantWidget
                          //                                                   .getPercentSize(
                          //                                                       height,
                          //                                                       6)),
                          //                                         ],
                          //                                       ),
                          //                                     )
                          //                                   ],
                          //                                 ),
                          //                               )),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         onTap: () {
                          //                           Navigator.of(context)
                          //                               .push(MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 ChallengesIntroduction(
                          //                                     _list[index]),
                          //                           ));
                          //                         },
                          //                       )
                          //                     ],
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //           )
                          //         : Center(
                          //             child: CircularProgressIndicator(),
                          //           );
                          //   },
                          // ),

                          child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: healthList.length,
                        itemBuilder: (context, index) {
                          double imgHeight =
                              ConstantWidget.getScreenPercentSize(context, 25);
                          double radius =
                              ConstantWidget.getScreenPercentSize(context, 1.5);
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HealthDetailPage(healthList[index]),
                                  ));
                            },
                            child: Card(
                              margin: EdgeInsets.all(
                                  ConstantWidget.getScreenPercentSize(
                                      context, 1.8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: imgHeight,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(radius),
                                          image: DecorationImage(
                                            image: new ExactAssetImage(
                                              ConstantData.assetImagesPath +
                                                  healthList[index].image!,
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ConstantWidget.getPercentSize(
                                              imgHeight, 85)),
                                      // margin: EdgeInsets.only(top: (height*1.7)),
                                      padding: EdgeInsets.all(
                                          ConstantWidget.getScreenPercentSize(
                                              context, 1.6)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 4)),
                                            bottomRight:
                                                Radius.circular(radius),
                                            bottomLeft:
                                                Radius.circular(radius)),
                                      ),

                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                          healthList[index]
                                                              .title!,
                                                          Colors.black,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.w300,
                                                          ConstantWidget
                                                              .getScreenPercentSize(
                                                                  context,
                                                                  1.8))),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.favorite_border,
                                                size: ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 3),
                                                color: primaryColor,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          ConstantWidget.getCustomText(
                                              healthList[index].desc!,
                                              Colors.black54,
                                              3,
                                              TextAlign.start,
                                              FontWeight.bold,
                                              ConstantWidget
                                                  .getScreenPercentSize(
                                                      context, 1.5)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ConstantWidget
                                                    .getCustomText(
                                                        healthList[index].time!,
                                                        primaryColor,
                                                        1,
                                                        TextAlign.end,
                                                        FontWeight.w500,
                                                        ConstantWidget
                                                            .getScreenPercentSize(
                                                                context, 1.5)),
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
                        },
                      )),
                    ),
                    Container(
                      height: ConstantWidget.getScreenPercentSize(context, 6),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  HomeWidget(this.onChanged);

  @override
  _HomeWidget createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget> with TickerProviderStateMixin {
  List<SliderModel> sliderList = [];
  List<ServicesModel> serviceModelList = [];
  List<ServicesModel> continueList = [];
  List<WorkoutModel> quickModelList = [];
  List<ModelPlanSubCategory> list = [];
  List<HealthModel> healthList = [];

  int index = -1;

  @override
  void dispose() {
    animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    setState(() {
      sliderList = DataFile.getSliderDetail();
      serviceModelList = DataFile.getServiceList();
      continueList = DataFile.getContinueList();
      quickModelList = DataFile.getWorkoutModelList();
      healthList = DataFile.getHealthList();

      new Future.delayed(const Duration(seconds: 1), () {
        _databaseHelper.getAllPlanSubCategory(context).then((value) {
          list = value;
          print("list----${list.length}");
          setState(() {});
        });
      });
    });
  }

  getTextStyle() {
    return TextStyle(
        fontSize: ConstantWidget.getScreenPercentSize(context, 1.8),
        color: Colors.black54,
        fontFamily: ConstantData.fontsFamily);
  }

  TextEditingController textEditingController = new TextEditingController();
  bool isSearchWidget = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sliderHeight = ConstantWidget.getScreenPercentSize(context, 35);
    double sliderHeight1 = ConstantWidget.getScreenPercentSize(context, 20);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);
    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double listHeight = ConstantWidget.getScreenPercentSize(context, 20);
    double chHeight = ConstantWidget.getScreenPercentSize(context, 27);
    double continueWorkoutHeight =
        ConstantWidget.getScreenPercentSize(context, 22);
    double listHeight1 = ConstantWidget.getScreenPercentSize(context, 23);

    double circle = ConstantWidget.getScreenPercentSize(context, 7);
    double appBarHeight = ConstantWidget.getScreenPercentSize(context, 9);

    double subRadius = ConstantWidget.getScreenPercentSize(context, 1.3);

    int interval = sliderList.length;

    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      // Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        // curve: Interval((1 /challengesList.length) * 1, 1.0,
        curve: Interval((1 / interval) * 1, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController!.forward();
    List<Widget>? imageSliders = [];
    imageSliders = sliderList
        .map((item) => Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),

              child: AnimatedBuilder(
                  animation: animationController!,
                  builder: (context, child) {
                    return FadeTransition(
                        opacity: animation,
                        child: Transform(
                            transform: Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation.value), 0.0),
                            child: InkWell(
                              onTap: () {
                                print("click--true");
                                ModelPlanCategory planCategory =
                                    new ModelPlanCategory();
                                planCategory.name = item.title;
                                planCategory.id = item.id;

                                _databaseHelper
                                    .getPlanSubCategory(
                                        planCategory.id!, context)
                                    .then((value) {
                                  if (value.length > 0) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          WorkoutPlanIntroduction(
                                              value[0], planCategory),
                                    ));
                                  }
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                left: 12, right: 12),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(

                                                    // ConstantData.assetImagesPath + item.image!,

                                                    ConstantData
                                                            .assetImagesPath +
                                                        getChallengeBackground(
                                                            sliderList.indexOf(
                                                                item))),
                                                fit: BoxFit.cover,
                                              ),
                                              // borderRadius: BorderRadius.all(
                                              //     Radius.circular(10)
                                              // ),
                                              // color: Colors.green,
                                            ),
                                            child: Image.asset(
                                              ConstantData.assetImagesPath +
                                                  item.image!,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0),
                                              child: Text(
                                                item.title!,
                                                // 'No. ${imgList.indexOf(item)} image',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      sliderHeight * 0.070,
                                                  fontFamily:
                                                      ConstantData.fontsFamily,
                                                  fontStyle: FontStyle.italic,
                                                  // fontSize: 20.0,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(7),
                                      child: getCustomText(
                                          item.subTitle!,
                                          Colors.black,
                                          2,
                                          TextAlign.start,
                                          FontWeight.normal,
                                          14)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 7, right: 7, bottom: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: getCustomText(
                                                "${6} ${S.of(context).week}",
                                                // "${item.weeks} Week",
                                                Colors.grey,
                                                1,
                                                TextAlign.start,
                                                FontWeight.normal,
                                                15),
                                          ),
                                          getCustomText(
                                              "6%",
                                              Colors.grey,
                                              1,
                                              TextAlign.start,
                                              FontWeight.normal,
                                              15)
                                        ],
                                      ))
                                ],
                              ),
                            )));
                  }),
              // margin: EdgeInsets.all(7.0),
            ))
        .toList();

    return WillPopScope(
      onWillPop: () async {
        widget.onChanged(0);

        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
              color: primaryColor,
              // color: "#E7E9FB".toColor(),
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Container(
                          height: circle,
                          width: circle,
                          margin: EdgeInsets.symmetric(
                              horizontal: ConstantWidget.getWidthPercentSize(
                                  context, 3)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: Center(
                              child: Icon(
                                Icons.account_circle_sharp,
                                color: Colors.white,
                                size: ConstantWidget.getPercentSize(circle, 50),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstantWidget.getCustomText(
                                  "User 1",
                                  Colors.black,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w500,
                                  ConstantData.font18Px),
                              ConstantWidget.getCustomText(
                                  "abc@gmail.com",
                                  Colors.black87,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w300,
                                  ConstantData.font15Px),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                                ConstantWidget.getScreenPercentSize(
                                    context, 8)))),
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).home),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).exercise),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onChanged(1);
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).workout),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onChanged(2);
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).quickWorkout),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).healthTips),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onChanged(3);
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).editProfile),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ));
                    },
                  ),
                  // ListTile(
                  //   title:
                  //       ConstantWidget.getDrawer(S.of(context).likedExercise),
                  //   onTap: () {},
                  // ),
                  // ListTile(
                  //   title:
                  //       ConstantWidget.getDrawer(S.of(context).privacyPolicy),
                  //   onTap: () {},
                  // ),
                  //
                  // ListTile(
                  //   title:
                  //   ConstantWidget.getDrawer(S.of(context).rateUs),
                  //   onTap: () {},
                  // ),
                  // ListTile(
                  //   title:
                  //       ConstantWidget.getDrawer(S.of(context).termsConditions),
                  //   onTap: (){},
                  // ),
                  // ListTile(
                  //   title: ConstantWidget.getDrawer(S.of(context).aboutUs),
                  //   onTap: () {},
                  // ),
                  // ListTile(
                  //   title: ConstantWidget.getDrawer(S.of(context).contactUs),
                  //   onTap: () {},
                  // ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).settings),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onChanged(4);
                    },
                  ),
                  ListTile(
                    title: ConstantWidget.getDrawer(S.of(context).logOut),
                    leading: Icon(
                      Icons.exit_to_app,
                      size: 28,
                      color: Colors.white,
                    ),
                    onTap: () {
                      // _buildShowStarRateDialog(context);
                    },
                  ),
                ],
              )),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: appBarHeight,
                  margin: EdgeInsets.symmetric(horizontal: defMargin),
                  child: isSearchWidget
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Image.asset(
                                ConstantData.assetImagesPath + "search.png",
                                color: ConstantData.defColor,
                                height: ConstantWidget.getPercentSize(
                                    appBarHeight, 30),
                              ),
                              onTap: () {},
                            ),
                            Expanded(
                                child: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: defMargin),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  style: getTextStyle(),
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: getTextStyle(),
                                      hintText: S.of(context).searchHere),
                                ),
                              ),
                            )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSearchWidget = false;
                                  textEditingController.text = "";
                                });
                              },
                              child: Image.asset(
                                ConstantData.assetImagesPath + "cancel.png",
                                color: ConstantData.defColor,
                                height: ConstantWidget.getPercentSize(
                                    appBarHeight, 25),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Image.asset(
                                ConstantData.assetImagesPath + "drawer.png",
                                color: ConstantData.defColor,
                                height: ConstantWidget.getPercentSize(
                                    appBarHeight, 30),
                              ),
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                            ),
                            Expanded(
                                child: Container(
                              child: Center(
                                child: ConstantWidget.getCustomTextFont(
                                    "Fitness Workout",
                                    Colors.black87,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    ConstantWidget.getPercentSize(
                                        appBarHeight, 30),
                                    meriendaOneFont),
                                // child: Image.asset(
                                //   ConstantData.assetHomeImagesPath + "logo.png",
                                //   height: ConstantWidget.getPercentSize(
                                //       appBarHeight, 45),
                                // ),
                              ),

                              // child:  ConstantWidget.getCustomText("Feelit".toUpperCase(), ConstantData.defColor, 1
                              //     ,TextAlign.center, FontWeight.bold, ConstantWidget.getPercentSize(appBarHeight, 30)),
                            )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSearchWidget = true;
                                });
                              },
                              child: Image.asset(
                                ConstantData.assetImagesPath + "search.png",
                                color: ConstantData.defColor,
                                height: ConstantWidget.getPercentSize(
                                    appBarHeight, 30),
                              ),
                            ),
                          ],
                        ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        CarouselSlider(
                            items: imageSliders,
                            options: CarouselOptions(
                                height: sliderHeight,
                                autoPlay: false,
                                reverse: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true)),

                        Padding(
                          padding: EdgeInsets.only(
                              left: defMargin,
                              right: defMargin,
                              top: defMargin),
                          child: ConstantWidget.getTextWidget(
                              "Continue Workout",
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w600,
                              ConstantWidget.getScreenPercentSize(
                                  context, 2.2)),
                        ),

                        Container(
                          height: continueWorkoutHeight,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: continueList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  width: ConstantWidget.getWidthPercentSize(
                                      context, 68),
                                  // padding:
                                  // EdgeInsets.only(bottom: (margin / 2)),
                                  margin: EdgeInsets.only(
                                    left: defMargin,
                                    top: defMargin,
                                    bottom: defMargin,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: new ExactAssetImage(
                                          ConstantData.assetImagesPath +
                                              continueList[index].image!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ConstantWidget.getPercentSize(
                                                  continueWorkoutHeight, 5))),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.3)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(ConstantWidget
                                                    .getPercentSize(
                                                        continueWorkoutHeight,
                                                        5))),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black45,
                                                Colors.black54,
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ConstantWidget.getTextWidgetWithFont(
                                                "Full body".toUpperCase(),
                                                Colors.white,
                                                TextAlign.start,
                                                FontWeight.w100,
                                                ConstantWidget.getPercentSize(
                                                    continueWorkoutHeight, 10),
                                                bebasneueFont),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            ConstantWidget.getCustomText(
                                                "30 days training challenge"
                                                    .toUpperCase(),
                                                Colors.white,
                                                1,
                                                TextAlign.left,
                                                FontWeight.w500,
                                                ConstantWidget.getPercentSize(
                                                    continueWorkoutHeight, 6)),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: new CircularPercentIndicator(
                                            radius:
                                                ConstantWidget.getPercentSize(
                                                    continueWorkoutHeight, 17),
                                            lineWidth:
                                                ConstantWidget.getPercentSize(
                                                    continueWorkoutHeight, 1.3),
                                            animation: true,
                                            percent: 0.3,
                                            center: new Text(
                                              "7%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ConstantWidget
                                                      .getPercentSize(
                                                          continueWorkoutHeight,
                                                          6),
                                                  color: Colors.white),
                                            ),
                                            footer: new Text(
                                              "",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.red,
                                          ),
                                        ),
                                      )

                                      // Row(
                                      //   children: [
                                      //     Padding(
                                      //       padding: EdgeInsets.all((margin / 1.5)),
                                      //       child: Container(
                                      //           height: ConstantWidget
                                      //               .getWidthPercentSize(
                                      //               context, 22),
                                      //           width: ConstantWidget
                                      //               .getWidthPercentSize(
                                      //               context, 22),
                                      //           decoration: BoxDecoration(
                                      //               color: Colors.white,
                                      //               borderRadius: BorderRadius.all(
                                      //                   Radius.circular(ConstantWidget
                                      //                       .getScreenPercentSize(
                                      //                       context, 1.5))),
                                      //               image: DecorationImage(
                                      //                 image: new ExactAssetImage(
                                      //                   ConstantData
                                      //                       .assetImagesPath +
                                      //                       "forearm_1.jpg",
                                      //                 ),
                                      //                 fit: BoxFit.cover,
                                      //               ))),
                                      //     ),
                                      //     Expanded(
                                      //         child: Padding(
                                      //           padding:
                                      //           EdgeInsets.only(right: (margin)),
                                      //           child: Column(
                                      //               mainAxisAlignment:
                                      //               MainAxisAlignment.center
                                      //               crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //               children: [
                                      //                 ConstantWidget.getCustomText(
                                      //                     "Full body",
                                      //                     Colors.black,
                                      //                     1,
                                      //                     TextAlign.left,
                                      //                     FontWeight.bold,
                                      //                     ConstantWidget.getPercentSize(
                                      //                         continueWorkoutHeight,
                                      //                         9)),
                                      //                 ConstantWidget.getCustomText(
                                      //                     "30 days training challenge",
                                      //                     Colors.grey,
                                      //                     1,
                                      //                     TextAlign.left,
                                      //                     FontWeight.w500,
                                      //                     ConstantWidget.getPercentSize(
                                      //                         continueWorkoutHeight,
                                      //                         7)),
                                      //                 SizedBox(
                                      //                   height: ConstantWidget
                                      //                       .getScreenPercentSize(
                                      //                       context, 1.3),
                                      //                 ),
                                      //                 Row(
                                      //                   children: [
                                      //                     Expanded(
                                      //                       child: ConstantWidget
                                      //                           .getCustomText(
                                      //                           "30 days left",
                                      //                           Colors.black,
                                      //                           1,
                                      //                           TextAlign.left,
                                      //                           FontWeight.w500,
                                      //                           ConstantWidget
                                      //                               .getPercentSize(
                                      //                               continueWorkoutHeight,
                                      //                               7)),
                                      //                     ),
                                      //                     ConstantWidget.getTextWidget(
                                      //                         "0%",
                                      //                         Colors.black,
                                      //                         TextAlign.left,
                                      //                         FontWeight.w500,
                                      //                         ConstantWidget
                                      //                             .getScreenPercentSize(
                                      //                             context, 1.2)),
                                      //                   ],
                                      //                 ),
                                      //                 SizedBox(
                                      //                   height: ConstantWidget
                                      //                       .getScreenPercentSize(
                                      //                       context, 1),
                                      //                 ),
                                      //                 LinearPercentIndicator(
                                      //                   // width: double.infinity,
                                      //                   lineHeight: ConstantWidget
                                      //                       .getPercentSize(
                                      //                       continueWorkoutHeight,
                                      //                       8),
                                      //                   center: Text(
                                      //                     "1%",
                                      //                     style: TextStyle(
                                      //                         color: Colors.transparent,
                                      //                         fontWeight:
                                      //                         FontWeight.w500),
                                      //                   ),
                                      //
                                      //                   percent: 0.05,
                                      //                   padding: EdgeInsets.symmetric(
                                      //                       horizontal: (margin / 2)),
                                      //                   progressColor: primaryColor,
                                      //                   backgroundColor:
                                      //                   Colors.grey.shade100,
                                      //                 ),
                                      //               ]),
                                      //         ))
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  ModelPlanCategory planCategory =
                                      new ModelPlanCategory();
                                  planCategory.name = sliderList[0].title;
                                  planCategory.id = sliderList[0].id;

                                  _databaseHelper
                                      .getPlanSubCategory(
                                          planCategory.id!, context)
                                      .then((value) {
                                    if (value.length > 0) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            WorkoutPlanIntroduction(
                                                value[0], planCategory),
                                      ));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(defMargin),
                          child: ConstantWidget.getTextWidget(
                              S.of(context).ourServices,
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w600,
                              ConstantWidget.getScreenPercentSize(
                                  context, 2.2)),
                        ),

                        //
                        // if (index % 4 == 0) {
                        //   color = ConstantData.color1;
                        //   image = "back_workout.png";
                        // } else if (index % 4 == 1) {
                        //   color = ConstantData.color2;
                        //   image = "leg_workout.png";
                        // } else if (index % 4 == 2) {
                        //   color = ConstantData.color3;
                        //   image = "butt_workout.png";
                        // }

                        Container(
                            height: sliderHeight1,
                            margin: EdgeInsets.only(bottom: margin),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  height: sliderHeight1),
                              items: serviceModelList.map((item) {
                                int index = serviceModelList.indexOf(item);
                                Color color = ConstantData.color4;

                                print("color----$index");
                                if (index % 4 == 0) {
                                  color = ConstantData.color1;
                                } else if (index % 4 == 1) {
                                  color = ConstantData.color2;
                                } else if (index % 4 == 2) {
                                  color = ConstantData.color3;
                                }

                                return InkWell(
                                  onTap: () {
                                    setStatusBarColor(primaryColor);
                                    ModelPlanCategory planCategory =
                                        new ModelPlanCategory();
                                    planCategory.name = item.title;
                                    planCategory.id = item.id;

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          MoreWorkoutPlanList(planCategory),
                                    ));
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2)),

                                    // margin: EdgeInsets.all(10),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height:
                                                ConstantWidget.getPercentSize(
                                                    sliderHeight1, 70),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        ConstantWidget
                                                            .getPercentSize(
                                                                sliderHeight1,
                                                                5))),
                                                image: DecorationImage(
                                                  image: new ExactAssetImage(
                                                    ConstantData
                                                            .assetImagesPath +
                                                        item.image!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: color,
                                                  // color: Colors.black87,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          ConstantWidget
                                                              .getPercentSize(
                                                                  sliderHeight1,
                                                                  5)))),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(margin),
                                          margin: EdgeInsets.only(
                                              top: margin,
                                              bottom: margin,
                                              left: margin * 1.5,
                                              right: margin),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.black45,
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(
                                          //             ConstantWidget.getPercentSize(
                                          //                 sliderHeight1, 3)))),
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ConstantWidget.getTextWidget(
                                                  item.title!.toUpperCase(),
                                                  Colors.black,
                                                  TextAlign.start,
                                                  FontWeight.w600,
                                                  ConstantWidget.getPercentSize(
                                                      sliderHeight1, 10)),
                                              ConstantWidget.getTextWidget(
                                                  item.subTitle!.toUpperCase(),
                                                  Colors.black,
                                                  TextAlign.start,
                                                  FontWeight.bold,
                                                  ConstantWidget.getPercentSize(
                                                      sliderHeight1, 12)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Image.asset(
                                              ConstantData.assetImagesPath +
                                                  "hips.png",
                                              width: ConstantWidget
                                                  .getWidthPercentSize(
                                                      context, 45),
                                              height: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),
                        getRowWidget(S.of(context).quickWorkout, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoreWorkoutList(
                                    quickModelList, S.of(context).quickWorkout),
                              ));
                        }),
                        Container(
                          height: listHeight,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: quickModelList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setStatusBarColor(primaryColor);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => QuickWorkoutList(
                                        quickModelList[index].title!,
                                        quickModelList[index]),
                                  ));
                                },
                                // child: Container(
                                //   height: listHeight,
                                //   width: ConstantWidget.getWidthPercentSize(
                                //       context, 65),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(allRadius)),
                                //     color: Colors.white,
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey,
                                //         offset: Offset(0.0, 1.0), //(x,y)
                                //         blurRadius: 2.0,
                                //       ),
                                //     ],
                                //     image: DecorationImage(
                                //       image: new ExactAssetImage(
                                //         ConstantData.assetImagesPath +
                                //             quickModelList[index].image!,
                                //       ),
                                //       fit: BoxFit.fill,
                                //     ),
                                //   ),
                                //   margin: EdgeInsets.only(
                                //     left: defMargin,
                                //     bottom: (defMargin / 2),
                                //   ),
                                //   child: Column(
                                //     children: [
                                //       new Spacer(),
                                //       Container(
                                //         padding: EdgeInsets.all(8),
                                //         decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.only(
                                //               bottomRight:
                                //                   Radius.circular(allRadius),
                                //               bottomLeft:
                                //                   Radius.circular(allRadius)),
                                //           color: Colors.black45,
                                //         ),
                                //         child: Center(
                                //           child: ConstantWidget.getCustomText(
                                //               quickModelList[index].title!,
                                //               Colors.white,
                                //               1,
                                //               TextAlign.center,
                                //               FontWeight.w500,
                                //               ConstantWidget.getPercentSize(
                                //                   listHeight, 8)),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),

                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: defMargin, bottom: (defMargin / 2)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular((subRadius))),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: ConstantWidget
                                              .getWidthPercentSize(context, 65),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    (subRadius)),
                                                topLeft: Radius.circular(
                                                    (subRadius))),
                                            image: DecorationImage(
                                              image: new ExactAssetImage(
                                                ConstantData.assetImagesPath +
                                                    quickModelList[index]
                                                        .image!,
                                              ),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        margin:
                                            EdgeInsets.only(left: defMargin),
                                        child: ConstantWidget.getCustomText(
                                            quickModelList[index].title!,
                                            Colors.black87,
                                            1,
                                            TextAlign.center,
                                            FontWeight.w500,
                                            ConstantWidget.getPercentSize(
                                                listHeight, 8)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        getRowWidget(S.of(context).featuredWorkout, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(1),
                              ));
                        }),
                        Container(
                          height: listHeight1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setStatusBarColor(primaryColor);
                                  _databaseHelper
                                      .getWorkoutPlanById(
                                          list[index].catId!, context)
                                      .then((value) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          WorkoutPlanIntroduction(
                                              list[index], value),
                                    ));
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: defMargin, bottom: (defMargin / 2)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular((subRadius))),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: ConstantWidget
                                              .getWidthPercentSize(context, 65),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    (subRadius)),
                                                topLeft: Radius.circular(
                                                    (subRadius))),
                                            image: DecorationImage(
                                              image: new ExactAssetImage(
                                                ConstantData.assetImagesPath +
                                                    list[index].image!,
                                              ),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        margin:
                                            EdgeInsets.only(left: defMargin),
                                        child: ConstantWidget.getCustomText(
                                            list[index].name!,
                                            Colors.black87,
                                            1,
                                            TextAlign.center,
                                            FontWeight.w500,
                                            ConstantWidget.getPercentSize(
                                                listHeight, 8)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        getRowWidget(S.of(context).challenges, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengesList(),
                              ));
                        }),

                        FutureBuilder<List<ModelChallengeMainCat>>(
                          future:
                              _databaseHelper.getAllChallengeCatList(context),
                          builder: (context, snapshot) {
                            List<ModelChallengeMainCat> _list = [];
                            if (snapshot.hasData) {
                              _list = snapshot.data!;
                            }
                            return snapshot.hasData
                                ? Container(
                                    height: chHeight,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          (_list.length) > 2 ? 2 : _list.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              setStatusBarColor(primaryColor);
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    ChallengesIntroduction(
                                                        _list[index]),
                                              ));
                                            },
                                            // child: Container(
                                            //   height: listHeight,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular((subRadius))),
                                            //     color: Colors.white,
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //         color: Colors.grey,
                                            //         offset:
                                            //             Offset(0.0, 1.0), //(x,y)
                                            //         blurRadius: 2.0,
                                            //       ),
                                            //     ],
                                            //     image: DecorationImage(
                                            //       image: new ExactAssetImage(
                                            //         ConstantData.assetImagesPath +
                                            //             _list[index].img!,
                                            //       ),
                                            //       fit: BoxFit.fill,
                                            //     ),
                                            //   ),
                                            //   width: ConstantWidget
                                            //       .getWidthPercentSize(
                                            //           context, 65),
                                            //   margin: EdgeInsets.only(
                                            //       left: defMargin,
                                            //       bottom: (defMargin / 2)),
                                            //   child: Column(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.start,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       new Spacer(),
                                            //       Container(
                                            //         width: double.infinity,
                                            //         padding: EdgeInsets.all(8),
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.black87,
                                            //           borderRadius:
                                            //               BorderRadius.only(
                                            //                   bottomLeft:
                                            //                       Radius.circular(
                                            //                           (subRadius)),
                                            //                   bottomRight:
                                            //                       Radius.circular(
                                            //                           (subRadius))),
                                            //         ),
                                            //         child: Column(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment.start,
                                            //           crossAxisAlignment:
                                            //               CrossAxisAlignment
                                            //                   .start,
                                            //           children: [
                                            //             ConstantWidget
                                            //                 .getCustomText(
                                            //               _list[index].title!,
                                            //               Colors.white,
                                            //               1,
                                            //               TextAlign.start,
                                            //               FontWeight.w500,
                                            //               ConstantWidget
                                            //                   .getPercentSize(
                                            //                       listHeight, 8),
                                            //             ),
                                            //             // SizedBox(
                                            //             //   height: 3,
                                            //             // ),
                                            //             ConstantWidget
                                            //                 .getCustomText(
                                            //               _list[index]
                                            //                   .introduction!,
                                            //               Colors.white,
                                            //               1,
                                            //               TextAlign.start,
                                            //               FontWeight.w500,
                                            //               ConstantWidget
                                            //                   .getPercentSize(
                                            //                       listHeight, 6),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),

                                            child: Container(
                                              height: chHeight,
                                              width: ConstantWidget
                                                  .getWidthPercentSize(
                                                      context, 65),
                                              margin: EdgeInsets.only(
                                                  left: defMargin,
                                                  bottom: (defMargin / 2)),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        (subRadius))),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                        0.0, 1.0), //(x,y)
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: ConstantWidget
                                                          .getWidthPercentSize(
                                                              context, 65),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    (subRadius)),
                                                            topLeft:
                                                                Radius.circular(
                                                                    (subRadius))),
                                                        image: DecorationImage(
                                                          image:
                                                              new ExactAssetImage(
                                                            ConstantData
                                                                    .assetImagesPath +
                                                                _list[index]
                                                                    .img!,
                                                          ),
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    margin: EdgeInsets.only(
                                                        left: defMargin),
                                                    child: ConstantWidget
                                                        .getCustomText(
                                                            _list[index].title!,
                                                            Colors.black87,
                                                            1,
                                                            TextAlign.center,
                                                            FontWeight.w600,
                                                            ConstantWidget
                                                                .getPercentSize(
                                                                    listHeight,
                                                                    8)),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 8),
                                                    margin: EdgeInsets.only(
                                                        left: defMargin,
                                                        right: defMargin),
                                                    child: ConstantWidget
                                                        .getCustomText(
                                                            _list[index]
                                                                .introduction!,
                                                            Colors.black87,
                                                            2,
                                                            TextAlign.start,
                                                            FontWeight.w300,
                                                            ConstantWidget
                                                                .getPercentSize(
                                                                    listHeight,
                                                                    8)),
                                                  )
                                                ],
                                              ),
                                            ));
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),

//                         getRowWidget(S.of(context).exercise, () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => HomeScreen(0),
//                               ));
//                         }),
//                         Container(
//                             child: FutureBuilder<List<ModelExerciseCategory>>(
//                           future: _databaseHelper.getAllSubCatList(context),
//                           builder: (context, snapshot) {
//                             _list = [];
//                             if (snapshot.hasData) {
//                               _list = snapshot.data;
//                             }
//
//                             print("_list----${_list!.length}");
//                             return snapshot.hasData
//                                 ? Container(
//                                     height: height,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: _list!.length,
//                                       // itemCount:(_list!.length > 2) ? 2 :_list!.length,
//                                       itemBuilder: (context, index) {
//                                         Color color = ConstantData.color4;
//                                         String image = "stamina_core_3.png";
//
//                                         if (index % 4 == 0) {
//                                           color = ConstantData.color1;
//                                         } else if (index % 4 == 1) {
//                                           color = ConstantData.color2;
//                                         } else if (index % 4 == 2) {
//                                           color = ConstantData.color3;
//                                         }
//
//                                         double subHeight =
//                                             ConstantWidget.getPercentSize(
//                                                 height, 60);
//                                         double remainHeight =
//                                             height - subHeight;
//                                         ModelExerciseCategory maincat =
//                                             _list![index];
//
//                                         return Container(
//                                           height: height,
//                                           width: ConstantWidget
//                                               .getWidthPercentSize(context, 60),
//                                           margin:
//                                               EdgeInsets.only(left: defMargin),
//                                           child: Container(
//                                               height: height,
//                                               width: double.infinity,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   setStatusBarColor(
//                                                       primaryColor);
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           ExerciseCategoryList(
//                                                               maincat, _list!),
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: Stack(
//                                                   children: [
//                                                     Align(
//                                                       alignment: Alignment
//                                                           .bottomCenter,
//                                                       child: Container(
//                                                         height: subHeight,
//                                                         width: double.infinity,
//                                                         child: Card(
//                                                           // color: Colors.white,
//                                                           color: color,
//                                                           elevation: 1.3,
//                                                           shape:
//                                                               RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .all(
//                                                             Radius.circular(
//                                                                 ConstantWidget
//                                                                     .getPercentSize(
//                                                                         subHeight,
//                                                                         8)),
//                                                           )),
//                                                           child: Container(
//                                                             padding: EdgeInsets
//                                                                 .all(ConstantWidget
//                                                                     .getPercentSize(
//                                                                         remainHeight,
//                                                                         15)),
//                                                             child: Row(
//                                                               children: [
//                                                                 Expanded(
//                                                                   child: Column(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .center,
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       ConstantWidget.getTextWidget(
//                                                                           maincat
//                                                                               .categoryName!,
//                                                                           Colors
//                                                                               .black,
//                                                                           TextAlign
//                                                                               .start,
//                                                                           FontWeight
//                                                                               .bold,
//                                                                           ConstantWidget.getPercentSize(
//                                                                               remainHeight,
//                                                                               22)),
//                                                                       SizedBox(
//                                                                         height:
//                                                                             3,
//                                                                       ),
//                                                                       ConstantWidget.getTextWidget(
//                                                                           "10 ${S.of(context).exercise}",
//                                                                           Colors
//                                                                               .black,
//                                                                           TextAlign
//                                                                               .start,
//                                                                           FontWeight
//                                                                               .w400,
//                                                                           ConstantWidget.getPercentSize(
//                                                                               remainHeight,
//                                                                               18)),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           right: ConstantWidget
//                                                               .getWidthPercentSize(
//                                                                   context, 5),
//                                                           bottom: 5),
//                                                       child: Align(
//                                                         alignment: Alignment
//                                                             .bottomRight,
//                                                         child: ClipRRect(
//                                                           borderRadius: BorderRadius.only(
//                                                               topLeft: Radius
//                                                                   .circular(
//                                                                       radius),
//                                                               bottomLeft: Radius
//                                                                   .circular(
//                                                                       radius)),
//                                                           child: Image.asset(
//                                                             ConstantData
//                                                                     .assetImagesPath +
//                                                                 image,
//                                                             fit: BoxFit.cover,
//                                                             width: ConstantWidget
//                                                                 .getWidthPercentSize(
//                                                                     context,
//                                                                     20),
//                                                             height:
//                                                                 double.infinity,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )),
//                                         );
//                                       },
//                                     ),
//                                   )
//
// // ?Container()
//
//                                 : Center(
//                                     child: CircularProgressIndicator(),
//                                   );
//                           },
//                         ))

                        Container(
                          height:
                              ConstantWidget.getScreenPercentSize(context, 6),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  getRowWidget(String s, Function function) {
    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);

    return Padding(
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          Expanded(
            child: ConstantWidget.getTextWidget(
                s,
                Colors.black,
                TextAlign.start,
                FontWeight.w600,
                ConstantWidget.getScreenPercentSize(context, 2.2)),
          ),
          InkWell(
            child: Row(
              children: [
                getSmallBoldText(S.of(context).seeAll, primaryColor),
                Icon(
                  Icons.navigate_next,
                  color: primaryColor,
                  size: ConstantWidget.getScreenPercentSize(context, 3),
                )
              ],
            ),
            onTap: () {
              setStatusBarColor(primaryColor);
              function();
            },
          )
        ],
      ),
    );
  }
}
