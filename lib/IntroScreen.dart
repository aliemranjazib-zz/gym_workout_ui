import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SignUpPage.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/PrefData.dart';
import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/slide_object.dart';
// import 'package:intro_slider/dot_animation_enum.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class LangDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LangDemoState();
}

class _LangDemoState extends State<LangDemo> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var matApp = new MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ConstantData.themeData,
        home: IntroScreen());
    return matApp;
  }
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  Function? goToTab;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    slides.add(
      new Slide(
          title: S.of(context).exercises,
          styleTitle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: ConstantData.fontsFamily),
          // fontFamily: 'RobotoMono'),
          description: S.of(context).slider_desc1,
          styleDescription: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: ConstantData.fontsFamily),
          pathImage: ConstantData.assetHomeImagesPath + "img_Group.png",
          backgroundColor: Colors.white),
    );
    slides.add(
      new Slide(
          maxLineTitle: 2,
          title: S.of(context).keepEyeOnHealthTracking,
          styleTitle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: ConstantData.fontsFamily),
          // fontFamily: 'RobotoMono'),
          description: S.of(context).slider_desc2,
          styleDescription: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: ConstantData.fontsFamily),
          pathImage: ConstantData.assetHomeImagesPath + "img_Group2.png",
          backgroundColor: Colors.white),
    );
    slides.add(
      new Slide(
          title: S.of(context).checkYourProgress,
          styleTitle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: ConstantData.fontsFamily),
          // fontFamily: 'RobotoMono'),
          description: S.of(context).slider_desc3,
          styleDescription: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: ConstantData.fontsFamily),
          pathImage: ConstantData.assetHomeImagesPath + "img_group3.png",
          backgroundColor: Colors.white),
    );

    super.didChangeDependencies();
  }

  void onDonePress() {
    print("clcik===true");
    // Back to the first tab
    // this.goToTab(0);

    PrefData.setIsIntro(false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Center(
      child: Icon(
        Icons.navigate_next,
        color: Color(0xffffcc5c),
        size: 35.0,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
    // return CupertinoButton(
    //   child: Text('Button'),
    //   // onPressed: () { /** */ },
    // );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: SizeConfig.safeBlockVertical! * 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        currentSlide.title!,
                        style: currentSlide.styleTitle,
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                    ),
                    Container(
                      child: Text(
                        currentSlide.description!,
                        style: currentSlide.styleDescription,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      margin: EdgeInsets.all(20.0),
                    )
                  ],
                ),
              ),
              Image.asset(
                currentSlide.pathImage!,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
                // )
              ),

              // Expanded(
              //   // child: Center(
              //       child: Image.asset(
              //     currentSlide.pathImage,
              //     width: 200.0,
              //     height: 200.0,
              //     fit: BoxFit.contain,
              //   // )
              // ),
              //   flex: 1,
              // ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return MaterialApp(
    //   localizationsDelegates: [
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     S.delegate
    //   ],
    //   supportedLocales: S.delegate.supportedLocales,
    //   home: new IntroSlider(
    //     // List slides
    //     slides: this.slides,
    //
    //     // // Skip button
    //     // renderSkipBtn: this.renderSkipBtn(),
    //     // colorSkipBtn: Color(0x33ffcc5c),
    //     // highlightColorSkipBtn: Color(0xffffcc5c),
    //     // isShowNextBtn: false,
    //     //
    //     // // Next button
    //     // renderNextBtn: this.renderNextBtn(),
    //     //
    //     // // Done button
    //     renderDoneBtn: this.renderDoneBtn(),
    //     onDonePress: this.onDonePress,
    //     // colorDoneBtn: Color(0x33ffcc5c),
    //     // highlightColorDoneBtn: Color(0xffffcc5c),
    //     //
    //     // // Dot indicator
    //     // colorDot: Color(0xffffcc5c),
    //     // sizeDot: 13.0,
    //     // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
    //
    //     // Tabs
    //     listCustomTabs: this.renderListCustomTabs(),
    //     backgroundColorAllSlides: Colors.white,
    //     refFuncGoToTab: (refFunc) {
    //       this.goToTab = refFunc;
    //     },
    //
    //     // Show or hide status bar
    //     shouldHideStatusBar: true,
    //
    //     // On tab change completed
    //     onTabChangeCompleted: this.onTabChangeCompleted,
    //   ),
    // );

    return new IntroSlider(
      slides: this.slides,
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: onDonePress,
      colorActiveDot: Color(0xffffcc5c),
      // colorDoneBtn: Color(0x33ffcc5c),
      // highlightColorDoneBtn: Color(0xffffcc5c),

      // Dot indicator
      colorDot: Color(0x33ffcc5c),
      sizeDot: 7.0,
      // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
    );

    // return new IntroSlider(
    //   // List slides
    //   slides: this.slides,
    //
    //   // // Skip button
    //   // renderSkipBtn: this.renderSkipBtn(),
    //   // colorSkipBtn: Color(0x33ffcc5c),
    //   // highlightColorSkipBtn: Color(0xffffcc5c),
    //   // isShowNextBtn: false,
    //   //
    //   // // Next button
    //   // renderNextBtn: this.renderNextBtn(),
    //   //
    //   // // Done button
    //   renderDoneBtn: this.renderDoneBtn(),
    //   onDonePress: this.onDonePress,
    //   // colorDoneBtn: Color(0x33ffcc5c),
    //   // highlightColorDoneBtn: Color(0xffffcc5c),
    //   //
    //   // // Dot indicator
    //   // colorDot: Color(0xffffcc5c),
    //   // sizeDot: 13.0,
    //   // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
    //
    //   // Tabs
    //   listCustomTabs: this.renderListCustomTabs(),
    //   backgroundColorAllSlides: Colors.white,
    //   refFuncGoToTab: (refFunc) {
    //     this.goToTab = refFunc;
    //   },
    //
    //   // Show or hide status bar
    //   shouldHideStatusBar: true,
    //
    //   // On tab change completed
    //   onTabChangeCompleted: this.onTabChangeCompleted,
    // );
  }
}
