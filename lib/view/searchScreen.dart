import 'package:covid_19/view/ditailScreen.dart';
import 'package:covid_19/viewModels/worldStateViewModel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  worldStatesViewModel newWorldStateViewModel = worldStatesViewModel();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'search Country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: FutureBuilder(
              future: newWorldStateViewModel.countriesListApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsetsDirectional.zero,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey,
                          child: Column(children: [
                            ListTile(
                                title: Container(
                                  height: 10,
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width:
                                      MediaQuery.of(context).size.width - 250,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.white,
                                )),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade800,
                            )
                          ]),
                        );
                      });
                } else {
                  return ListView.builder(
                      padding: EdgeInsetsDirectional.zero,
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ditailsScreen(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'],
                                            snapshot.data![index]['country'],
                                            snapshot.data![index]['cases'],
                                            snapshot.data![index]['deaths'],
                                            snapshot.data![index]['recovered'],
                                            snapshot.data![index]['active'],
                                            snapshot.data![index]['critical'],
                                            snapshot.data![index]['todayCases'],
                                            snapshot.data![index]
                                                ['todayDeaths'],
                                            snapshot.data![index]
                                                ['todayRecovered'])));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade800,
                            )
                          ]);
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ditailsScreen(
                                            snapshot.data![index]['countryInfo']
                                                    ['flag']
                                                .toString(),
                                            snapshot.data![index]['country']
                                                .toString(),
                                            snapshot.data![index]['cases'],
                                            snapshot.data![index]['deaths'],
                                            snapshot.data![index]['recovered'],
                                            snapshot.data![index]['active'],
                                            snapshot.data![index]['critical'],
                                            snapshot.data![index]['todayCases'],
                                            snapshot.data![index]
                                                ['todayDeaths'],
                                            snapshot.data![index]
                                                ['todayRecovered'])));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade800,
                            )
                          ]);
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
