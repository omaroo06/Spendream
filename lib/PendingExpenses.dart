import 'DateClass.dart';

class Pendingexpenses {
  Date firstdate;
  Date lastdate;
  
  double amount;
  double frequencyAmount;
  String frequencyTime;
  String expenseID;

  Pendingexpenses({required this.firstdate, required this.lastdate, required this.amount, required this.frequencyAmount,required this.frequencyTime,required this.expenseID});

  @override
  String toString() {
    return "$firstdate: $lastdate - ${amount.toStringAsFixed(2)}";
  }
}