import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlChartPoc extends StatefulWidget {
  @override
  State<FlChartPoc> createState() => _FlChartPocState();
}

class _FlChartPocState extends State<FlChartPoc> {
  Map<String, double> stocks = {
    "ST1": 20,
    "ST2": 20,
    "ST3": 20,
    "ST4": 20,
    "ST5": 20,
  };

  List<Color> colors = [
    const Color(0xff0293ee),
    const Color(0xfff8b250),
    const Color(0xff845bef),
    const Color(0xff13d38e),
    Colors.red
  ];

  String selectedStock = "";
  bool showTitles = false;
  bool showBadges = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlChart"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getControls(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    getCenter(),
                    PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback: (event, response) {
                            setState(() {
                              // if (!event.isInterestedForInteractions ||
                              //     response == null ||
                              //     response.touchedSection == null) {
                              //   selectedStock = "";
                              //   return;
                              // }
                              int i = response?.touchedSection?.touchedSectionIndex ?? -1;
                              selectedStock = i >= 0 ? stocks.keys.toList()[i] : "";
                            });
                          }),
                          sectionsSpace: 1,
                          sections: List.generate(
                              5,
                              (index) => PieChartSectionData(
                                  value: stocks.values.toList()[index],
                                  color: colors[index],
                                  showTitle: showTitles,
                                  radius: stocks.keys.toList()[index] == selectedStock ? 60 : 50,
                                  title: stocks.values.toList()[index].toStringAsFixed(2),
                                  badgeWidget: showBadges ? Text(stocks.keys.toList()[index]) : null,
                                  badgePositionPercentageOffset: 1.4
                                  // borderSide: stocks.keys.toList()[index] == selectedStock
                                  //     ? BorderSide(color: colors[index], width: 6)
                                  //     : const BorderSide(color: Colors.transparent),
                                  ))),
                      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
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

  Widget getControls() {
    return Row(children: [
      Checkbox(
          value: showTitles,
          onChanged: (val) {
            setState(() {
              showTitles = val ?? false;
            });
          }),
      const Text("ShowTitles"),
      const SizedBox(
        width: 50,
      ),
      Checkbox(
          value: showBadges,
          onChanged: (val) {
            setState(() {
              showBadges = val ?? false;
            });
          }),
      const Text("ShowTitles"),
    ]);
  }

  Widget getCenter() {
    return Align(
      child: Column(
        children: [
          Text(
            selectedStock,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            selectedStock,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(selectedStock),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      alignment: Alignment.center,
    );
  }

  Widget getSlider(String stock) {
    return Column(
      children: [
        Text(stock),
        Slider(
          value: stocks[stock]! / 100,
          activeColor: Colors.red,
          min: 0.000,
          onChanged: (v) {
            setState(() {
              stocks[stock] = v * 100;
            });
          },
        ),
      ],
    );
  }

  Widget getSliders() {
    return Column(
      children: stocks.keys.map((e) => getSlider(e)).toList(),
    );
  }
}
