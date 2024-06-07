import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/bars/bar_graph.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/utils/date_helper.dart';

class WaterSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterSummary({super.key, required this.startOfWeek});

  double calculateMaxAmount(
      WaterData waterData,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday) {
    double maxAmount = 100;

    List<double> values = [
      waterData.calculateDailyWaterSummary()[monday] ?? 0,
      waterData.calculateDailyWaterSummary()[tuesday] ?? 0,
      waterData.calculateDailyWaterSummary()[wednesday] ?? 0,
      waterData.calculateDailyWaterSummary()[thursday] ?? 0,
      waterData.calculateDailyWaterSummary()[friday] ?? 0,
      waterData.calculateDailyWaterSummary()[saturday] ?? 0,
      waterData.calculateDailyWaterSummary()[sunday] ?? 0
    ];

    values.sort();

    // get largest value and calculate largest value
    maxAmount = values.last * 1.3;

    return maxAmount == 0 ? 100 : maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<WaterData>(
        builder: (context, value, child) => SizedBox(
            height: 200,
            child: BarGraph(
              maxY: calculateMaxAmount(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday),
              sunWaterAmt: value.calculateDailyWaterSummary()[sunday] ?? 0,
              monWaterAmt: value.calculateDailyWaterSummary()[monday] ?? 0,
              tueWaterAmt: value.calculateDailyWaterSummary()[tuesday] ?? 0,
              wedWaterAmt: value.calculateDailyWaterSummary()[wednesday] ?? 0,
              thuWaterAmt: value.calculateDailyWaterSummary()[thursday] ?? 0,
              friWaterAmt: value.calculateDailyWaterSummary()[friday] ?? 0,
              satWaterAmt: value.calculateDailyWaterSummary()[saturday] ?? 0,
            )));
  }
}
