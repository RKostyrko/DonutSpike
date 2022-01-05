import 'dart:async';

import 'package:charts_common/common.dart' as common;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartsFlutterPoc extends StatefulWidget {
  @override
  State<ChartsFlutterPoc> createState() => _ChartsFlutterPocState();
}

class _ChartsFlutterPocState extends State<ChartsFlutterPoc> {
  double val1 = 20;
  double val2 = 21;
  double val3 = 22;
  double val4 = 23;
  String centerText = "";
  late StreamController<String> centerTextController;

  @override
  void initState() {
    super.initState();
    centerTextController = StreamController();
  }

  @override
  void dispose() {
    centerTextController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Charts Flutter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  child: SizedBox(
                    child: charts.PieChart<String>(_data(val1, val2, val3, val4),
                        layoutConfig: charts.LayoutConfig(
                            leftMarginSpec: common.MarginSpec.fixedPixel(50),
                            rightMarginSpec: common.MarginSpec.fixedPixel(50),
                            topMarginSpec: common.MarginSpec.fixedPixel(50),
                            bottomMarginSpec: common.MarginSpec.fixedPixel(50)),
                        animate: false,
                        behaviors: [charts.DomainHighlighter(common.SelectionModelType.info), charts.SelectNearest()],
                        selectionModels: [
                          charts.SelectionModelConfig(
                              type: common.SelectionModelType.info,
                              changedListener: (e) {
                                print("selected ${(e.selectedDatum.first.datum as StockModel).name}");
                                centerTextController.sink.add((e.selectedDatum.first.datum as StockModel).name);
                                // setState(() {
                                //   centerText = (e.selectedDatum.first.datum as StockModel).name;
                                // });
                              })
                        ],
                        defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 50,
                          minHoleWidthForCenterContent: 100,
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.auto,
                            )
                          ],
                        )),
                    height: 400,
                  ),
                  alignment: Alignment.center,
                ),
                StreamBuilder<String>(
                    stream: centerTextController.stream,
                    builder: (context, snapshot) {
                      return getCenter(snapshot.data ?? "");
                    }),
              ],
            ),
            getSliders()
          ],
        ),
      ),
    );
  }

  static List<charts.Series<StockModel, String>> _data(double val1, val2, val3, val4) {
    final data = [
      StockModel("TSL", val1, const common.Color(r: 255, g: 0, b: 0)),
      StockModel("ASL", val2, const common.Color(r: 0, g: 255, b: 0)),
      StockModel("DSD", val3, const common.Color(r: 165, g: 42, b: 42)),
      StockModel("BBB", val4, const common.Color(r: 0, g: 255, b: 255)),
      StockModel("ААА", val4, const common.Color(r: 0, g: 255, b: 255)),
      StockModel("GGG", val4, const common.Color(r: 0, g: 255, b: 255)),
    ];

    return [
      charts.Series<StockModel, String>(
        id: 'Stocks',
        displayName: "Name",
        patternColorFn: (StockModel stock, _) => common.Color(r: 0, g: 0, b: 0),
        colorFn: (StockModel stock, _) => stock.color,
        domainFn: (StockModel stock, _) => stock.name,
        measureFn: (StockModel stock, _) => stock.value,
        data: data,
      )
    ];
  }

  Widget getCenter(String text) {
    return Align(
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(text),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      alignment: Alignment.center,
    );
  }

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
          min: 0.00,
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
          min: 0.00,
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

class StockModel {
  final String name;
  final double value;
  final common.Color color;

  StockModel(this.name, this.value, this.color);
}
