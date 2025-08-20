import 'package:cloud_firestore/cloud_firestore.dart';

import 'DateClass.dart';

class Expenses {
  Date date;
  String category;
  double amount;
  String expenseID;

  Expenses({required this.date, required this.category, required this.amount,required this.expenseID});

  @override
  String toString() {
    return "$date: $category - ${amount.toStringAsFixed(2)} and expense ID is ${expenseID}";
  }

  
}


