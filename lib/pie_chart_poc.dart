import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartPoc extends StatefulWidget {
  @override
  State<PieChartPoc> createState() => _PieChartPocState();
}

class _PieChartPocState extends State<PieChartPoc> {
  double val1 = 20;
  double val2 = 20;
  double val3 = 20;
  double val4 = 20;
  String centerText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlChart"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      colorList: const [Colors.red, Colors.green, Colors.yellow, Colors.orange],
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 50,

                      centerText: "HYBRID",
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: false,
                        //legendShape: _BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: true,
                        decimalPlaces: 1,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                  ],
                ),
              ),
            ),
            getSliders()
          ],
        ),
      ),
    );
  }

  Map<String, double> get dataMap => {
        "BCD": val1,
        "GGG": val2,
        "SSS": val3,
        "RTT": val4,
        "RTT": val4,
        "DD": val4,
        "DDD": val4,
        "dss": val4,
        "dsd": val4,
      };

  Widget getSliders() {
    return Column(
      children: [
        Slider(
          value: val1 / 100,
          activeColor: Colors.red,
          min: 0.000,
          onChanged: (v) {
            setState(() {
              val1 = v * 100;
            });
          },
        ),
        Slider(
          value: val2 / 100,
          activeColor: Colors.yellow,
          min: 0.01,
          onChanged: (v) {
            setState(() {
              val2 = v * 100;
            });
          },
        ),
        Slider(
          value: val3 / 100,
          activeColor: Colors.grey,
          min: 0.00,
          onChanged: (v) {
            setState(() {
              val3 = v * 100;
            });
          },
        ),
        Slider(
          value: val4 / 100,
          activeColor: Colors.green,
          min: 0.01,
          onChanged: (v) {
            setState(() {
              val4 = v * 100;
            });
          },
        ),
      ],
    );
  }
}
