
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SizeConfig.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';



class DetailPlan extends StatefulWidget {
  @override
  _DetailPlan createState() => _DetailPlan();
}

class _DetailPlan extends State<DetailPlan> {




  Widget getSizeBox = SizedBox(
    height: 20,
  );
  
  

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = ConstantWidget.getScreenPercentSize(context, 10);
    double circle = ConstantWidget.getPercentSize(height, 30);
    return WillPopScope(
      onWillPop: () async {
        onBackClick();
        return false;
      },
      child: Scaffold(
        // appBar: getThemeAppBar("Add Plan", () {
        //   onBackClick();
        // }),
        body: SafeArea(
          child: Stack(
            children: [

              Container(
                height: height,
                color: Colors.white,
                child: Container(

                  decoration: BoxDecoration(
                      color: primaryColor,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular((ConstantWidget.getPercentSize(height,
                        90))))
                  ),

                  child: Stack(
                    children: [

                      Padding(padding: EdgeInsets.only(left: 15),child: Align(
                        alignment: Alignment.centerLeft,
                        child: ConstantWidget.getTextWidget(S.of(context).introduction,Colors.black, TextAlign.start,
                            FontWeight.w600, ConstantWidget.getPercentSize(height, 30)),
                      ),),

                      Align(alignment: Alignment.topRight,
                      child: InkWell(
                        child: Container(
                          height: circle,
                          width: circle,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle
                          ),
                          margin: EdgeInsets.only(right: 8),
                          child: Center(
                            child: Icon(Icons.close,color: Colors.white,size: ConstantWidget.getPercentSize(circle, 80),),
                          ),
                        ),
                        onTap: (){
                          onBackClick();
                        },
                      ),)
                    ],
                  ),
                ),



              )
,


              Container(
                margin: EdgeInsets.only(top: height),
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(18),
                  children: [
                    getTitle(S.of(context).planName1),
                    
                    getSubTitle("ghfgh"),
                    // getSizeBox,



                    getSizeBox,


                    getTitle(S.of(context).description),
                    
                    getSubTitle("ghfgh"),
                    getSizeBox,




                    getTitle(S.of(context).duration),
                    
                    getSubTitle("9 week"),

                    getSizeBox,

                    getTitle(S.of(context).daysPerWeek),
                    
                    getSubTitle("0"),


                    getSizeBox,

                    getTitle(S.of(context).goal),
                    
                    getSubTitle("Build Muscles"),



                    getSizeBox,

                    getTitle(S.of(context).trainingLevel),
                    
                    getSubTitle("Intermediate"),








                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getTextStyle(){
    return TextStyle(fontSize: ConstantWidget.getScreenPercentSize(context, 1.8),color: Colors.black54,fontFamily: ConstantData.fontsFamily);
  }
  getTitle(String s){
    return ConstantWidget.getTextWidget(s,ConstantData.defColor, TextAlign.start,
        FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 2.3));
  }

  getSubTitle(String s){
    return ConstantWidget.getTextWidget(s,Colors.black54, TextAlign.start,
        FontWeight.w400, ConstantWidget.getScreenPercentSize(context, 2));
  }

  void onBackClick() {
    Navigator.of(context).pop();
  }
}
