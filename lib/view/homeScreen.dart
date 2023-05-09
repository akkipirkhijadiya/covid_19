import 'package:covid_19/models/WorldStatesModel.dart';
import 'package:covid_19/view/searchScreen.dart';
import 'package:covid_19/viewModels/worldStateViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  worldStatesViewModel newWorldStatesViewModel = worldStatesViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: Text('Covid-19'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: newWorldStatesViewModel.worldstatesModelAPI(),
                builder: (context, AsyncSnapshot<worldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: Container(
                          child: Center(
                        child: SpinKitSpinningLines(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      )),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Reocverd': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
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
                              reuseableRow("Total Cases", snapshot.data!.cases),
                              reuseableRow("Deaths", snapshot.data!.deaths),
                              reuseableRow(
                                  "Recovered", snapshot.data!.recovered),
                              reuseableRow("Active", snapshot.data!.active),
                              reuseableRow("Critical", snapshot.data!.critical),
                              reuseableRow(
                                  "Today Cases", snapshot.data!.todayCases),
                              reuseableRow(
                                  "Today Deaths", snapshot.data!.todayDeaths),
                              reuseableRow("Today Recovered",
                                  snapshot.data!.todayRecovered),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          margin: EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => searchScreen()));
                            },
                            child: Text('Track Countires'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff1aa260)),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
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
