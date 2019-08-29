import 'package:flutter/material.dart';
import 'package:pie_pie/StatMap.dart';
import 'dart:math';

import 'package:pie_pie/colors.dart';

class PiePainter extends CustomPainter {
  List<StatMap> dataMap;
  List<Path> sectors;
  final void Function(StatMap) onSectorClicked;
  double sumAggregate = 0.0;
  double totalSweep = 0.0;

  PiePainter({this.dataMap,this.onSectorClicked }){
    sectors = [];
    dataMap.forEach((elem){
      sumAggregate+=elem.portion;
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    sectors.clear();
    dataMap.forEach((elem) {
      _buildSector(canvas, size, elem.portion,elem.portionColor);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }


  num degToRad(num deg) => deg * (pi / 180.0);

  void _buildSector(Canvas canvas, Size size, int portion, Color portionColor) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 5;

    var paint2 = Paint();
    paint2.color = pieStrokeColor;
    paint2.strokeWidth = 4;
    paint2.style = PaintingStyle.stroke;
    paint2.strokeCap = StrokeCap.round;

    paint.color = portionColor;
    paint.style = PaintingStyle.fill;

    final sectorSweep = 360 * portion / sumAggregate;

    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 4);
    Path path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, degToRad(totalSweep), degToRad(sectorSweep), false)
      ..close();
    canvas.drawPath(path, paint);

    
    
    canvas.drawPath(path, paint2);

    sectors.add(path);
    totalSweep +=sectorSweep;
  }

  @override
  bool hitTest(Offset position) {
    print(position);
    sectors.forEach((sector){
      if(sector.contains(position))
        onSectorClicked(dataMap.elementAt(sectors.indexOf(sector)));
        return true;
    });
    return super.hitTest(position);
  }
}
