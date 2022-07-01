import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';


import 'ConstantData.dart';
import 'SizeConfig.dart';
import 'generated/l10n.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePage createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {


  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();


  @override
  void initState() {
    super.initState();


    firstNameController.text = "harry";
    lastNameController.text = "harry";
    mailController.text = "fd@gmail.com";
    genderController.text = "Male";
    phoneController.text = "326598659";
    ageController.text = "20";
    heightController.text = "125";
    weightController.text = "25";

    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  XFile? _image;
  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });



  }


  getProfileImage() {

      if (_image != null && _image!.path.isNotEmpty) {
        return Image.file(
          File(_image!.path),
          fit: BoxFit.cover,
        );
      }else {
        //
        return Image.asset(
          ConstantData.assetImagesPath + "hugh.png",
          fit: BoxFit.cover,
        );
      }

  }

  int _selectedRadio = 0;
  List<String> radioList = [
    "Male",
    "Female",
  ];
  double defaultMargin=0;double editTextHeight=0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     editTextHeight = MediaQuery.of(context).size.height * 0.06;


    double profileHeight = ConstantWidget.getScreenPercentSize(context, 15);
     defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double margin = ConstantWidget.getScreenPercentSize(context, 0.5);
    double editSize = ConstantWidget.getPercentSize(profileHeight, 24);
    double listHeight = ConstantWidget.getScreenPercentSize(context, 4);




    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,




          bottomNavigationBar: ConstantWidget.getBottomText(
              context, S.of(context).save, () {
            Navigator.of(context).pop(true);
          }),

          body: SafeArea(
            child: Stack(
              children: [
                ConstantWidget.getAppBar(context, S.of(context).editProfile, () {
                  _requestPop();
                }),
                Container(


                  margin: EdgeInsets.only(top: ConstantWidget.getMarginTop(context)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Container(

                                height: profileHeight + (profileHeight / 5),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    children: <Widget>[


                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: profileHeight,
                                          width: profileHeight,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width:
                                                  ConstantWidget.getScreenPercentSize(
                                                      context, 0.2))),
                                          child: ClipOval(
                                            child: Material(
                                              color: primaryColor,
                                              child: getProfileImage(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: ConstantWidget.getScreenPercentSize(
                                                    context, 10),
                                                bottom:
                                                ConstantWidget.getScreenPercentSize(
                                                    context, 2.7)),
                                            height: editSize,
                                            width: editSize,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.photo_camera_back,
                                                  color: Colors.white,
                                                  size: ConstantWidget.getPercentSize(
                                                      editSize, 48),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            _imgFromGallery();
                                          },
                                          // onTap: _imgFromGallery,
                                        ),
                                      )
                                    ],
                                  ),
                                )),

                            Container(
                              margin: EdgeInsets.only(bottom: defaultMargin),

                              // color: ConstantData.cellColor,
                              padding: EdgeInsets.all(defaultMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: ConstantWidget.getCustomTextWithoutAlign(
                                        S.of(context).userInformation,
                                        Colors.black,
                                        FontWeight.bold,
                                        ConstantData.font22Px),
                                  ),

                                  SizedBox(height: (defaultMargin/2),),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: (defaultMargin/2)),
                                              padding: EdgeInsets.only(right: (defaultMargin/1.5)),
                                              height: editTextHeight,
                                              child: TextField(
                                                maxLines: 1,
                                                controller: firstNameController,
                                                style: TextStyle(
                                                    fontFamily: ConstantData.fontsFamily,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ConstantData.font18Px),
                                                decoration: InputDecoration(
                                                  enabledBorder:  OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                    borderSide:  BorderSide(
                                                        color: Colors.grey, width: 0.0),
                                                  ),

                                                  border: OutlineInputBorder(
                                                    borderSide:  BorderSide(
                                                        color: Colors.grey, width: 0.0),
                                                  ),

                                                  labelStyle: TextStyle(
                                                      fontFamily: ConstantData.fontsFamily,
                                                      color: Colors.grey
                                                  ),
                                                  labelText: S.of(context).firstName,
                                                  // hintText: 'Full Name',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: (defaultMargin/2)),

                                              padding: EdgeInsets.only(left: (defaultMargin/1.5)),
                                              height: editTextHeight,
                                              child: TextField(
                                                controller: lastNameController,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: ConstantData.fontsFamily,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ConstantData.font18Px),
                                                decoration: InputDecoration(
                                                  enabledBorder:  OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                    borderSide:  BorderSide(
                                                        color: Colors.grey, width: 0.0),
                                                  ),

                                                  border: OutlineInputBorder(
                                                    borderSide:  BorderSide(
                                                        color: Colors.grey, width: 0.0),
                                                  ),

                                                  labelStyle: TextStyle(
                                                      fontFamily: ConstantData.fontsFamily,
                                                      color: Colors.grey
                                                  ),
                                                  labelText: S.of(context).lastName,
                                                  // hintText: 'Full Name',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: (defaultMargin/2)),
                                    height: editTextHeight,
                                    child: TextField(
                                      maxLines: 1,
                                      controller: mailController,
                                      style: TextStyle(
                                          fontFamily: ConstantData.fontsFamily,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: ConstantData.font18Px),
                                      decoration: InputDecoration(
                                        enabledBorder:  OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide:  BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),

                                        border: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),

                                        labelStyle: TextStyle(
                                            fontFamily: ConstantData.fontsFamily,
                                            color: Colors.grey
                                        ),
                                        labelText: S.of(context).emailAddressHint,
                                        // hintText: 'Full Name',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: (defaultMargin/2)
                                    ),

                                    height: editTextHeight,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      controller: phoneController,
                                      style: TextStyle(
                                          fontFamily: ConstantData.fontsFamily,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: ConstantData.font18Px),
                                      decoration: InputDecoration(
                                        enabledBorder:  OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide:  BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),

                                        border: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),

                                        labelStyle: TextStyle(
                                            fontFamily: ConstantData.fontsFamily,
                                            color: Colors.grey
                                        ),
                                        labelText: S.of(context).phone,
                                        // hintText: 'Full Name',
                                      ),
                                    ),
                                  ),


                                  getFiled(heightController,"Height",(){
                                    showHeightDialog();
                                  }),
                                  getFiled(weightController,"Weight",(){
                                    showWeightDialog();
                                  }),
                                  getFiled(ageController,"Age",(){
                                    showAgeDialog();
                                  }),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical:  (defaultMargin/2)),
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                        "Gender",
                                        Colors.black,
                                        FontWeight.bold,
                                        ConstantData.font18Px),
                                  ),


                                  Container(
                                    height: listHeight,
                                    child: ListView.builder(
                                      itemCount: radioList.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                          vertical: margin),
                                      itemBuilder: (context, index) {
                                        return Container(

                                          margin: EdgeInsets.only(right: defaultMargin),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedRadio = index;
                                              });
                                            },
                                            child: _radioView(radioList[index],
                                                (_selectedRadio == index),index),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            )



                            ,





                          ],
                        ),
                        flex: 1,
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }


  getFiled(TextEditingController textEditingController,String s,Function function){
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: (defaultMargin/2)
        ),

        height: editTextHeight,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          enabled: false,
          controller: textEditingController,
          style: TextStyle(
              fontFamily: ConstantData.fontsFamily,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: ConstantData.font18Px),
          decoration: InputDecoration(
            enabledBorder:  OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide:  BorderSide(
                  color: Colors.grey, width: 0.0),
            ),

            border: OutlineInputBorder(
              borderSide:  BorderSide(
                  color: Colors.grey, width: 0.0),
            ),

            labelStyle: TextStyle(
                fontFamily: ConstantData.fontsFamily,
                color: Colors.grey
            ),
            labelText: s,
            // hintText: 'Full Name',
          ),
        ),
      ),
    );
  }

  Widget _radioView(String s, bool isSelected, int position) {

    double height =ConstantWidget.getScreenPercentSize(context, 4);

    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelected ? Colors.green : Colors.grey,
            size: ConstantWidget.getPercentSize(height, 60)
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ConstantWidget.getScreenPercentSize(context, 1.5)),
            child: Text(
              s,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: ConstantData.fontsFamily,
                  fontWeight: FontWeight.w300,
                  fontSize: ConstantWidget.getPercentSize(height, 50),
                  color:  Colors.black45),
            ),
          )
        ],
      ),
      onTap: () {
        if (position != _selectedRadio) {
          if (_selectedRadio == 0) {
            _selectedRadio = 1;
          } else {
            _selectedRadio = 0;
          }
        }
        setState(() {});
      },
    );
  }


  void showAgeDialog() {
    int defValue = int.parse(ageController.text);
    // int defValue =int.parse(ageController.text);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  width: 300.0,
                  padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstantWidget.getCustomText("Age", Colors.black87, 1,
                          TextAlign.start, FontWeight.w600, 20),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: ConstantWidget.getScreenPercentSize(
                                context, 2.5)),
                        child: Align(
                          alignment: Alignment.center,
                          child: NumberPicker(
                            value: defValue,
                            minValue: 15,
                            maxValue: 90,
                            textStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 1.5),
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),
                            selectedTextStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 4),
                                color: primaryColor,
                                fontFamily: ConstantData.fontsFamily),
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              defValue = value;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              new TextButton(
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(
                        fontFamily: ConstantData.fontsFamily,
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    // PrefData().setIsMute(isSwitched);
                    Navigator.pop(context);
                    setState(() {
                      ageController.text = defValue.toString();
                    });
                  }),
            ],
          );
        });
  }

  void showHeightDialog() {
    // int defValue = height;
    int defValue =int.parse(heightController.text);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  width: 300,
                  padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstantWidget.getCustomText(
                      "Height", Colors.black87, 1,
                          TextAlign.start, FontWeight.w600, 20),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: ConstantWidget.getScreenPercentSize(
                                context, 2.5)),
                        child: Align(
                          alignment: Alignment.center,
                          child: NumberPicker(
                            value: defValue,
                            minValue: 80,
                            maxValue: 350,
                            textStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 1.5),
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),
                            selectedTextStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 4),
                                color: primaryColor,
                                fontFamily: ConstantData.fontsFamily),
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              defValue = value;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              new TextButton(
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(
                        fontFamily: ConstantData.fontsFamily,
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    // PrefData().setIsMute(isSwitched);
                    Navigator.pop(context);
                    setState(() {
                      heightController.text = defValue.toString();
                      // heightController.text = defValue.toString();
                      // heightController.text = defValue.toString();
                    });
                  }),
            ],
          );
        });
  }

  void showWeightDialog() {
    // int defValue = weight;
    int defValue =int.parse(weightController.text);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  width: 300.0,
                  padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstantWidget.getCustomText("Weight", Colors.black87, 1,
                          TextAlign.start, FontWeight.w600, 20),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: ConstantWidget.getScreenPercentSize(
                                context, 2.5)),
                        child: Align(
                          alignment: Alignment.center,
                          child: NumberPicker(
                            value: defValue,
                            minValue: 20,
                            maxValue: 250,
                            textStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 1.5),
                                color: Colors.black,
                                fontFamily: ConstantData.fontsFamily),
                            selectedTextStyle: TextStyle(
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 4),
                                color: primaryColor,
                                fontFamily: ConstantData.fontsFamily),
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              defValue = value;
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              new TextButton(
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(
                        fontFamily: ConstantData.fontsFamily,
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    // PrefData().setIsMute(isSwitched);
                    Navigator.pop(context);
                    setState(() {
                      weightController.text =  defValue.toString();
                      // weightController.text = defValue.toString();
                    });
                  }),
            ],
          );
        });
  }


}
