import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class TabIndicationPainter extends CustomPainter {
  Paint? painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  late PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 124.0,
      this.dxEntry = 25.0,
      this.radius = 22.0,
      this.dy = 25.0,
      required this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, kbackGroundLight, 3.0, true);
    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
