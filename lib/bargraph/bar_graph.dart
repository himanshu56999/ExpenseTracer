import 'package:expense_tracker/bargraph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph(
      {super.key,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thrAmount,
      required this.friAmount,
      required this.satAmount,
      required this.maxY});

  @override
  Widget build(BuildContext context) {
    //initialize the bar data
    BarData mybarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thrAmount: thrAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    mybarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: const FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            //getTitlesWidget: getBottomTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: mybarData.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.grey[800],
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                  backDrawRodData: BackgroundBarChartRodData(
                      show: true, toY: maxY, color: Colors.grey[400]),
                ),
              ],
            ),
          )
          .toList(),
    ));
  }
}

/*
Widget getBottomTitles(
  double value,
  TitleMeta meta,
) {

  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(
        "S",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "M",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "T",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "W",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "T",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "F",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "S",
        style: style,
      );
      break;
    default:
      text = const Text(
        "ff",
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide,);
}



 */