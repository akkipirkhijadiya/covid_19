import 'dart:convert';

import 'package:covid_19/models/WorldStatesModel.dart';
import 'package:covid_19/viewModels/utilities/url.dart';
import 'package:http/http.dart' as http;

class worldStatesViewModel {
  Future<worldStatesModel> worldstatesModelAPI() async {
    final responce = await http.get(Uri.parse(appURL.worldStates));
    var data = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      return worldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final responce = await http.get(Uri.parse(appURL.contryesList));
    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body.toString());
      return data;
    } else {
      return data;
    }
  }
}
