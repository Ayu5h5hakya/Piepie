import 'package:flutter/material.dart';
import 'package:pie_pie/StatMap.dart';
import 'package:pie_pie/pie_painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Piechart'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StatsPie(
          likeCount: 1,
          favoriteCount: 2,
        ),
      ) 
    );
  }
}

class StatsPie extends StatelessWidget {
  final int likeCount;
  final int favoriteCount;
  final void Function(StatMap) onSectorClicked;

  StatsPie(
      {Key key,
      @required this.likeCount,
      @required this.favoriteCount,
      this.onSectorClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PiePainter(dataMap: [
        StatMap(portion: 1, portionColor: Colors.red),
        StatMap(portion: 2, portionColor: Colors.blue)
      ], onSectorClicked: onSectorClicked),
      child: Container(
        height: 250
      ),
    );
  }
}

