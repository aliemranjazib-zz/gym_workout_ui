import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/CopyDay.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/model/ModelAddMyPlan.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

class CopyWeek extends StatefulWidget {
 final ModelAddMyPlan modelAddMyPlan;
 final  int getWeek;
 final  int getDay;
 final  String s;

  CopyWeek(this.modelAddMyPlan, this.getWeek, this.getDay, this.s);

  // CopyWeek(this.modelAddMyPlan, this.getWeek, this.getDay);

  @override
  _CopyWeek createState() => _CopyWeek();
}

class _CopyWeek extends State<CopyWeek> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        // appBar: getThemeAppBar(widget.modelAddMyPlan.name!, () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [

              ConstantWidget.getAppBarWithColor(
                  context, widget.modelAddMyPlan.name!, () {
                onBackClick();
              }),
              Container(
                margin:
                EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantWidget.getTextWidget(
                        S.of(context).selectTheWeekInWhichYouWantToCopyThe,
                        Colors.black87,
                        TextAlign.start,
                        FontWeight.w300,
                        ConstantWidget.getScreenPercentSize(context, 2)),

                    // getSmallBoldText(
                    //     S.of(context).selectTheWeekInWhichYouWantToCopyThe,
                    //     Colors.grey),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.modelAddMyPlan.noWeek,
                          itemBuilder: (context, index) {

                            double circle =
                            ConstantWidget.getScreenPercentSize(context, 4);
                            double fontSize =
                            ConstantWidget.getPercentSize(circle, 43);
                            return InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.all(
                                     10),
                                width: double.infinity,
                                // height: SizeConfig.blockSizeVertical * 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ConstantWidget.getTextWidget(
                                            S.of(context).week +
                                                " " +
                                                (index + 1).toString(),
                                            Colors.black,
                                            TextAlign.start,
                                            FontWeight.w300,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.8)),
                                        Container(
                                          width: 0.8,
                                          height: 15,
                                          color: ConstantData.defColor,
                                          margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                        ),
                                        ConstantWidget.getTextWidget(
                                            (index <= 1)?  "2 " + S.of(context).days:"0 " + S.of(context).days,
                                            primaryColor,
                                            TextAlign.start,
                                            FontWeight.w300,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.8)),
                                      ],
                                    ),

                                    (index <= 1)?InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) {
                                            return CopyDay(widget.modelAddMyPlan,
                                                widget.getWeek, index + 1, widget.getDay,widget.s);
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: circle,
                                        margin: EdgeInsets.only(top: ConstantWidget.getScreenPercentSize(context,1.5)),
                                        child:  ListView.builder(
                                          itemCount: 2,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {


                                            return Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                (index> 0)?Container(width: ConstantWidget.getWidthPercentSize(context,4),
                                                  height: 0.5,color: Colors.black,):Container(),
                                                Container(
                                                  height: circle,
                                                  width: circle,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ConstantData.cellColor),
                                                  child: Center(
                                                    child: ConstantWidget.getTextWidget((index+1).toString(),
                                                        Colors.black, TextAlign.center, FontWeight.w600, fontSize),
                                                  ),
                                                ),


                                              ],
                                            );
                                          },),
                                      ),
                                    ):Container()

                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   mainAxisSize: MainAxisSize.max,
                                    //   children: [
                                    //     getMediumBoldText(
                                    //         ((index <9)
                                    //             ? "0${index + 1}"
                                    //             : "${index + 1}"),
                                    //         Colors.grey),
                                    //     Expanded(
                                    //       child: Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Padding(
                                    //             padding: EdgeInsets.only(left: 7),
                                    //             child: getMediumBoldText(
                                    //                 S.of(context).week, Colors.black87),
                                    //           ),
                                    //           SizedBox(
                                    //             height: 7,
                                    //           ),
                                    //           Padding(
                                    //             padding: EdgeInsets.only(left: 7),
                                    //             child: Text(
                                    //               widget.modelAddMyPlan.description!,
                                    //               style:
                                    //               getTextStyles(Colors.black38, 12),
                                    //               maxLines: 1,
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //       // child: Wrap(
                                    //       //   children: [
                                    //       //     getMediumBoldText("Week", Colors.black87),
                                    //       //     Text(
                                    //       //       widget.planSubCategory.introduction,
                                    //       //       style: getTextStyles(Colors.black38, 12),
                                    //       //       maxLines: 1,
                                    //       //     )
                                    //       //   ],
                                    //       //   direction: Axis.vertical,
                                    //       // ),
                                    //       flex: 1,
                                    //     ),
                                    //     Column(
                                    //       mainAxisSize: MainAxisSize.max,
                                    //       crossAxisAlignment: CrossAxisAlignment.center,
                                    //       children: [
                                    //         Icon(
                                    //           CupertinoIcons.right_chevron,
                                    //           color: Colors.grey,
                                    //         )
                                    //       ],
                                    //     )
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              onTap: () {

                              },
                            );
                          },
                        ),
                      ),
                    )
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
