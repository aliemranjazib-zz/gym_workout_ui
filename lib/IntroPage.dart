import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/SignUpPage.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/DataFile.dart';
import 'package:healtho_app/utils/PrefData.dart';

import 'ConstantData.dart';
import 'SizeConfig.dart';
import 'model/IntroModel.dart';

class IntroPage extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // IntroPage(this.onChanged);

  @override
  _IntroPage createState() {
    return _IntroPage();
    // return _IntroPage(this.onChanged);
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  // final ValueChanged<bool> onChanged;

  // _IntroPage(this.onChanged);

  Future<bool> _requestPop() {
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // });
    exitApp();

    return new Future.value(false);
  }

  final controller = PageController();

  List<IntroModel> introModelList = [];

  void skip() {
    PrefData.setIsIntro(false);
    Navigator.of(context).pop(true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    introModelList = DataFile.getIntroModel(context);

    double firstSize = ConstantWidget.getScreenPercentSize(context, 60);
    double secondSize = ConstantWidget.getScreenPercentSize(context, 50);
    double remainSize =
        ConstantWidget.getScreenPercentSize(context, 100) - firstSize;
    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double circleSize = ConstantWidget.getScreenPercentSize(context, 6);
    setState(() {});

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: PageView.builder(
                    controller: controller,
                    itemBuilder: (context, position) {
                      return Container(
                        child: Stack(
                          children: [
                            Container(
                              height: firstSize,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: ExactAssetImage(
                                      introModelList[position].image!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  skip();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(defMargin),
                                  child: ConstantWidget.getCustomText(
                                      "Skip",
                                      Colors.white,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w600,
                                      15),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: secondSize),
                              padding: EdgeInsets.all(
                                  ConstantWidget.getScreenPercentSize(
                                      context, 2)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          ConstantWidget.getPercentSize(
                                              secondSize, 17)))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: (defMargin),
                                              bottom: defMargin / 2),
                                          child:
                                              ConstantWidget.getCustomTextFont(
                                                  introModelList[position]
                                                      .name!,
                                                  Colors.black87,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.bold,
                                                  ConstantWidget.getPercentSize(
                                                      remainSize, 9),
                                                  meriendaOneFont),
                                        ),
                                        ConstantWidget.getCustomTextFont(
                                            introModelList[position].desc!,
                                            Colors.black45,
                                            5,
                                            TextAlign.start,
                                            FontWeight.w500,
                                            ConstantData.font18Px,
                                            arialFont),
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: ConstantWidget
                                              .getScreenPercentSize(context, 5),
                                          child: ListView.builder(
                                            itemCount: introModelList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              double size =
                                                  ConstantWidget.getPercentSize(
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 5),
                                                      25);
                                              return Container(
                                                height: size,
                                                width: size,
                                                margin: EdgeInsets.only(
                                                    right: (size / 1.2)),
                                                decoration: BoxDecoration(
                                                  color: (index == position)
                                                      ? primaryColor
                                                      : Colors.grey.shade500,
                                                  shape: BoxShape.circle,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          height: circleSize,
                                          width: circleSize,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              ConstantData.assetImagesPath +
                                                  "right-arrow.png",
                                              color: Colors.white,
                                              height:
                                                  ConstantWidget.getPercentSize(
                                                      circleSize, 55),
                                              width:
                                                  ConstantWidget.getPercentSize(
                                                      circleSize, 55),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          if (_position <
                                              (introModelList.length - 1)) {
                                            _position++;
                                            controller.jumpToPage(_position);
                                            setState(() {});
                                          } else {
                                            skip();
                                          }
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: introModelList.length,
                    onPageChanged: _onPageViewChange,
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  _onPageViewChange(int page) {
    _position = page;
    setState(() {});
  }
}
