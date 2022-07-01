import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/FirstPage.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'ForgotPasswordPage.dart';
import 'SignUpPage.dart';
import 'generated/l10n.dart';
import 'utils/PrefData.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  bool isRemember = false;
  // int themeMode = 0;
  TextEditingController textNameController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: mainBgColor,
          appBar: AppBar(
            backgroundColor: mainBgColor,
            elevation: 0,
            title: Text(""),
            leading: GestureDetector(
              onTap: () {
                _requestPop();
              },
              child: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ConstantWidget.getScreenPercentSize(context, 2.5)),
            child: ListView(
              children: [
                ConstantWidget.getTextWidget(
                    S.of(context).gladToMeetnyouAgain,
                    Colors.black,
                    TextAlign.left,
                    FontWeight.bold,
                    ConstantWidget.getScreenPercentSize(context, 4.2)),
                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 2.5),
                ),
                ConstantWidget.getDefaultTextFiledWidget(
                    context,
                    S.of(context).yourEmail,
                    Icons.account_circle_outlined,
                    textNameController),
                ConstantWidget.getPasswordTextFiled(
                    context, S.of(context).password, textPasswordController),
                InkWell(
                  child: ConstantWidget.getTextWidget(
                      S.of(context).forgotPassword,
                      Colors.black,
                      TextAlign.end,
                      FontWeight.w400,
                      ConstantWidget.getScreenPercentSize(context, 1.8)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ));
                  },
                ),
                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 4),
                ),
                ConstantWidget.getButtonWidget(context, S.of(context).signInNow,
                    ConstantData.subPrimaryColor, () {
                  PrefData.setIsSignIn(true);
                  PrefData.setIsIntro(false);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ));
                }),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          ConstantWidget.getScreenPercentSize(context, .5)),
                  child: Center(
                    child: ConstantWidget.getTextWidget(
                        S.of(context).or,
                        Colors.black,
                        TextAlign.center,
                        FontWeight.w300,
                        ConstantWidget.getScreenPercentSize(context, 1.8)),
                  ),
                ),
                ConstantWidget.getButtonWidget(
                    context, S.of(context).signUpNow, primaryColor, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                }),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
