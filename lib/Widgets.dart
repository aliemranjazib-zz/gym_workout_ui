import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
// import 'package:toast/toast.dart';

Widget getMediumNormalText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.normal),
  );
}

getProgressDialog() {
  return new Container(
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
      ),
      child: new Center(child: CupertinoActivityIndicator()));
}

Widget getSmallNormalText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.normal),
  );
}

getTextStyles(Color color, double size) {
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: ConstantData.fontsFamily,
      fontWeight: FontWeight.bold);
}

Widget getSmallBoldText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.bold),
  );
}




setStatusBarColor(Color color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color
  ));
}

Widget getCircularButton(Color color, double corners, String texts,
    Color textColor, Function onTap) {
  return CupertinoButton(
      onPressed: (){
        onTap();
      },
      color: color,
      borderRadius: new BorderRadius.circular(corners),
      child: getSmallBoldText(texts, textColor));
}

Widget getNormalText(double size, String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.normal),
  );
}

Widget getMediumNormalWhiteText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.normal),
  );
}

AppBar getThemeAppBar(String s, Function onTap) {
  return AppBar(
    title: getHeaderTitle(s),
    backgroundColor: primaryColor,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Image.asset(ConstantData.assetImagesPath+"back_btn.png",color: Colors.white,height: ConstantWidget.getScreenPercentSize(context,4),),
          onPressed: (){
            onTap();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
  );
}
AppBar getThemeAppBarWithColor(String s,Color colors, Function onTap) {
  return AppBar(
    title: getHeaderTitle(s),
    backgroundColor: colors,
    elevation: 0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: (){
            onTap();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
  );
}

AppBar getThemeAppBarWithOption(
    String s, Function onTap, List<Widget> widgets) {
  return AppBar(
    title: getHeaderTitle(s),
    backgroundColor: ConstantData.themeData.primaryColor,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: (){
            onTap();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    actions: widgets,
  );
}

Widget getMediumBoldWhiteText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.bold),
  );
}

Widget getMediumBoldText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.bold),
  );
}

void showCustomToast(String texts,BuildContext  context) {

  Fluttertoast.showToast(
      msg: texts,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black38,
      textColor: Colors.white,
      fontSize: 16.0);
  // Toast.show(texts, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

}

Widget getHeaderTitle(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.bold),
  );
}

Widget getLargeTitle(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 23,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.bold),
  );
}

Widget getNormalTexts(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: ConstantData.fontsFamily,
        fontWeight: FontWeight.normal),
  );
}

Widget getCupertinoWhiteIcon(IconData icons) {
  return Icon(
    icons,
    color: Colors.white,
  );
}

Widget getWhiteIcon(IconData icons) {
  return Icon(
    icons,
    color: Colors.white,
  );
}
