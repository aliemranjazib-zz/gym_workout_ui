import 'package:flutter/material.dart';
import 'package:healtho_app/Widgets.dart';
import 'package:healtho_app/db/database_helper.dart';
import 'package:healtho_app/model/ModelChallengeMainCat.dart';

import 'generated/l10n.dart';

class ChallengesDescription extends StatefulWidget {
  final ModelChallengeMainCat planSubCategory;

  ChallengesDescription(this.planSubCategory);

  @override
  _ChallengesDescription createState() => _ChallengesDescription();
}

class _ChallengesDescription extends State<ChallengesDescription> {
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
    _databaseHelper.getChallengesWorkingDays(widget.planSubCategory.id!).then((value) {
      print("val==$value");
      setState(() {
        days = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              getSmallBoldText(widget.planSubCategory.title!, Colors.black),
              getSizeBoxLarge,
              getMediumNormalText(S.of(context).description, Colors.black),
              getSizeBox,
              // Html(data:widget.planSubCategory.introduction,
              // // defaultTextStyle: getTextStyles(Colors.black,15),
              // ),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).duration, Colors.grey),
              getSizeBox,
              getSmallBoldText(
                  "${widget.planSubCategory.week} ${S.of(context).weeks}", Colors.black),
              getSizeBoxLarge,
              getSmallBoldText(S.of(context).goal, Colors.grey),
              getSizeBox,
              getSmallBoldText("${widget.planSubCategory.title}", Colors.black),
              getSizeBoxLarge,
              // getSmallBoldText(S.of(context).trainingLevel, Colors.grey),
              // getSizeBox,
              // getSmallBoldText(
              //     ConstantData.getExerciseTypeStr(
              //         widget.planSubCategory.type, context),
              //     Colors.black),
              // getSizeBoxLarge,
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
