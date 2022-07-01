import 'package:flutter/material.dart';

import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelPlanCategory.dart';
import 'package:healtho_app/model/ModelPlanSubCategory.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:html/parser.dart' as htmlparser;
import 'generated/l10n.dart';

class PlanDescription extends StatefulWidget {
  final ModelPlanSubCategory planSubCategory;
  final ModelPlanCategory planCategory;

  PlanDescription(this.planSubCategory, this.planCategory);

  @override
  _PlanDescription createState() => _PlanDescription();
}

class _PlanDescription extends State<PlanDescription> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  int days = 1;

  Widget getSizeBox = SizedBox(
    height: 5,
  );
  Widget getSizeBoxLarge = SizedBox(
    height: 12,
  );

  @override
  void initState() {
    super.initState();
    _databaseHelper.getWorkingDays(widget.planSubCategory.catId!,widget.planSubCategory.id!).then((value) {
      print("val==$value");
      setState(() {
        days = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // dom.Document document = htmlparser.parse(widget.planSubCategory.introduction);

    return WillPopScope(
      child: Scaffold(
        appBar: getThemeAppBar(S.of(context).introduction, () {
          onBackClick();
        }),
        body: Container(
          padding: EdgeInsets.all(15),
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              getSmallBoldText(widget.planSubCategory.name!, Colors.black),
              getSizeBoxLarge,
              getMediumNormalText(S.of(context).description, Colors.black),
              getSizeBox,
              // Html(
              //   // document: document,
              //   data: widget.planSubCategory.introduction,
              //   // defaultTextStyle:
              //   // getTextStyles(Colors.black87, 15),
              // ),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).duration, Colors.grey),
              getSizeBox,
              getSmallBoldText(
                  "${widget.planSubCategory.noWeek} ${S.of(context).weeks}", Colors.black),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).goal, Colors.grey),
              getSizeBox,
              getSmallBoldText("${widget.planCategory.name}", Colors.black),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).trainingLevel, Colors.grey),
              getSizeBox,
              getSmallBoldText(
                  ConstantData.getExerciseTypeStr(
                      widget.planSubCategory.type!, context),
                  Colors.black),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).daysPerWeek, Colors.grey),
              getSizeBox,
              getSmallBoldText("$days ${S.of(context).days}", Colors.black),
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
