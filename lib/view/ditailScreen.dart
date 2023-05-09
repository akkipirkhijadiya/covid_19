import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ditailsScreen extends StatefulWidget {
  String flagURL;
  String counName;
  int totalcase;
  int deaths;
  int recovered;
  int active;
  int critical;
  int todayCases;
  int todayDeaths;
  int todayRecovered;

  ditailsScreen(
      this.flagURL,
      this.counName,
      this.totalcase,
      this.deaths,
      this.recovered,
      this.active,
      this.critical,
      this.todayCases,
      this.todayDeaths,
      this.todayRecovered);

  @override
  State<ditailsScreen> createState() => _ditailsScreenState();
}

class _ditailsScreenState extends State<ditailsScreen> {
  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.flagURL,
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.counName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  PieChart(
                    dataMap: {
                      'Total': double.parse(widget.totalcase.toString()),
                      'Reocverd': double.parse(widget.recovered.toString()),
                      'Deaths': double.parse(widget.deaths.toString()),
                    },
                    colorList: colorList,
                    animationDuration: Duration(milliseconds: 1200),
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 25,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        reuseableRow("Total Cases", widget.totalcase),
                        reuseableRow("Deaths", widget.deaths),
                        reuseableRow("Recovered", widget.recovered),
                        reuseableRow("Active", widget.active),
                        reuseableRow("Critical", widget.critical),
                        reuseableRow("Today Cases", widget.todayCases),
                        reuseableRow("Today Deaths", widget.todayDeaths),
                        reuseableRow("Today Recovered", widget.todayRecovered),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget reuseableRow(title, data) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString() + ' :',
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.bold),
            ),
            Text(
              data.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade500,
        ),
      ],
    );
  }
}
