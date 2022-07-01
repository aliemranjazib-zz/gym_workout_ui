
import 'package:flutter/material.dart';

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder();

  @override
  Path getInnerPath(Rect rect, { TextDirection? textDirection}) => _getPath(rect);

  @override
  Path getOuterPath(Rect rect, { TextDirection? textDirection}) => _getPath(rect);

  _getPath(Rect rect) {
    final r = rect.height / 2;
    final radius = Radius.circular(r);
    final offset = Rect.fromCircle(center: Offset.zero, radius: r);
    return Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      // ..relativeArcToPoint(offset.bottomRight, clockwise: false, radius: radius)
      // ..lineTo(rect.centerLeft.dx - r, rect.centerLeft.dy)
      ..relativeArcToPoint(offset.topRight, clockwise: true, radius: radius)
      // ..relativeArcToPoint(offset.topRight, clockwise: true, radius: radius)
      ..lineTo(rect.centerRight.dx - r, rect.centerRight.dy)
      ..relativeArcToPoint(offset.topRight, clockwise: false, radius: radius)
      ..addRect(rect);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
  }
}
