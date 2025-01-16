import 'package:spend_dream/bargraph/individualbar.dart';
import 'package:flutter/material.dart';

class BarData{
  final double janAmount;
  final double febAmount;
  final double marAmount;
  final double aprAmount;
  final double mayAmount;
  final double junAmount;
  final double julAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  BarData({
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
    
  });

  List<Individualbar> theREALDATA=[];
  
  void initializeBarData(){
    theREALDATA=[
      Individualbar(x: 0, y: janAmount),
      Individualbar(x: 1, y: febAmount),
      Individualbar(x: 2, y: marAmount),
      Individualbar(x: 3, y: aprAmount),
      Individualbar(x: 4, y: mayAmount),
      Individualbar(x: 5, y: junAmount),
      Individualbar(x: 6, y: julAmount),
      Individualbar(x: 7, y: augAmount),
      Individualbar(x: 8, y: sepAmount),
      Individualbar(x: 9, y: octAmount),
      Individualbar(x: 10, y: novAmount),
      Individualbar(x: 11, y: decAmount),
    
    ];

  }
  
}