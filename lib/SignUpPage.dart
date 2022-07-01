import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'PhoneVerification.dart';
import 'SignInPage.dart';
import 'SizeConfig.dart';
import 'generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  bool isRemember = false;
  int themeMode = 0;
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textNameController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    exitApp();

    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();

    // setTheme();
  }

  // setTheme()async{
  //   themeMode = await PrefData.getThemeMode();
  //   setState(() {
  //
  //   });
  // }
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double height = ConstantWidget.getScreenPercentSize(context, 7);

    double radius = ConstantWidget.getPercentSize(height, 20);

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
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  ConstantWidget.getTextWidget(
                      S.of(context).signUpAndnstaringWorkout,
                      Colors.black,
                      TextAlign.left,
                      FontWeight.bold,
                      ConstantWidget.getScreenPercentSize(context, 4.2)),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2.5),
                  ),
                  ConstantWidget.getDefaultTextFiledWidget(
                      context,
                      S.of(context).yourName,
                      Icons.account_circle_outlined,
                      textNameController),
                  ConstantWidget.getDefaultTextFiledWidget(
                      context,
                      S.of(context).yourEmail,
                      Icons.mail_outline,
                      textEmailController),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical:
                            ConstantWidget.getScreenPercentSize(context, 1.2)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: height,
                          margin: EdgeInsets.only(right: 7),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: ConstantData.defCellColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(radius),
                            ),
                          ),
                          child: CountryCodePicker(
                            boxDecoration: BoxDecoration(
                              color: ConstantData.defCellColor,
                            ),
                            closeIcon: Icon(Icons.close,
                                size: ConstantWidget.getScreenPercentSize(
                                    context, 3),
                                color: Colors.black),

                            onChanged: (value) {
                              // countryCode = value.dialCode;
                              // print("changeval===$countryCode");
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'PK',
                            searchStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),
                            searchDecoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: ConstantData.fontsFamily)),
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),
                            dialogTextStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),

                            showFlagDialog: true,
                            hideSearch: true,
                            comparator: (a, b) => b.name!.compareTo(a.name!),

                            onInit: (code) {
                              // countryCode = code.dialCode;
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: height,
                            padding: EdgeInsets.only(left: 7),
                            margin: EdgeInsets.only(left: 7),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: ConstantData.defCellColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(radius),
                              ),
                            ),
                            child: TextField(
                              // controller: myController,
                              onChanged: (value) async {
                                try {} catch (e) {
                                  print("resge$e");
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: ConstantWidget.getWidthPercentSize(
                                          context, 2)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: S.of(context).phoneNumber,
                                  hintStyle: TextStyle(
                                      fontFamily: ConstantData.fontsFamily,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: ConstantWidget.getPercentSize(
                                          height, 25))),
                              style: TextStyle(
                                  fontFamily: ConstantData.fontsFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ConstantWidget.getPercentSize(
                                      height, 25)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                  ConstantWidget.getPasswordTextFiled(
                      context, S.of(context).password, textPasswordController),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),
                  ConstantWidget.getButtonWidget(
                      context, S.of(context).signUpNow, primaryColor, () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneVerification(true),
                        ));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                  }),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstantWidget.getTextWidget(
                          S.of(context).youHaveAnAlreadyAccount,
                          Colors.black,
                          TextAlign.left,
                          FontWeight.w500,
                          ConstantWidget.getScreenPercentSize(context, 1.8)),
                      SizedBox(
                        width:
                            ConstantWidget.getScreenPercentSize(context, 0.5),
                      ),
                      InkWell(
                        child: ConstantWidget.getTextWidget(
                            S.of(context).signIn,
                            primaryColor,
                            TextAlign.start,
                            FontWeight.bold,
                            ConstantWidget.getScreenPercentSize(context, 2)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
