import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/bars/bar_graph.dart';
import 'package:water_intake/data/water_data.dart';

class WaterSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(builder: (context, value, child) => const SizedBox(height: 200, child: BarGraph(maxY: 100, sunWaterAmt: 19, monWaterAmt: 34, tueWaterAmt: 56, wedWaterAmt: 72, thuWaterAmt: 85, friWaterAmt: 96, satWaterAmt: 102,)));
  }
}