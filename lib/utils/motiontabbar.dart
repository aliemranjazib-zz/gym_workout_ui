library motiontabbar;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtho_app/utils/ConstantWidget.dart';

import 'package:vector_math/vector_math.dart' as vector;

import '../ConstantData.dart';
import 'TabItem.dart';




typedef MotionTabBuilder = Widget Function(
);

class MotionTabBar extends StatefulWidget {
  final Color? tabIconColor, tabSelectedColor;
  final TextStyle? textStyle;
  final Function? onTabItemSelected;
  final String? initialSelectedTab;

  final List<String>? labels;
  final List<IconData>? icons;
  final List<String>? assetIcons;
  final int? selectedIndex;

  MotionTabBar({
    this.textStyle,
    this.tabIconColor,
    this.selectedIndex,
    this.assetIcons,
    this.tabSelectedColor,
    this.onTabItemSelected,
    this.initialSelectedTab,
    this.labels,
    this.icons,
  })  : assert(initialSelectedTab != null),
        assert(tabSelectedColor != null),
        assert(tabIconColor != null),
        assert(textStyle != null),
        assert(labels!.contains(initialSelectedTab));

  @override
  _MotionTabBarState createState() => _MotionTabBarState();
}

class _MotionTabBarState extends State<MotionTabBar>
    with TickerProviderStateMixin {



  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeFabOutAnimation;
  late Animation<double> _fadeFabInAnimation;

  late List<String> labels;
  late List<String> assetIcon;
  late Map<String, IconData>? icons;

  get tabAmount => icons!.keys.length;
  get index => labels.indexOf(selectedTab!);
  get position {
    double pace = 2 / (labels.length - 1);
    return (pace * index) - 1;
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }


  double fabIconAlpha = 1;
  late IconData? activeIcon;
  late String? activeImage;
  late String? selectedTab;

  @override
  void initState() {
    super.initState();

    labels = widget.labels!;
    icons = Map.fromIterable(
      labels,
      key: (label) => label,
      value: (label) => widget.icons![labels.indexOf(label)],
    );

    selectedTab = widget.initialSelectedTab!;
    activeIcon = icons![selectedTab];
    activeImage = widget.assetIcons![labels.indexOf(selectedTab!)];

    _animationController = AnimationController(
      duration: Duration(milliseconds: ANIM_DURATION),
      vsync: this,
    );

    _fadeOutController = AnimationController(
      duration: Duration(milliseconds: (ANIM_DURATION ~/ 5)),
      vsync: this,
    );

    _positionTween = Tween<double>(begin: position, end: 1);

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        if(!mounted) {
          setState(() {});
        }
      });

    _fadeFabOutAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
          setState(() {
            fabIconAlpha = _fadeFabOutAnimation.value;
          });


      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
            setState(() {
              activeIcon = icons![selectedTab];


              activeImage = widget.assetIcons![labels.indexOf(selectedTab!)];
            });

        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
         setState(() {
           fabIconAlpha = _fadeFabInAnimation.value;
         });

      });
  }



  @override
  Widget build(BuildContext context) {
    update();
    return Container(child:
    Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 65,

          color:Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: generateTabItems(),
          ),
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Align(
              heightFactor: 0,
              alignment: Alignment(_positionAnimation.value, 0),
              child: FractionallySizedBox(
                widthFactor: 1 / tabAmount,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ClipRect(
                        clipper: HalfClipper(),
                        child: Container(
                          child: Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white ,
                                shape: BoxShape.circle,

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 90,
                      child: CustomPaint(painter: HalfPainter()),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.tabSelectedColor,
                          border: Border.all(
                            color: primaryColor,
                            width: 5,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(ConstantWidget.getPercentSize(60,25)),


                          child: Opacity(
                            opacity: fabIconAlpha,

                            child: Image.asset(ConstantData.assetHomeImagesPath+activeImage!,color:Colors.white,

                            ),
                            // child: Icon(
                            //   activeIcon,
                            //   color: Colors.white,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    color:Colors.white,);
  }



  void update(){

    // print("update---true---${widget.initialSelectedTab}");
    setState(() {

      selectedTab = widget.initialSelectedTab!;
      activeIcon = icons![selectedTab];
      activeImage = widget.assetIcons![labels.indexOf(selectedTab!)];
      _initAnimationAndStart(_positionAnimation.value, position);

    });
  }
  List<Widget> generateTabItems() {
    return labels.map((tabLabel) {
      IconData? icon = icons![tabLabel];
      String? image = widget.assetIcons![labels.indexOf(tabLabel)];


      return TabItem(
        selected: selectedTab == tabLabel,
        iconData: icon!,
        image:  image,
        title: tabLabel,
        textStyle: widget.textStyle!,
        tabSelectedColor: widget.tabSelectedColor!,
        tabIconColor: widget.tabIconColor!,
        callbackFunction: () {

          print("log---true---${widget.selectedIndex}");
          setState(() {
            activeIcon = icon;
            selectedTab = tabLabel;
            widget.onTabItemSelected!(index);
          });
          _initAnimationAndStart(_positionAnimation.value, position);
        },
      );
    }).toList();
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width, size.height / 2);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
    Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
