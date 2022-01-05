import 'package:donut_spike/fl_charts_poc.dart';
import 'package:donut_spike/pie_chart_poc.dart';
import 'package:flutter/material.dart';

import 'charts_flutter_poc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlChartPoc()),
                );
              },
              child: const Text("Fl_Charts")),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChartsFlutterPoc()),
                );
              },
              child: const Text("charts_flutter")),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PieChartPoc()),
                );
              },
              child: const Text("pie chart"))
        ],
      ),
    );
  }
}
