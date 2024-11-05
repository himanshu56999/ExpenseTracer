import 'individul_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAmount;
  final double satAmount;


  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thrAmount,
      required this.friAmount,
      required this.satAmount});

  List<IndividualBar>barData=[];
  // initialize bar data

void initializeBarData(){
  barData=[
    //sun
    IndividualBar(x: 0, y: sunAmount),
    //mon
    IndividualBar(x: 1, y: monAmount),
    //tue
    IndividualBar(x: 2, y: tueAmount),
    //wed
    IndividualBar(x: 3, y: wedAmount),
    //thr
    IndividualBar(x: 4, y: thrAmount),
    //fri
    IndividualBar(x: 5, y: friAmount),
    //sat
    IndividualBar(x: 6, y: satAmount),

  ];

}


}
