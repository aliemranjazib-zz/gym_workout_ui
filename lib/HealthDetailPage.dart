import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/generated/l10n.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:healtho_app/utils/DataFile.dart';

import 'ConstantData.dart';
import 'model/HealthModel.dart';

class HealthDetailPage extends StatefulWidget {
  final HealthModel healthModel;

  HealthDetailPage(this.healthModel);

  @override
  _HealthDetailPage createState() {
    return _HealthDetailPage();
  }
}

class _HealthDetailPage extends State<HealthDetailPage> {
  List<HealthModel> healthList = [];

  int selectedPosition = 0;
  List<String> list = ["Workout Tips", "Diet Tips", "Supplement"];

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
    double height = ConstantWidget.getScreenPercentSize(context, 30);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        top: ConstantWidget.getScreenPercentSize(context, 2)),
                    child: Column(
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: new ExactAssetImage(
                              ConstantData.assetImagesPath +
                                  widget.healthModel.image!,
                            ),
                            fit: BoxFit.cover,
                          )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ConstantWidget.getTextWidget(
                                        widget.healthModel.title!,
                                        ConstantData.defColor,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        ConstantWidget.getScreenPercentSize(
                                            context, 2)),
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    size: ConstantWidget.getScreenPercentSize(
                                        context, 3),
                                    color: primaryColor,
                                  )
                                ],
                              ),


                              SizedBox(height: 8  ,),


                              ConstantWidget.getTextWidgetWithSpacing(widget.healthModel.desc!+"\n"+widget.healthModel.desc!,
                                  Colors.black54,
                                  TextAlign.start, FontWeight.bold, ConstantWidget.getScreenPercentSize(context,1.5)),
                              SizedBox(height: 8  ,),
                              Row(
                                children: [
                                  Expanded(
                                    child: ConstantWidget.getCustomText(widget.healthModel.time!,
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
                  ConstantWidget.getAppBarCustom(context, S.of(context).naturalTips, () {
                    onBackClick();
                  }),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }
}
