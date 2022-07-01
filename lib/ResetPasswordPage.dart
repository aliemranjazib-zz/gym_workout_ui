
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/SignInPage.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'SizeConfig.dart';
import 'generated/l10n.dart';

class ResetPasswordPage extends StatefulWidget {

  @override
  _ResetPasswordPage createState() {
    return _ResetPasswordPage();
  }
}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  TextEditingController textPasswordController = new TextEditingController();
  TextEditingController textConfirmPasswordController =
      new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);



    return WillPopScope(
        child: Scaffold(
          backgroundColor: mainBgColor,
          appBar: AppBar(
            backgroundColor: mainBgColor,
            elevation: 0,
            title: Text(""),
            leading: InkWell(
              child: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
              onTap: _requestPop,
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ConstantWidget.getScreenPercentSize(context, 2.5)),
            child: ListView(
              children: [
                ConstantWidget.getTextWidget(
                      S.of(context).createPassword,
                    Colors.black,
                    TextAlign.left,
                    FontWeight.bold,
                    ConstantWidget.getScreenPercentSize(context, 4.2)),


                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 0.5),
                ),

                ConstantWidget.getTextWidget(
                    "Enter a new password",
                    Colors.grey,
                    TextAlign.start,
                    FontWeight.w400,
                    ConstantWidget.getScreenPercentSize(context, 1.8)),


                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 2.5),
                ),
                ConstantWidget.getPasswordTextFiled(
                    context, S.of(context).newPassword, textPasswordController),
                ConstantWidget.getPasswordTextFiled(
                    context,
                    S.of(context).confirmPassword,
                    textConfirmPasswordController),
                ConstantWidget.getButtonWidget(
                    context, S.of(context).next, primaryColor, () {
                  checkValidation();
                }),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  void checkValidation() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));



  }

  checkNetwork() async {

  }

}
