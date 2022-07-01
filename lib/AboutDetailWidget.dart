import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/DataFile.dart';
import 'package:html_unescape/html_unescape.dart';

import 'ConstantData.dart';
import 'generated/l10n.dart';

class AboutDetailWidget extends StatefulWidget {
  // final String title;
  // AboutDetailWidget(this.title);

  @override
  _AboutDetailWidget createState() {
    return _AboutDetailWidget();
  }
}

class _AboutDetailWidget extends State<AboutDetailWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        child: Scaffold(
          backgroundColor:   Colors.white,
          appBar: AppBar(

            centerTitle: false,
            elevation: 0,
            backgroundColor: primaryColor,
            title: ConstantWidget.getTextWidget(
                S.of(context).aboutUs,
                Colors.white,
                TextAlign.left,
                FontWeight.bold,
                ConstantWidget.getScreenPercentSize(context, 2.3)),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Colors.white,
              ),
              onPressed: _requestPop,
            ),

          ),

          body: Container(




            child:Html(
              data:parseHtmlString(DataFile.htmlData),

              style: {
                'html': Style(color: Colors.black),
              },



            )
            // child:ConstantWidget.getTextWidget(
            //     ConstantData.parseHtmlString(DataFile.htmlData),
            //     textColor,
            //     TextAlign.left,
            //     FontWeight.bold,
            //     ConstantWidget.getScreenPercentSize(context, 2.5)),
            // child: mainWidget(),
          ),

          // bottomNavigationBar: ,
        ),
        onWillPop: _requestPop);
  }


  static String parseHtmlString(String htmlString) {

    var unescape = HtmlUnescape();
    var text = unescape.convert(htmlString);

    return text;
  }







  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }
}
