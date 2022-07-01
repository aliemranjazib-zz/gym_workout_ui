import 'package:flutter/material.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'ChallengesIntroduction.dart';
import 'ConstantData.dart';
import 'SizeConfig.dart';
import 'db/database_helper.dart';
import 'generated/l10n.dart';
import 'model/ModelChallengeMainCat.dart';

class ChallengesList extends StatefulWidget {
  @override
  _ChallengesList createState() => _ChallengesList();
}

DatabaseHelper _databaseHelper = DatabaseHelper.instance;

class _ChallengesList extends State<ChallengesList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = ConstantWidget.getScreenPercentSize(context, 25);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                ConstantWidget.getAppBar(context, S.of(context).challenges, () {
                  Navigator.of(context).pop();
                }),
                Container(
                  margin: EdgeInsets.only(
                      top: ConstantWidget.getMarginTop(context)),
                  child: Container(
                    child: FutureBuilder<List<ModelChallengeMainCat>>(
                      future: _databaseHelper.getAllChallengeCatList(context),
                      builder: (context, snapshot) {
                        List<ModelChallengeMainCat> _list = [];
                        if (snapshot.hasData) {
                          _list = snapshot.data!;
                        }
                        return snapshot.hasData
                            ? Container(
                                child: ListView.builder(
                                  itemCount: _list.length,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    ModelChallengeMainCat subCategory =
                                        _list[index];



                                    double imgHeight =
                                    ConstantWidget.getPercentSize(
                                        height, 8);
                                    double radius =
                                        ConstantWidget.getPercentSize(
                                            height, 8);
                                    String name = "Build Muscles Challenge";

                                    if (index == 1) {
                                      name = "Challenge For Beginner";
                                    }
                                    return Container(
                                      color: Colors.white,
                                      width:
                                          SizeConfig.safeBlockHorizontal! * 65,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: ConstantWidget
                                              .getScreenPercentSize(
                                                  context, 2)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: (index == 0 || index == 1),
                                            child: Padding(
                                              padding: EdgeInsets.only(

                                                  top: (index > 0) ? 18 : 0),
                                              child:
                                                  ConstantWidget.getTextWidget(
                                                      name.toUpperCase(),
                                                      Colors.black,
                                                      TextAlign.end,
                                                      FontWeight.w600,
                                                      ConstantWidget
                                                          .getPercentSize(
                                                              height, 8.3)),
                                            ),
                                          ),
                                          InkWell(
                                            child: Container(
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
                                                          subCategory.img!,
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
                                                                  _list[index]
                                                                      .title!
                                                                      .toUpperCase(),
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
                                            ),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    ChallengesIntroduction(
                                                        _list[index]),
                                              ));
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
