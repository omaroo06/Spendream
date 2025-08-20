import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:spend_dream/DateClass.dart';
import 'package:spend_dream/ExpensesScreen.dart';
import 'package:spend_dream/bargraph/bargraph.dart';
import 'app.dart';
import 'bargraph/bargraph.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:fl_chart/fl_chart.dart';

class BudgetingPage extends StatefulWidget {
  const BudgetingPage({super.key});

  @override
  _BudgetingPageState createState() => _BudgetingPageState();
}

class _BudgetingPageState extends State<BudgetingPage> {
  
   bool isTouchedhouse=false;
   bool isTouchedutil=false;
   bool isTouchedinsur=false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int yearCategory;
    double scalee=appState.scale;
    double scaleW=appState.scaleWidth;
    double scaleH=appState.scaleHeight;
    
  
    
    if(appState.loadingForBudget){
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }
    else{
    if (appState.totalExpenses > 0) {
      return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80*scaleH),
                Card(
                    color: appState.scheme.primaryContainer,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total Spent: \$${appState.totalExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24*scaleW,
                          fontWeight: FontWeight.bold,
                          color: appState.scheme.onPrimaryContainer,
                        ),
                      ),
                    )),
                Row(
                  children: [
                    SizedBox(width: 20*scaleW),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            width: 500*scaleW,
                            height: 500*scaleW,
                            child: PieChart(
                              duration: Duration(milliseconds: 1000),
                        
                              PieChartData(
                             
                                borderData: FlBorderData(show:false),
                                sectionsSpace: 2,
                                
                                sections: [
                                  
                                  PieChartSectionData(
                                    
                                    value: (appState.housingAmount) * 1.0,
                                     
                                    title: 'Housing',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.red,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                    titlePositionPercentageOffset:(((appState.housingAmount)*1.0/appState.totalExpenses)>23)? 1.3:0.5,
                                  
                                    
                                
                                  ),
                                  PieChartSectionData(
                                    value:
                                        (appState.transportationAmount) * 1.0,
                                    title: 'Transportation',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.blue,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.foodAmount) * 1.0,
                                    title: 'Food',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.green,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.utilitiesAmount) * 1.0,
                                    title: 'Utilities',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.orange,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.insuranceAmount) * 1.0,
                                    title: 'Insurance',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.purple,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.healthcareAmount) * 1.0,
                                    title: 'Healthcare',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.yellow,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.savingsAmount) * 1.0,
                                    title: 'Savings',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.cyan,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.personalAmount) * 1.0,
                                    title: 'Personal',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.pink,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.entertainmentAmount) * 1.0,
                                    title: 'Entertainment',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.grey,
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (appState.miscAmount) * 1.0,
                                    title: 'Miscellaneous',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.blue[900],
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value:(appState.recurringAmount) * 1.0,
                                    title: 'Recurring',
                                    radius: 100*scaleW,
                                    titleStyle: TextStyle(
                                        fontSize: 10*scaleW,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.green[900],
                                    borderSide: BorderSide(
                                      width: 4.0*scaleW,
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
                                fontWeight: FontWeight.bold, fontSize: 18*scaleW),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20*scaleW)
                  ],
                ),
                SizedBox(height: 30*scaleH),
                Container(height: 50*scaleH, color: appState.scheme.tertiaryContainer),
                SizedBox(height: 30*scaleH),
                DropdownMenu(
                  onSelected: (integer) {
                    if (integer != null) {
                      setState(() {
                        appState.yearNumber = integer;
                      });
                    }
                  },
                  width: 110*scaleW,
                  menuHeight: 250,
                  initialSelection: 0,
                  textStyle: TextStyle(fontSize: 10*scaleW),
                  helperText: "Select Year",
                  label: Text(
                    "Year",
                    style: TextStyle(fontSize: 10*scaleW),
                  ),
                  
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(
                        value: 0,
                        label: '${DateTime.now().year}',
                        labelWidget: Text('${DateTime.now().year}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 1,
                        label: '${DateTime.now().year - 1}',
                        labelWidget: Text('${DateTime.now().year - 1}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 2,
                        label: '${DateTime.now().year - 2}',
                        labelWidget: Text('${DateTime.now().year - 2}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 3,
                        label: '${DateTime.now().year - 3}',
                        labelWidget: Text('${DateTime.now().year - 3}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 4,
                        label: '${DateTime.now().year - 4}',
                        labelWidget: Text('${DateTime.now().year - 4}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 5,
                        label: '${DateTime.now().year - 5}',
                        labelWidget: Text('${DateTime.now().year - 5}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 6,
                        label: '${DateTime.now().year - 6}',
                        labelWidget: Text('${DateTime.now().year - 6}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 7,
                        label: '${DateTime.now().year - 7}',
                        labelWidget: Text('${DateTime.now().year - 7}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 8,
                        label: '${DateTime.now().year - 8}',
                        labelWidget: Text('${DateTime.now().year - 8}',style: TextStyle(fontSize: 14*scaleW),)),
                    DropdownMenuEntry(
                        value: 9,
                        label: '${DateTime.now().year - 9}',
                        labelWidget: Text('${DateTime.now().year - 9}',style: TextStyle(fontSize: 14*scaleW),)),
                  ],
                ),
                SizedBox(
                  height: 20*scaleH,
                ),
                if (appState.yearNumber == -1) ...[
                  SizedBox(
                    height: 500*scaleH,
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("CHOOSE A YEAR"),
                      ],
                    ),
                  )
                ] else ...[
                  Row(children: [
                    SizedBox(width: 20*scaleW),
                    if (appState.justtotalYearamount(appState.yearNumber) >
                        0) ...[
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SizedBox(
                              width: 500*scaleW,
                              height: 500*scaleW,
                              child: PieChart(
                                duration: Duration(milliseconds: 1000),
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Housing", appState.yearNumber),
                                      title: 'Housing',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.red,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Transportation",
                                          appState.yearNumber),
                                      title: 'Transportation',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.blue,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Food", appState.yearNumber),
                                      title: 'Food',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.green,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Utilities", appState.yearNumber),
                                      title: 'Utilities',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.orange,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Insurance", appState.yearNumber),
                                      title: 'Insurance',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.purple,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Healthcare", appState.yearNumber),
                                      title: 'Healthcare',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.yellow,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Savings", appState.yearNumber),
                                      title: 'Savings',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.cyan,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Personal", appState.yearNumber),
                                      title: 'Personal',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.pink,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Entertainment", appState.yearNumber),
                                      title: 'Entertainment',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.grey,
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Miscellaneous", appState.yearNumber),
                                      title: 'Miscellaneous',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.blue[900],
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      value: appState.totalCurrentYear(
                                          "Recurring", appState.yearNumber),
                                      title: 'Recurring',
                                      radius: 100*scaleW,
                                      titleStyle: TextStyle(
                                          fontSize: 10*scaleW,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.green[900],
                                      borderSide: BorderSide(
                                        width: 4.0*scaleW,
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
                                  fontWeight: FontWeight.bold, fontSize: 18*scaleW),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 500*scaleW,
                            width: 375*scaleH,
                            child: const Card.outlined(
                              
                              borderOnForeground: false,
                              
                              elevation: 9,
                              surfaceTintColor: Colors.red,
                            ),
                          ),
                          Column(
                            children: [
                              Text("No expenses recorded in \n                   ${DateTime.now().year-appState.yearNumber}!",
                                  style: TextStyle(
                                      fontSize: 25*scaleW,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 20*scaleH),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    appState.changeScreenIndex(1);
                                  });
                                },
                                style: ButtonStyle(
                                  
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(appState
                                            .scheme.secondaryContainer)),
                                
                                child: Text(
                                  "Add more expenses",
                                  style: TextStyle(
                                      color:
                                          appState.scheme.onSecondaryContainer,fontSize: 14*scaleW),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    SizedBox(width: 20*scaleW),
                  ]),
                ],
                SizedBox(height: 30*scaleH),
                Container(height: 50*scaleH, color: appState.scheme.tertiaryContainer),
                SizedBox(height: 30*scaleH),
                DropdownMenu(
                  onSelected: (integer) {
                    if (integer != null) {
                      setState(() {
                        appState.yearNumberBar = integer;
                        
                      });
                    }
                  },
                  width: 110*scaleW,
                  menuHeight: 250,
                  textStyle: TextStyle(fontSize: 10*scaleW),
                  helperText: "Select Year",
                  label: Text(
                    "Year",
                    style: TextStyle(fontSize: 10*scaleW),
                  ),
                  initialSelection: 0,
                  
                  dropdownMenuEntries: <DropdownMenuEntry<int>>[
                    DropdownMenuEntry(
                        value: 0,
                        label: '${DateTime.now().year}',
                        labelWidget: Text('${DateTime.now().year}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 1,
                        label: '${DateTime.now().year - 1}',
                        labelWidget: Text('${DateTime.now().year - 1}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 2,
                        label: '${DateTime.now().year - 2}',
                        labelWidget: Text('${DateTime.now().year - 2}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 3,
                        label: '${DateTime.now().year - 3}',
                        labelWidget: Text('${DateTime.now().year - 3}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 4,
                        label: '${DateTime.now().year - 4}',
                        labelWidget: Text('${DateTime.now().year - 4}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 5,
                        label: '${DateTime.now().year - 5}',
                        labelWidget: Text('${DateTime.now().year - 5}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 6,
                        label: '${DateTime.now().year - 6}',
                        labelWidget: Text('${DateTime.now().year - 6}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 7,
                        label: '${DateTime.now().year - 7}',
                        labelWidget: Text('${DateTime.now().year - 7}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 8,
                        label: '${DateTime.now().year - 8}',
                        labelWidget: Text('${DateTime.now().year - 8}',style:TextStyle(fontSize: 14*scaleW))),
                    DropdownMenuEntry(
                        value: 9,
                        label: '${DateTime.now().year - 9}',
                        labelWidget: Text('${DateTime.now().year - 9}',style:TextStyle(fontSize: 14*scaleW))),
                  ],
                ),
                SizedBox(
                  height: 20*scaleH,
                ),
                
                if (appState.yearNumberBar == -1) ...[
                  Row(children: [SizedBox(width:20*scaleW),
                  SizedBox(
                    height: 500*scaleH,
                    child: BarChart(BarChartData())
                  ),
                  SizedBox(width:20*scaleW)
                  ],)
                  
                ] else ...[
                   
                  SizedBox(
                    height:500*scaleH,
                    child:MyBarGraph(yearChosen: appState.yearNumberBar,),
                  ),
                  
                 
                 
                  
                  
                   
                
                ],
                SizedBox(height:30*scaleH),
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
                SizedBox(height: 80*scaleH),
                Card(
                    color: appState.scheme.primaryContainer,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total Spent: \$${appState.tExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24*scaleW,
                          fontWeight: FontWeight.bold,
                          color: appState.scheme.onPrimaryContainer,
                        ),
                      ),
                    )),
                SizedBox(height: 35*scaleH),
                Row(
                  children: [
                    SizedBox(width: 20*scaleW),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 500*scaleH,
                            width: 375*scaleW,
                            child: const Card.outlined(
                             
                              borderOnForeground: false,
                              
                              elevation: 9,
                              surfaceTintColor: Colors.red,
                            ),
                          ),
                          Column(
                            children: [
                              Text("No expenses recorded yet!",
                                  style: TextStyle(
                                      fontSize: 25*scaleW,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  " Start tracking your spending to get insights and stay on top \n of your finances.",
                                  style: TextStyle(
                                      fontSize: 12*scaleW,
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 20*scaleH),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    appState.changeScreenIndex(1);
                                  });
                                },
                                style: ButtonStyle(
                                  
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(appState
                                            .scheme.secondaryContainer)),
                                child: Text(
                                  "Add your first expense now!",
                                  style: TextStyle(fontSize: 14*scaleW,
                                      color:
                                          appState.scheme.onSecondaryContainer),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20*scaleW)
                  ],
                ),
                SizedBox(
                  height: 100*scaleH,
                ),
              ],
            ),
          ),
        ),
      );
    }
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
