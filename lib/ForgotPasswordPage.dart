
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'PhoneVerification.dart';
import 'SizeConfig.dart';




import 'generated/l10n.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  int themeMode = 0;
  TextEditingController phoneController = new TextEditingController();
  String countryCode = "IN";

  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
  }
  TextEditingController textNameController = new TextEditingController();

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
                    S.of(context).forgotPassword,
                    Colors.black,
                    TextAlign.left,
                    FontWeight.bold,
                    ConstantWidget.getScreenPercentSize(context, 4.2)),


                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 0.5),
                ),

                ConstantWidget.getTextWidget(
                   "We need your registration email to send you password reset code!",
                    Colors.grey,
                    TextAlign.start,
                    FontWeight.w400,
                    ConstantWidget.getScreenPercentSize(context, 1.8)),


                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 3),
                ),
                ConstantWidget.getDefaultTextFiledWidget(
                    context, S.of(context).yourEmail,Icons.account_circle_outlined, textNameController),


                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 0.5),
                ),
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
    sendPage();
  }



  void sendPage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneVerification(false),
        ));
  }
}
