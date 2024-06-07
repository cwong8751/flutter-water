import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/models/water_model.dart';
import 'package:http/http.dart' as http;

class WaterData extends ChangeNotifier {
  List<WaterModel> _waterDataList = [];

  List<WaterModel> get waterData => _waterDataList;

  void addWater(WaterModel model) async {
    final url = Uri.https(
        'water-intake-98ee9-default-rtdb.firebaseio.com', 'water.json');

    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'amount': model.amount,
          'unit': 'ml',
          'dateTime': model.dateTime.toString(),
        }));

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _waterDataList.add(WaterModel(
          id: extractedData['name'],
          amount: model.amount,
          dateTime: model.dateTime,
          unit: 'ml'));
    }
    else{
      print('Error: ${response.statusCode}');
    }

    notifyListeners();
  }

  Future<List<WaterModel>> getWater() async {
    final url = Uri.https(
        'water-intake-98ee9-default-rtdb.firebaseio.com', 'water.json');

    final response = await http.get(url);

    if (response.statusCode == 200 && response.body != 'null') {
      _waterDataList.clear();

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      _waterDataList = extractedData.entries.map((e) {
        return WaterModel(
          id: e.key,
          amount: e.value['amount'],
          dateTime: DateTime.parse(e.value['dateTime']),
          unit: e.value['unit'],
        );
      }).toList();
    }

    notifyListeners();
    return _waterDataList;
  }

  DateTime getStartOfWeek(){
    DateTime? startOfWeek;

    DateTime dateTime = DateTime.now();
    
    for(int i = 0; i < 7; i++){
      if(getWeekDay(dateTime.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek = dateTime.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  String getWeekDay(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default: 
        return '';
    }
  }

  void delete(WaterModel waterModel) {
    final url = Uri.https(
        'water-intake-98ee9-default-rtdb.firebaseio.com', 'water/${waterModel.id}.json');

        http.delete(url);

    _waterDataList.removeWhere((element) => element.id == waterModel.id);
    notifyListeners();

  }
}
