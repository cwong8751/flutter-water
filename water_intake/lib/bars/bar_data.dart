import 'package:water_intake/bars/individual_bar.dart';

class BarData{
  final double monWaterAmt;
  final double tueWaterAmt;
  final double wedWaterAmt;
  final double thuWaterAmt;
  final double friWaterAmt;
  final double satWaterAmt;
  final double sunWaterAmt;

  BarData({required this.sunWaterAmt, required this.monWaterAmt, required this.tueWaterAmt, required this.wedWaterAmt, required this.thuWaterAmt, required this.friWaterAmt, required this.satWaterAmt});


  List<IndividualBar> barData = [];

  void initBarData() {
    barData = [
      IndividualBar(x: 0, y: monWaterAmt),
      IndividualBar(x: 1, y: tueWaterAmt),
      IndividualBar(x: 2, y: wedWaterAmt),
      IndividualBar(x: 3, y: thuWaterAmt),
      IndividualBar(x: 4, y: friWaterAmt),
      IndividualBar(x: 5, y: satWaterAmt),
      IndividualBar(x: 6, y: sunWaterAmt),
    ];
  }
}