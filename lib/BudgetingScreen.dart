import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:spend_dream/DateClass.dart';
import 'package:spend_dream/ExpensesScreen.dart';
import 'package:spend_dream/bargraph/bargraph.dart';
import 'app.dart';
import 'bargraph/bargraph.dart';

import 'package:fl_chart/fl_chart.dart';

class BudgetingPage extends StatefulWidget {
  const BudgetingPage({super.key});

  @override
  _BudgetingPageState createState() => _BudgetingPageState();
}

class _BudgetingPageState extends State<BudgetingPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int yearCategory;

    

    
    if (appState.tExpenses > 0) {
      return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                Card(
                    color: appState.scheme.primaryContainer,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total Spent: \$${appState.tExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: appState.scheme.onPrimaryContainer,
                        ),
                      ),
                    )),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            width: 500,
                            height: 500,
                            child: PieChart(
                              duration: Duration(milliseconds: 1000),
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: (appState.housingAmount) * 1.0,
                                    title: 'Housing',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.red,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value:
                                        (appState.transportationAmount) * 1.0,
                                    title: 'Transportation',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.blue,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.foodAmount) * 1.0,
                                    title: 'Food',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.green,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.utilitiesAmount) * 1.0,
                                    title: 'Utilities',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.orange,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.insuranceAmount) * 1.0,
                                    title: 'Insurance',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.purple,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.healthcareAmount) * 1.0,
                                    title: 'Healthcare',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.yellow,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.savingsAmount) * 1.0,
                                    title: 'Savings',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.cyan,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.personalAmount) * 1.0,
                                    title: 'Personal',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.pink,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.entertainmentAmount) * 1.0,
                                    title: 'Entertainment',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.grey,
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.miscAmount) * 1.0,
                                    title: 'Miscellaneous',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.blue[900],
                                    borderSide: BorderSide(
                                      width: 4.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            " Total Cumulative \n          Spend",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
                Container(height: 50, color: appState.scheme.tertiaryContainer),
                SizedBox(height: 30),
                DropdownMenu(
                  onSelected: (integer) {
                    if (integer != null) {
                      setState(() {
                        appState.yearNumber = integer;
                      });
                    }
                  },
                  width: 110,
                  menuHeight: 250,
                  initialSelection: 0,
                  helperText: "Select Year",
                  label: Text(
                    "Year",
                    style: TextStyle(fontSize: 10),
                  ),
                  enableSearch: true,
                  enableFilter: true,
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(
                        value: 0,
                        label: '${DateTime.now().year}',
                        labelWidget: Text('${DateTime.now().year}')),
                    DropdownMenuEntry(
                        value: 1,
                        label: '${DateTime.now().year - 1}',
                        labelWidget: Text('${DateTime.now().year - 1}')),
                    DropdownMenuEntry(
                        value: 2,
                        label: '${DateTime.now().year - 2}',
                        labelWidget: Text('${DateTime.now().year - 2}')),
                    DropdownMenuEntry(
                        value: 3,
                        label: '${DateTime.now().year - 3}',
                        labelWidget: Text('${DateTime.now().year - 3}')),
                    DropdownMenuEntry(
                        value: 4,
                        label: '${DateTime.now().year - 4}',
                        labelWidget: Text('${DateTime.now().year - 4}')),
                    DropdownMenuEntry(
                        value: 5,
                        label: '${DateTime.now().year - 5}',
                        labelWidget: Text('${DateTime.now().year - 5}')),
                    DropdownMenuEntry(
                        value: 6,
                        label: '${DateTime.now().year - 6}',
                        labelWidget: Text('${DateTime.now().year - 6}')),
                    DropdownMenuEntry(
                        value: 7,
                        label: '${DateTime.now().year - 7}',
                        labelWidget: Text('${DateTime.now().year - 7}')),
                    DropdownMenuEntry(
                        value: 8,
                        label: '${DateTime.now().year - 8}',
                        labelWidget: Text('${DateTime.now().year - 8}')),
                    DropdownMenuEntry(
                        value: 9,
                        label: '${DateTime.now().year - 9}',
                        labelWidget: Text('${DateTime.now().year - 9}')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (appState.yearNumber == -1) ...[
                  SizedBox(
                    height: 500,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("CHOOSE A YEAR"),
                      ],
                    ),
                  )
                ] else ...[
                  Row(children: [
                    SizedBox(width: 10),
                    if (appState.justtotalYearamount(appState.yearNumber) >
                        0) ...[
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SizedBox(
                              width: 500,
                              height: 500,
                              child: PieChart(
                                duration: Duration(milliseconds: 1000),
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Housing", appState.yearNumber),
                                      title: 'Housing',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.red,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Transportation",
                                          appState.yearNumber),
                                      title: 'Transportation',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.blue,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Food", appState.yearNumber),
                                      title: 'Food',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.green,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Utilities", appState.yearNumber),
                                      title: 'Utilities',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.orange,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Insurance", appState.yearNumber),
                                      title: 'Insurance',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.purple,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Healthcare", appState.yearNumber),
                                      title: 'Healthcare',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.yellow,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Savings", appState.yearNumber),
                                      title: 'Savings',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.cyan,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Personal", appState.yearNumber),
                                      title: 'Personal',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.pink,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Entertainment", appState.yearNumber),
                                      title: 'Entertainment',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.grey,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Miscellaneous", appState.yearNumber),
                                      title: 'Miscellaneous',
                                      radius: 100,
                                      titleStyle: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.blue[900],
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              " ${DateTime.now().year - appState.yearNumber} Cumulative \n          Spend",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 500,
                            width: 375,
                            child: Card.outlined(
                              //color: Colors.blue,
                              borderOnForeground: false,
                              //shape: BoxShape.rectangle,
                              elevation: 9,
                              surfaceTintColor: Colors.red,
                            ),
                          ),
                          Column(
                            children: [
                              Text("No expenses recorded in \n                   ${DateTime.now().year-appState.yearNumber}!",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    appState.changeScreenIndex(1);
                                  });
                                },
                                child: Text(
                                  "Add more expenses",
                                  style: TextStyle(
                                      color:
                                          appState.scheme.onSecondaryContainer),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(appState
                                            .scheme.secondaryContainer)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    SizedBox(width: 30),
                  ]),
                ],
                Container(height: 50, color: appState.scheme.tertiaryContainer),
                SizedBox(height: 30),
                DropdownMenu(
                  onSelected: (integer) {
                    if (integer != null) {
                      setState(() {
                        appState.yearNumberBar = integer;
                        //don't know what to do here yet
                      });
                    }
                  },
                  width: 110,
                  menuHeight: 250,
                  helperText: "Select Year",
                  label: Text(
                    "Year",
                    style: TextStyle(fontSize: 10),
                  ),
                  initialSelection: 0,
                  enableSearch: true,
                  enableFilter: true,
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(
                        value: 0,
                        label: '${DateTime.now().year}',
                        labelWidget: Text('${DateTime.now().year}')),
                    DropdownMenuEntry(
                        value: 1,
                        label: '${DateTime.now().year - 1}',
                        labelWidget: Text('${DateTime.now().year - 1}')),
                    DropdownMenuEntry(
                        value: 2,
                        label: '${DateTime.now().year - 2}',
                        labelWidget: Text('${DateTime.now().year - 2}')),
                    DropdownMenuEntry(
                        value: 3,
                        label: '${DateTime.now().year - 3}',
                        labelWidget: Text('${DateTime.now().year - 3}')),
                    DropdownMenuEntry(
                        value: 4,
                        label: '${DateTime.now().year - 4}',
                        labelWidget: Text('${DateTime.now().year - 4}')),
                    DropdownMenuEntry(
                        value: 5,
                        label: '${DateTime.now().year - 5}',
                        labelWidget: Text('${DateTime.now().year - 5}')),
                    DropdownMenuEntry(
                        value: 6,
                        label: '${DateTime.now().year - 6}',
                        labelWidget: Text('${DateTime.now().year - 6}')),
                    DropdownMenuEntry(
                        value: 7,
                        label: '${DateTime.now().year - 7}',
                        labelWidget: Text('${DateTime.now().year - 7}')),
                    DropdownMenuEntry(
                        value: 8,
                        label: '${DateTime.now().year - 8}',
                        labelWidget: Text('${DateTime.now().year - 8}')),
                    DropdownMenuEntry(
                        value: 9,
                        label: '${DateTime.now().year - 9}',
                        labelWidget: Text('${DateTime.now().year - 9}')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (appState.yearNumberBar == -1) ...[
                  SizedBox(
                    height: 500,
                    child: BarChart(BarChartData())
                  )
                ] else ...[
                  
                  //add bar chart
                  //need to make a DATA class
                  
                  SizedBox(
                    height:500,
                    child:MyBarGraph(yearChosen: appState.yearNumberBar,),
                  ),
                  
                
                ],
                SizedBox(height:30),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                Card(
                    color: appState.scheme.primaryContainer,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total Spent: \$${appState.tExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: appState.scheme.onPrimaryContainer,
                        ),
                      ),
                    )),
                SizedBox(height: 35),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 500,
                            width: 375,
                            child: Card.outlined(
                              //color: Colors.blue,
                              borderOnForeground: false,
                              //shape: BoxShape.rectangle,
                              elevation: 9,
                              surfaceTintColor: Colors.red,
                            ),
                          ),
                          Column(
                            children: [
                              Text("No expenses recorded yet!",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  " Start tracking your spending to get insights and stay on top \n of your finances.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    appState.changeScreenIndex(1);
                                  });
                                },
                                child: Text(
                                  "Add your first expense now!",
                                  style: TextStyle(
                                      color:
                                          appState.scheme.onSecondaryContainer),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(appState
                                            .scheme.secondaryContainer)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

//display the total spent
//
//have scroll 
//first show the cumualtive pie chart 
//then show pie chart of the annual one, have dropdwon for displaying year
//then show bar chart for how much u spent in each month for a current selected year determined by dorpdwon

//in the middle of each chart, have the descitioion of chart through the stack widget

//maybe do 50-20-30 rule (50 on need, 30 on wants, 20 on savings)
//Needs:Housing,Transportation,Food,Utilities,Insurance, Healthcare,
//Wants: Food also kinda,Personal, Entertainment, 
//Savings: Savings
