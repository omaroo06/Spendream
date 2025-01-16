import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'bardata.dart';
import 'package:spend_dream/app.dart';
import 'package:provider/provider.dart';


class MyBarGraph extends StatelessWidget {
  //const MyBarGraph({super.key});
  final int yearChosen;
 
  MyBarGraph({
    required this.yearChosen
  });


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    BarData thebardata=BarData(janAmount: appState.amountSpentInMonthInGivenYear(1, yearChosen), febAmount: appState.amountSpentInMonthInGivenYear(2, yearChosen), marAmount: appState.amountSpentInMonthInGivenYear(3, yearChosen), aprAmount: appState.amountSpentInMonthInGivenYear(4, yearChosen), mayAmount: appState.amountSpentInMonthInGivenYear(5, yearChosen), junAmount: appState.amountSpentInMonthInGivenYear(6, yearChosen), julAmount: appState.amountSpentInMonthInGivenYear(7, yearChosen), augAmount: appState.amountSpentInMonthInGivenYear(8, yearChosen), sepAmount: appState.amountSpentInMonthInGivenYear(9, yearChosen), octAmount: appState.amountSpentInMonthInGivenYear(10, yearChosen), novAmount: appState.amountSpentInMonthInGivenYear(11, yearChosen), decAmount: appState.amountSpentInMonthInGivenYear(12, yearChosen));
    thebardata.initializeBarData();
    return BarChart(BarChartData(
      maxY: appState.mostSpentInMonthInGivenYear(yearChosen),
      minY: 0,
      alignment: BarChartAlignment.spaceEvenly,
      titlesData:FlTitlesData(
        show:true,
        bottomTitles:AxisTitles(
          axisNameWidget: Text('Months',style:TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
          axisNameSize: 34,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget:(value,meta){
              final listOfMonths=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
               
              final index=value.toInt()%listOfMonths.length;

              final month=listOfMonths[index];
              return SideTitleWidget(child: Text(month,style:TextStyle(fontSize: 11,fontStyle: FontStyle.italic,)), axisSide: AxisSide.bottom,space:4);
            }
          ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          //leftTitles: AxisTitles(axisNameWidget: Text("Amount (\$)"))
        ),
        
      
      gridData: FlGridData(show: false),
      borderData: FlBorderData(
        show:true,
        
      ),
      groupsSpace: 2,
      barGroups:thebardata.theREALDATA
        .map(
          (data)=>BarChartGroupData(
          
            x:data.x,
            
            barRods: [BarChartRodData(toY: data.y,width: 10,color:Colors.red)]
          
          )
        )
        .toList()
    ));
   
  }
}
