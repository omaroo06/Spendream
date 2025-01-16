import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'ExpensesClass.dart';
import 'DateClass.dart';
import 'auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Expense Tracker App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 28, 229, 149)),
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String username = "omaroo06";
  String password = "secretPassword";
  int budget = 100;
  String firstName = "Omar";
  String lastName = "Jawaid";
  List<Expenses> listOfExpenses = <Expenses>[];

  double amountSpentInMonthInGivenYear(int monh,int y){
    int length=listOfExpenses.length;
    double sum=0;
    for(int i=0;i<length;i++){
      if((listOfExpenses[i].date.month==monh)&&(listOfExpenses[i].date.year==DateTime.now().year-y)){
        sum+=listOfExpenses[i].amount;
      }
    }
    return sum;
  }
  
  double mostSpentInMonthInGivenYear(int ye){
     int length=listOfExpenses.length;
     double max=amountSpentInMonthInGivenYear(1, ye);
     if(justtotalYearamount(ye)==0){
      return 5000;
     }

     for(int i=1;i<=12;i++){
        if(amountSpentInMonthInGivenYear(i, ye)>max){
          max=amountSpentInMonthInGivenYear(i, ye);
        }
     }
     return max;
  }

  double totalCurrentYear(String cat,int y){
    int length=listOfExpenses.length;
    double sum=0;
    for(int i=0;i<length;i++){
      if((listOfExpenses[i].category==cat)&&(listOfExpenses[i].date.year==DateTime.now().year-y)){
        sum+=listOfExpenses[i].amount;
      }
    }
    return sum;    
  }

  double justtotalYearamount(int y){
    int length=listOfExpenses.length;
    double sum=0;
    for(int i=0;i<length;i++){
      if(listOfExpenses[i].date.year==DateTime.now().year-y){
        sum+=listOfExpenses[i].amount;
      }
    }
    return sum;   
  }

  int yearNumber=0;
  
  int yearNumberBar=0;

  int screenIndexx=0;

  double housingAmount = 0;
  double transportationAmount = 0;
  double foodAmount = 0;
  double utilitiesAmount = 0;
  double insuranceAmount = 0;
  double healthcareAmount = 0;
  double savingsAmount = 0;
  double personalAmount = 0;
  double entertainmentAmount = 0;
  double miscAmount = 0;




  void changeScreenIndex(int amount){
    screenIndexx=amount;
    notifyListeners();
  }
  
  void addToHousingAmount(double amount) {
    housingAmount += amount;
    notifyListeners();
  }

  void removeHousingAmount(double amount) {
    housingAmount -= amount;
    notifyListeners();
  }

  void addToTransportationAmount(double amount) {
    transportationAmount += amount;
    notifyListeners();
  }

  void removeTransportationAmount(double amount) {
    transportationAmount -= amount;
    notifyListeners();
  }

  void addToFoodAmount(double amount) {
    foodAmount += amount;
    notifyListeners();
  }

  void removeFoodAmount(double amount) {
    foodAmount -= amount;
    notifyListeners();
  }

  void addToUtilitiesAmount(double amount) {
    utilitiesAmount += amount;
    notifyListeners();
  }

  void removeUtilitiesAmount(double amount) {
    utilitiesAmount -= amount;
    notifyListeners();
  }

  void addToInsuranceAmount(double amount) {
    insuranceAmount += amount;
    notifyListeners();
  }

  void removeInsuranceAmount(double amount) {
    insuranceAmount -= amount;
    notifyListeners();
  }

  void addToHealthcareAmount(double amount) {
    healthcareAmount += amount;
    notifyListeners();
  }

  void removeHealthcareAmount(double amount) {
    healthcareAmount -= amount;
    notifyListeners();
  }

  void addToSavingsAmount(double amount) {
    savingsAmount += amount;
    notifyListeners();
  }

  void removeSavingsAmount(double amount) {
    savingsAmount -= amount;
    notifyListeners();
  }

  void addToPersonalAmount(double amount) {
    personalAmount += amount;
    notifyListeners();
  }

  void removePersonalAmount(double amount) {
    personalAmount -= amount;
    notifyListeners();
  }

  void addToEntertainmentAmount(double amount) {
    entertainmentAmount += amount;
    notifyListeners();
  }

  void removeEntertainmentAmount(double amount) {
    entertainmentAmount -= amount;
    notifyListeners();
  }

  void addToMiscAmount(double amount) {
    miscAmount += amount;
    notifyListeners();
  }

  void removeMiscAmount(double amount) {
    miscAmount -= amount;
    notifyListeners();
  }

  var colorForEditButton;
  var colorForDeleteButton;

  double tExpenses = 0.00;

  void addToTotalExpenses(double amount) {
    tExpenses = tExpenses + amount;
    notifyListeners();
  }

  void deleteFromTotalExpenses(double amount) {
    tExpenses = tExpenses - amount;
    notifyListeners();
  }

  ColorScheme scheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 229, 149));

  void changeUsername(String n) {
    username = n;
    notifyListeners();
  }

  void changePassword(String n) {
    password = n;
    notifyListeners();
  }

  void changefirstName(String n) {
    firstName = n;
    notifyListeners();
  }

  void changelastName(String n) {
    lastName = n;
    notifyListeners();
  }

  void changeBudget(int i) {
    budget = i;
    notifyListeners();
  }

  void addExpense(Expenses a) {
    listOfExpenses.add(a);
  }

  double getAmount(Expenses a) {
    return a.amount;
  }

  String getCategory(Expenses a) {
    return a.category;
  }

  Date getDate(Expenses a) {
    return a.date;
  }
}
