import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/DataFile.dart';

import 'ConstantData.dart';
import 'HealthDetailPage.dart';
import 'generated/l10n.dart';
import 'model/HealthModel.dart';

class HealthTipsPage extends StatefulWidget{

  @override
  _HealthTipsPage createState() {
    return _HealthTipsPage();
  }

}

class _HealthTipsPage extends State<HealthTipsPage>{

  List<HealthModel> healthList=[];

  int selectedPosition=0;
  List<String> list=["Workout Tips","Diet Tips","Supplement"];
  void onBackClick() {
    Navigator.of(context).pop();
  }


  @override
  void initState() {
    super.initState();

    setState(() {

      healthList = DataFile.getHealthList();


    });
  }


  @override
  Widget build(BuildContext context) {

    double height = ConstantWidget.getScreenPercentSize(context, 6);

    return WillPopScope(child: Scaffold(


    backgroundColor: Colors.white,
    body: SafeArea(
      child: Container(
        child: Stack(
          children: [
            ConstantWidget.getAppBar(context, S.of(context).healthTips, () {
             onBackClick();
            }),
            Container(

              margin: EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),

              child:  Column(
                children: [
                  Container(



                    height: height,
                    child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        bool isSelected =
                        (selectedPosition == index);
                        return InkWell(child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ConstantWidget.getTextWidget(
                                    list[index],
                                    (isSelected)
                                        ? Colors.black
                                        : Colors.black54,
                                    TextAlign.start,
                                    (isSelected)
                                        ? FontWeight.w800:FontWeight.w500,
                                    ConstantWidget.getPercentSize(height, 35)),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 5,
                                  width: ConstantWidget.getWidthPercentSize(context,5),
                                  color: (isSelected)
                                      ? primaryColor
                                      : Colors.transparent,
                                ),
                              )
                            ],
                          ),
                        ),
                          onTap: (){
                            setState(() {
                              selectedPosition = index;healthList = healthList.reversed.toList();

                            });
                          },);
                      },
                    ),
                  ),
                  SizedBox(height: 15,),


                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: healthList.length,
                      itemBuilder: (context, index) {

                        double imgHeight = ConstantWidget.getScreenPercentSize(context,40);
                        double radius = ConstantWidget.getScreenPercentSize(context, 1.5);
                      return InkWell(
                        onTap: (){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HealthDetailPage(healthList[index]),
                              ));
                        },
                        child: Card(
                          margin: EdgeInsets.all( ConstantWidget.getScreenPercentSize(context, 1.8)),



                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),

                          child: Container(


                            child: Stack(
                              children: [
                                Container(
                                  height: imgHeight,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radius),

                                      image: DecorationImage(
                                        image: new ExactAssetImage(
                                          ConstantData.assetImagesPath + healthList[index].image!,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                )
,
                                Container(
                                  margin: EdgeInsets.only(top: ConstantWidget.getPercentSize(imgHeight,65)),
                                  // margin: EdgeInsets.only(top: (height*1.7)),
                                  padding: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context,1.6)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                  borderRadius: BorderRadius.only(topLeft:
                                  Radius.circular(ConstantWidget.getScreenPercentSize(context,4)),bottomRight: Radius.circular(radius),bottomLeft: Radius.circular(radius))

                                  ,
                                  ),

                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: ConstantWidget.getCustomText(healthList[index].title!,
                                              Colors.black, 1, TextAlign.start, FontWeight.w300, ConstantWidget.getScreenPercentSize(context,1.8))),

                                          SizedBox(width: 5,)
                                          ,Icon(Icons.favorite_border,size: ConstantWidget.getScreenPercentSize(context, 3),color: primaryColor,)
                                        ],
                                      ),

                                      SizedBox(height: 8  ,),
                              ConstantWidget.getCustomText(healthList[index].desc!,
                                  Colors.black54, 3,
                                  TextAlign.start, FontWeight.bold, ConstantWidget.getScreenPercentSize(context,1.5)),
                                      SizedBox(height: 8  ,),


                                       Row(
                                         children: [
                                           Expanded(
                                             child: ConstantWidget.getCustomText(healthList[index].time!,
                                                 primaryColor, 1, TextAlign.end, FontWeight.w500, ConstantWidget.getScreenPercentSize(context,1.5)),
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
                    },),
                  )


                ],
              ),
            )
          ],
        ),
      ),
    ),
  ), onWillPop: () async {
    onBackClick();
    return false;
  });
  }

}