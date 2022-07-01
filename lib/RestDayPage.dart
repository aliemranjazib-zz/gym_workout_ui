import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class RestDayPage extends StatefulWidget {
  final int week;
  final int day;

  RestDayPage(this.day,
      this.week); // RestDayPage(this.planSubCategory,this.week);

  @override
  _RestDayPage createState() => _RestDayPage();
}

class _RestDayPage extends State<RestDayPage> {

  @override
  void initState() {

    super.initState();

  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Stack(
            children: [

              ConstantWidget.getAppBar(
                  context, "", () {
                onBackClick();
              }),


              Container(
                margin:
                EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                height: double.infinity,
                width: double.infinity,
                child:Column(
                  children: [


                    Padding(
                      padding: EdgeInsets.only(
                          left: ConstantWidget.getWidthPercentSize(context, 5)),
                      child: Row(
                        children: [
                          ConstantWidget.getTextWidget(
                              S.of(context).week + " " + widget.week.toString(),
                              ConstantData.defColor,
                              TextAlign.start,
                              FontWeight.w800,
                              ConstantData.font18Px),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 20,
                            color: ConstantData.defColor,
                            width: 2,
                          ),
                          ConstantWidget.getTextWidget(
                              S.of(context).day +
                                  " " +
                                  widget.day.toString(),
                              ConstantData.defColor,
                              TextAlign.start,
                              FontWeight.w800,
                              ConstantData.font18Px)
                        ],
                      ),
                    ),

                    Expanded(child: Container(child: Center(
                      child: ConstantWidget.getTextWidget(
                          S.of(context).restDay,
                          ConstantData.defColor,
                          TextAlign.start,
                          FontWeight.w300,
                          ConstantData.font18Px),
                    ),))

                  ],
                ),
              )
            ],
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
    Navigator.of(context).pop();
  }
}
