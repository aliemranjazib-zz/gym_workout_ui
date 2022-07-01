import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ConstantData.dart';
// import 'package:html/parser.dart';

class ConstantWidget {
  static double getPercentSize(double total, double percent) {
    return (total * percent) / 100;
  }

  static Widget getHorizonSpace(double space) {
    return SizedBox(
      width: space,
    );
  }

  static Widget getRoundCornerButtonWithoutIcon(String texts, Color color,
      Color textColor, double btnRadius, Function function) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(btnRadius),
              shape: BoxShape.rectangle,
              color: color,
// border: BorderSide(color: borderColor, width: 1)
            ),

// shape: RoundedRectangleBorder(
//     borderRadius: new BorderRadius.circular(btnRadius),
//     side: BorderSide(color: borderColor, width: 1)),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),

            child: Center(
              child: getCustomText(
                  texts, textColor, 1, TextAlign.center, FontWeight.w500, 18),
            ),
          )
        ],
      ),
      onTap: () {
        function();
      },
    );
  }

  static Widget getButtonWidget1(
      BuildContext context, String s, var color, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 8.5);
    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 30);

    return InkWell(
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: getDefaultTextWidget(
                s, TextAlign.center, FontWeight.w500, fontSize, Colors.black)),
      ),
      onTap: () {
        function();
      },
    );
  }

  static Widget getBottomText(
      BuildContext context, String s, Function function) {
    double bottomHeight = ConstantWidget.getScreenPercentSize(context, 7.6);
    double radius = ConstantWidget.getPercentSize(bottomHeight, 18);

    return InkWell(
      child: Container(
        height: bottomHeight,
        margin: EdgeInsets.symmetric(
            horizontal: ConstantWidget.getPercentSize(bottomHeight, 50),
            vertical: ConstantWidget.getPercentSize(bottomHeight, 15)),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Center(
          child: ConstantWidget.getTextWidget(s, Colors.white, TextAlign.start,
              FontWeight.bold, ConstantWidget.getPercentSize(bottomHeight, 30)),
        ),
      ),
      onTap: () {
        function();
      },
    );
  }

  static double largeTextSize = 28;

  static double getMarginTop(BuildContext context) {
    // double height = getScreenPercentSize(context, 20);
    double height = getScreenPercentSize(context, 23);

    return (height / 2) + getScreenPercentSize(context, 2.5);
  }

  static double getBlankTop(BuildContext context) {
    double height = getScreenPercentSize(context, 20);

    return getPercentSize(height, 85);
  }

  static Widget getAppBarWithAction(BuildContext context, String s, var icon,
      Function function1, Function function) {
    double height = getScreenPercentSize(context, 20);
    double radius = getPercentSize(height, 32);

    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          color: primaryColor,
          child: Stack(
            children: [
              Center(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                        child: Container(
                      height: 20,
                      color: Colors.white,
                      width: double.infinity,
                    ))
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                          child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(radius))),
                          )
                        ],
                      ))
                    ],
                  )),
                  Expanded(
                      child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radius))),
                        )),
                        Expanded(
                            child: Container(
                          color: Colors.white,
                        )),
                      ],
                    ),
                  ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: (height / 2), top: getWidthPercentSize(context, 3)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstantWidget.getTextWidget(
                          s,
                          Colors.white,
                          TextAlign.center,
                          FontWeight.w600,
                          getPercentSize(height, 12)),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getWidthPercentSize(context, 5),
                          ),
                          child: InkWell(
                            child: Image.asset(
                              ConstantData.assetImagesPath + "back_btn.png",
                              color: Colors.white,
                              height: getPercentSize(height, 18),
                            ),
                            // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
                            //     size: getPercentSize(height, 12)),
                            onTap: () {
                              function();
                            },
                          ),
                        )),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: getWidthPercentSize(context, 5),
                          ),
                          child: InkWell(
                            child: Image.asset(
                              ConstantData.assetImagesPath + icon,
                              color: Colors.white,
                              height: getPercentSize(height, 13),
                            ),
                            // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
                            //     size: getPercentSize(height, 12)),
                            onTap: () {
                              function1();
                            },
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: ConstantWidget.getBlankTop(context)),
          color: Colors.white,
        ),
      ],
    );
  }

  static Widget getAppBarWithColor(
      BuildContext context, String s, Function function) {
    double height = getScreenPercentSize(context, 20);
    double radius = getPercentSize(height, 32);

    return Container(
      height: height,
      width: double.infinity,
      color: primaryColor,
      child: Stack(
        children: [
          Center(
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                    child: Container(
                  height: 20,
                  color: ConstantData.bgColor,
                  width: double.infinity,
                ))
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                      child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(radius))),
                      )
                    ],
                  ))
                ],
              )),
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius))),
                    )),
                    Expanded(
                        child: Container(
                      color: ConstantData.bgColor,
                    )),
                  ],
                ),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: (height / 2), top: getWidthPercentSize(context, 3)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConstantWidget.getTextWidget(
                      s,
                      Colors.white,
                      TextAlign.center,
                      FontWeight.w600,
                      getPercentSize(height, 12)),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getWidthPercentSize(context, 5),
                      ),
                      child: InkWell(
                        child: Image.asset(
                          ConstantData.assetImagesPath + "back_btn.png",
                          color: Colors.white,
                          height: getPercentSize(height, 18),
                        ),
                        // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
                        //     size: getPercentSize(height, 12)),
                        onTap: () {
                          function();
                        },
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget getAppBarCustom(
      BuildContext context, String s, Function function) {
    double height = getScreenPercentSize(context, 8);

    return Container(
      height: height,
      width: double.infinity,
      color: primaryColor,

      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 5),
            ),
            child: InkWell(
              child: Image.asset(
                ConstantData.assetImagesPath + "back_btn.png",
                color: Colors.white,
                height: getPercentSize(height, 30),
              ),
              // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
              //     size: getPercentSize(height, 12)),
              onTap: () {
                function();
              },
            ),
          ),
          Expanded(
            child: ConstantWidget.getTextWidget(s, Colors.white,
                TextAlign.start, FontWeight.w600, getPercentSize(height, 22)),
          ),
        ],
      ),

      // child: Stack(
      //   children: [
      //
      //
      //
      //
      //     Center(
      //       child: Container(
      //
      //
      //         child:  Stack(
      //           children: [
      //
      //             Align(
      //               alignment: Alignment.topCenter,
      //               child: ConstantWidget.getTextWidget(s, Colors.black,
      //                   TextAlign.center, FontWeight.w600, getPercentSize(height, 12)),
      //             ),
      //
      //
      //             Align(
      //                 alignment: Alignment.topLeft,
      //                 child: Padding(
      //                   padding: EdgeInsets.only(left: getWidthPercentSize(context,5),),
      //                   child: InkWell(
      //
      //                     child: Image.asset(ConstantData.assetImagesPath+"back_btn.png",color: Colors.black,
      //                       height: getPercentSize(height, 18),),
      //                     // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
      //                     //     size: getPercentSize(height, 12)),
      //                     onTap: (){
      //                       function();
      //                     },
      //                   ),
      //                 )
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  static Widget getTransparentAppBar(
      BuildContext context, String s, Function function) {
    double height = getScreenPercentSize(context, 7.5);
    double cell = getPercentSize(height, 50);

    return Container(
      height: height,
      width: double.infinity,
      // color: Colors.black54,

      child: Row(
        children: [
          Container(
            height: cell,
            width: cell,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 5),
            ),
            child: InkWell(
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: getPercentSize(cell, 70),
              )),
              // child: Image.asset(
              //   ConstantData.assetImagesPath + "back_btn.png",
              //   color: Colors.white,
              //   height: getPercentSize(height, 30),
              // ),
              // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
              //     size: getPercentSize(height, 12)),
              onTap: () {
                function();
              },
            ),
          ),
          Expanded(
            child: ConstantWidget.getTextWidget(s, Colors.white,
                TextAlign.start, FontWeight.w600, getPercentSize(height, 22)),
          ),
        ],
      ),

      // child: Stack(
      //   children: [
      //
      //
      //
      //
      //     Center(
      //       child: Container(
      //
      //
      //         child:  Stack(
      //           children: [
      //
      //             Align(
      //               alignment: Alignment.topCenter,
      //               child: ConstantWidget.getTextWidget(s, Colors.black,
      //                   TextAlign.center, FontWeight.w600, getPercentSize(height, 12)),
      //             ),
      //
      //
      //             Align(
      //                 alignment: Alignment.topLeft,
      //                 child: Padding(
      //                   padding: EdgeInsets.only(left: getWidthPercentSize(context,5),),
      //                   child: InkWell(
      //
      //                     child: Image.asset(ConstantData.assetImagesPath+"back_btn.png",color: Colors.black,
      //                       height: getPercentSize(height, 18),),
      //                     // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
      //                     //     size: getPercentSize(height, 12)),
      //                     onTap: (){
      //                       function();
      //                     },
      //                   ),
      //                 )
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  // static Widget getTransparentAppBar(
  //     BuildContext context, String s, Function function) {
  //   double height = getScreenPercentSize(context, 9);
  //
  //
  //   return Container(
  //     height: height,
  //     width: double.infinity,
  //     color: Colors.red,
  //
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       // mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //
  //       children: [
  //         // Padding(
  //         //   padding: EdgeInsets.symmetric(
  //         //     horizontal: getWidthPercentSize(context, 5),
  //         //   ),
  //         //   child: Align(
  //         //     alignment: Alignment.centerLeft,
  //         //     child: InkWell(
  //         //       child: Image.asset(
  //         //         ConstantData.assetImagesPath + "back_btn.png",
  //         //         color: Colors.white
  //         //         ,
  //         //         height: getPercentSize(height, 30),
  //         //       ),
  //         //       // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
  //         //       //     size: getPercentSize(height, 12)),
  //         //       onTap: () {
  //         //         function();
  //         //       },
  //         //     ),
  //         //   ),
  //         // ),
  //         // Expanded(
  //         //   child:
  //           ConstantWidget.getTextWidget("s", Colors.white,
  //               TextAlign.start, FontWeight.w600, getPercentSize(height, 22)),
  //         // ),
  //       ],
  //     ),
  //
  //     // child: Stack(
  //     //   children: [
  //     //
  //     //
  //     //
  //     //
  //     //     Center(
  //     //       child: Container(
  //     //
  //     //
  //     //         child:  Stack(
  //     //           children: [
  //     //
  //     //             Align(
  //     //               alignment: Alignment.topCenter,
  //     //               child: ConstantWidget.getTextWidget(s, Colors.black,
  //     //                   TextAlign.center, FontWeight.w600, getPercentSize(height, 12)),
  //     //             ),
  //     //
  //     //
  //     //             Align(
  //     //                 alignment: Alignment.topLeft,
  //     //                 child: Padding(
  //     //                   padding: EdgeInsets.only(left: getWidthPercentSize(context,5),),
  //     //                   child: InkWell(
  //     //
  //     //                     child: Image.asset(ConstantData.assetImagesPath+"back_btn.png",color: Colors.black,
  //     //                       height: getPercentSize(height, 18),),
  //     //                     // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
  //     //                     //     size: getPercentSize(height, 12)),
  //     //                     onTap: (){
  //     //                       function();
  //     //                     },
  //     //                   ),
  //     //                 )
  //     //             ),
  //     //           ],
  //     //         ),
  //     //       ),
  //     //     )
  //     //   ],
  //     // ),
  //   );
  // }

  static Widget getAppBar(BuildContext context, String s, Function function) {
    double height = getScreenPercentSize(context, 20);
    double radius = getPercentSize(height, 32);

    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          color: primaryColor,
          child: Stack(
            children: [
              Center(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                        child: Container(
                      height: 20,
                      color: Colors.white,
                      width: double.infinity,
                    ))
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                          child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(radius))),
                          )
                        ],
                      ))
                    ],
                  )),
                  Expanded(
                      child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radius))),
                        )),
                        Expanded(
                            child: Container(
                          color: Colors.white,
                        )),
                      ],
                    ),
                  ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: (height / 2), top: getWidthPercentSize(context, 3)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstantWidget.getTextWidget(
                          s,
                          Colors.white,
                          // Colors.black,
                          TextAlign.center,
                          FontWeight.w600,
                          getPercentSize(height, 12)),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getWidthPercentSize(context, 5),
                          ),
                          child: InkWell(
                            child: Image.asset(
                              ConstantData.assetImagesPath + "back_btn.png",
                              color: Colors.white,
                              // color: Colors.black,
                              height: getPercentSize(height, 18),
                            ),
                            // child: Icon(Icons.keyboard_backspace_rounded, color:Colors.black,
                            //     size: getPercentSize(height, 12)),
                            onTap: () {
                              function();
                            },
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: ConstantWidget.getBlankTop(context)),
          color: Colors.white,
        ),
      ],
    );
  }

  static Widget getCustomTextWithoutAlign(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontsFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  static double getWidthPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.width * percent) / 100;
  }

  static Widget getSpace(double space) {
    return SizedBox(
      height: space,
    );
  }

  static Widget getDrawer(String text) {
    return ConstantWidget.getCustomText(text, Colors.white, 1, TextAlign.start,
        FontWeight.w600, ConstantData.font18Px);
  }

  static Widget getCustomText(String text, Color color, int maxLine,
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

  static Widget getCustomTextFont(
      String text,
      Color color,
      int maxLine,
      TextAlign textAlign,
      FontWeight fontWeight,
      double textSizes,
      String font) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: font,
          height: 1.1,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  static Widget getTextWidgetWithSpacing(String text, Color color,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          height: 1.5,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  static Widget getTextWidget(String text, Color color, TextAlign textAlign,
      FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  static Widget getTextWidgetWithFont(
      String text,
      Color color,
      TextAlign textAlign,
      FontWeight fontWeight,
      double textSizes,
      String font) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: font,
          letterSpacing: 1,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  static Widget getDefaultTextFiledWidget(BuildContext context, String s,
      var icon, TextEditingController textEditingController) {
    double height = ConstantWidget.getScreenPercentSize(context, 7);

    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 25);

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: ConstantData.defCellColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: TextFormField(
        validator: (v) {
          if (v!.isEmpty) {
            return "should not be empty";
          }
          return null;
        },
        maxLines: 1,
        controller: textEditingController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontFamily: ConstantData.fontsFamily,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: fontSize),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: ConstantWidget.getWidthPercentSize(context, 2)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: s,
            // suffixIcon: Icon(icon,color: Colors.grey,),
            suffixIcon: Icon(
              icon,
              color: Colors.grey,
              size: ConstantWidget.getPercentSize(height, 40),
            ),
            hintStyle: TextStyle(
                fontFamily: ConstantData.fontsFamily,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: fontSize)),
      ),
    );
  }

  static Widget getPasswordTextFiled(BuildContext context, String s,
      TextEditingController textEditingController) {
    double height = ConstantWidget.getScreenPercentSize(context, 7);
    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 25);

    return Container(
        height: height,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
        decoration: BoxDecoration(
          color: ConstantData.defCellColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: TextFormField(
          validator: (v) {
            if (v!.isEmpty) {
              return "should not be empty";
            }
            return null;
          },
          maxLines: 1,
          obscureText: true,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: textEditingController,
          style: TextStyle(
              fontFamily: ConstantData.fontsFamily,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: fontSize),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: ConstantWidget.getWidthPercentSize(context, 2)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: s,
              suffixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
                size: ConstantWidget.getPercentSize(height, 40),
              ),
              hintStyle: TextStyle(
                  fontFamily: ConstantData.fontsFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize)),
        ));
  }

  static 
  Widget getButtonWidget(
      BuildContext context, String s, var color, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 7);
    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 30);

    return InkWell(
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: getDefaultTextWidget(s, TextAlign.center, FontWeight.w500,
                fontSize, ConstantData.cellColor)),
      ),
      onTap: () {
        function();
      },
    );
  
  }

  static Widget getDefaultTextWidget(String s, TextAlign textAlign,
      FontWeight fontWeight, double fontSize, var color) {
    return Text(
      s,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
    );
  }

// static String parseHtmlString(String htmlString) {
//   final document = parse(htmlString);
//   final String parsedString = parse(document.body!.text).documentElement!.text;
//
//   return parsedString;
// }

}

String getChallengeBackground(int i) {
  String s = "home_pattern_1.jpg";
  switch (i % 3) {
    case 0:
      // s = "doscover_pattern_2.jpg";
      s = "home_pattern_1.jpg";
      break;
    case 1:
      s = "home_pattern_2.jpg";

      break;
    case 2:
      s = "home_pattern_3.jpg";

      break;
  }

  return s;
}
