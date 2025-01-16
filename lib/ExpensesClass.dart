import 'DateClass.dart';

class Expenses {
  Date date;
  String category;
  double amount;

  Expenses({required this.date, required this.category, required this.amount});

  @override
  String toString() {
    return "$date: $category - ${amount.toStringAsFixed(2)}";
  }
}
