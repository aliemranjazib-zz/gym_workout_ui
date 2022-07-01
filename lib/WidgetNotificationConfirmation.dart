import 'package:flutter/material.dart';
import 'package:healtho_app/ConstantData.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'SignInPage.dart';
import 'SizeConfig.dart';
import 'generated/l10n.dart';


class WidgetNotificationConfirmation extends StatefulWidget {
  @override
  _WidgetNotificationConfirmation createState() =>
      _WidgetNotificationConfirmation();
}

class _WidgetNotificationConfirmation
    extends State<WidgetNotificationConfirmation> {


  @override
  void initState() {
    super.initState();


    setTheme();
  }

  setTheme() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
          backgroundColor: mainBgColor,
          body: new Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ConstantWidget.getCustomText(S.of(context).app_name, Colors.black, 1,
                      TextAlign.center, FontWeight.bold, 28),

                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  Image.asset(
                    ConstantData.assetImagesPath  + "img_allow_notification.png",
                    fit: BoxFit.contain,
                    width: SizeConfig.safeBlockHorizontal! * 70,
                    height: SizeConfig.safeBlockVertical! * 40,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  // SizedBox(
                  //   height: 45.0,
                  // ),
                  ConstantWidget.getCustomText("Notifications", Colors.black, 1,
                      TextAlign.center, FontWeight.w600, 20),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child:ConstantWidget.getCustomText(
                        "Stay notified about course updates,\nnew exam tools and change to\nthe leaderboard",
                        Colors.grey,
                        3,
                        TextAlign.center,
                        FontWeight.w100,
                        16),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.5,
                  ),

                  InkWell(
                    child: Container(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(22.0),
                      // ),

                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(22.0),
                          shape: BoxShape.rectangle,
                          color: primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        // onPressed: () {
                        //   Navigator.of(context).push(new MaterialPageRoute(
                        //     builder: (context) => LoginPage(),
                        //   ));
                        // },

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstantWidget.getCustomText("Allow", Colors.white, 1,
                                TextAlign.center, FontWeight.w400, 18),
                          ],
                        )),

                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                    },
                    child: ConstantWidget.getCustomText("Skip", Colors.black, 1,
                        TextAlign.center, FontWeight.w500, 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
