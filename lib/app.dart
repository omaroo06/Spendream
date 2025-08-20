import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:spend_dream/PendingExpenses.dart';
import 'ExpensesClass.dart';
import 'DateClass.dart';
import 'auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Expenses> listOfExpenses = <Expenses>[];

  List<Pendingexpenses> listOfFutureExpenses = <Pendingexpenses>[];

  void changeBoolean() {
    hastheMethodbeencalledyet = false;
  }

  List<DateTime> datesToBePayed = <DateTime>[];

  Future<void> deleteAccount() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference UserToDelete = usersCollection.doc(email);
        await UserToDelete.delete();
        //rn havent deleted expenses

        CollectionReference expensesCollection =
            firestore.collection('Expenses');
        Query expensesquery =
            await expensesCollection.where("userID", isEqualTo: uid);
        //delete all expnses in this query

        expensesquery.get().then((QuerySnapshot) {
          for (var doc in QuerySnapshot.docs) {
            doc.reference.delete();
          }
        });

        CollectionReference expensesFCollection =
            firestore.collection('FutureExpenses');
        Query expensesFquery =
            await expensesFCollection.where("userID", isEqualTo: uid);
        //delete all expnses in this query

        expensesFquery.get().then((QuerySnapshot) {
          for (var doc in QuerySnapshot.docs) {
            doc.reference.delete();
          }
        });

        CollectionReference datesCollection =
            firestore.collection('DatesToAddExpense');
        Query datesQuery =
            await datesCollection.where("userID", isEqualTo: uid);
        //delete all expnses in this query

        datesQuery.get().then((QuerySnapshot) {
          for (var doc in QuerySnapshot.docs) {
            doc.reference.delete();
          }
        });

        await FirebaseFirestore.instance.batch().commit();
      }
      user.delete();
    }
  }

  double scale = 1;

  double scaleWidth = 1;
  double scaleHeight = 1;

  double amountSpentInMonthInGivenYear(int monh, int y) {
    int length = listOfExpenses.length;
    double sum = 0;
    for (int i = 0; i < length; i++) {
      if ((listOfExpenses[i].date.month == monh) &&
          (listOfExpenses[i].date.year == DateTime.now().year - y)) {
        sum += listOfExpenses[i].amount;
      }
    }
    return sum;
  }

  String textlistOfExpenses() {
    String text = "";
    for (int i = 0; i < listOfExpenses.length; i++) {
      text += " ${listOfExpenses[i]}";
    }
    return text;
  }

  Future<void> removingFromTotalExpenses(double amount) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        var prevTotal = snapshot.get('totalExpenses');
        var newTotal = prevTotal - amount;
        await User.update({
          'totalExpenses': newTotal,
        });
        totalExpenses = newTotal;
        notifyListeners();
      }
    }
  }

  void addFromTotalExpenses(double amount) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        var prevTotal = snapshot.get('totalExpenses');
        var newTotal = prevTotal + amount;
        await User.update({
          'totalExpenses': newTotal,
        });
      }
    }
  }

  void addFutureExpenseToFutureExpenseList(
      double amount,
      String eid,
      Date startDate,
      Date endDate,
      double frequencyAmount,
      String frequencyTime) {
    Pendingexpenses eToAddd = new Pendingexpenses(
        firstdate: startDate,
        lastdate: endDate,
        amount: amount,
        frequencyAmount: frequencyAmount,
        frequencyTime: frequencyTime,
        expenseID: eid);
    listOfFutureExpenses.add(eToAddd);
  }

  Future<void> addNewExpenseToExpenseList(
      String cat, double amount, String eid, Date date) async {
    Expenses eToADd = new Expenses(
      date: date,
      category: cat,
      amount: amount,
      expenseID: eid,
    );
    listOfExpenses.add(eToADd);
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        var prevTotal = snapshot.get('totalExpenses');
        await User.update({
          'totalExpenses': (prevTotal + amount),
        });
        totalExpenses = prevTotal + amount;
        notifyListeners();
      }
    }
  }

  Future<int> amountOfExpensesforCurrentUser() async {
    int counter = 0;
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expensesCollection = firestore.collection('Expenses');
      Query expensesquery = expensesCollection.where("userID", isEqualTo: uid);
      AggregateQuery countQuery = expensesquery.count();

      AggregateQuerySnapshot snapshot = await countQuery.get();
      if (snapshot.count! > 0) {
        return snapshot.count!;
      }
    }
    return counter;
  }

  int expenseCount = 5;

  Future<void> getCount() async {
    expenseCount = await amountOfExpensesforCurrentUser();
  }

  bool hastheMethodbeencalledyet = false;

  Future<void> clearExpenseList() async {
    listOfExpenses.clear();
  }

  Future<void> clearFExpenseList() async {
    listOfFutureExpenses.clear();
  }

  Future<void> makeRecurringPayment() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

        CollectionReference usersCollection = firestore.collection('Users');

        CollectionReference datesCollection =
            firestore.collection('DatesToAddExpense');

        CollectionReference futureExpensesCollection =
            firestore.collection("FutureExpenses");

        Query datesQuery = datesCollection.where("userID", isEqualTo: uid);

        datesQuery.get().then((QuerySnapshot) async {
          for (var docSnapshot in QuerySnapshot.docs) {
            DateTime paymentDate = docSnapshot.get("DateToPay").toDate();
            if ((paymentDate.isBefore(DateTime.now())) ||
                ((paymentDate.year == DateTime.now().year) &&
                    (paymentDate.month == DateTime.now().month) &&
                    (paymentDate.day == DateTime.now().day))) {
              double amountToAdd = 0;
              String FutureExpenseID = docSnapshot.get("FutureExpenseID");
              Query fExpensesQuery = futureExpensesCollection
                  .where("FutureExpenseID", isEqualTo: FutureExpenseID);

              Future<void> addExpense(double a) async {
                DocumentReference User = usersCollection.doc(email);
                DocumentSnapshot snapshot = await User.get();
                var prevTotal = snapshot.get('totalExpenses');

                 await AddToCagtegoryAmount(a, "Recurring");
                 print("for the $amountToAdd , the AddToCagtegoryAmount has been called");
                //is this line not running?
                getCatTotal();

                String EID = "";
                CollectionReference expensesCollection =
                    firestore.collection('Expenses');
                //it is adding correclty to expenses tho!
                expensesCollection.add({
                  'Amount': a,
                  'Category': "Recurring",
                  'userID': uid,
                  'ExpenseID': "",
                  'Date': docSnapshot.get("DateToPay"),
                }).then((DocumentReference doc) {
                  EID = doc.id;
                  doc.update({'ExpenseID': doc.id});

                  DateTime Datetime = docSnapshot.get("DateToPay").toDate();

                  Date DateToAdd = Date(
                      year: Datetime.year,
                      month: Datetime.month,
                      day: Datetime.day);

                  addNewExpenseToExpenseList("Recurring", a, EID, DateToAdd);
                });
               
              }

              fExpensesQuery.get().then((QuerySnapshot) async {
                for (var docSnapshot in QuerySnapshot.docs) {
                  amountToAdd = docSnapshot.get("Amount");
                  await addExpense(amountToAdd);
                }
              });
              //for some reason, on last date, the date is removed from datalist before payment is made. I will make a seperate method that runs after to fix the issue

              docSnapshot.reference.delete();
              notifyListeners();
            }
          }
        });
       
      }
    }
  }

  Future<void> deleteFutureExpenseOnLastDate() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;

      
        CollectionReference futureExpensesCollection =
            firestore.collection("FutureExpenses");

        Query fExpense =
            futureExpensesCollection.where("userID", isEqualTo: uid);
        fExpense.get().then((QuerySnapshot) async {
          for (var dateDoc in QuerySnapshot.docs) {
            if (((dateDoc.get("End Date").toDate()).isBefore(DateTime.now())) ||
                ((dateDoc.get("End Date").toDate().year ==
                        DateTime.now().year) &&
                    (dateDoc.get("End Date").toDate().month ==
                        DateTime.now().month) &&
                    (dateDoc.get("End Date").toDate().day ==
                        DateTime.now().day))) {
              dateDoc.reference.delete();
            }
          }
        });
      }
    }
  }

  Future<void> getAllExpensesinListforUser() async {
    print("datetime now is  ${DateTime.now().second}");
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expensesCollection = firestore.collection('Expenses');
      Query expensesquery = expensesCollection.where("userID", isEqualTo: uid);
      expensesquery.get().then((QuerySnapshot) {
        for (var docSnapshot in QuerySnapshot.docs) {
          double amountToAdd = docSnapshot.get("Amount");
          String categoryToAdd = docSnapshot.get("Category");
          Timestamp dateToAdd = docSnapshot.get("Date");

          String EIDtoAdd = docSnapshot.get("ExpenseID");

          DateTime dateA = dateToAdd.toDate();

          Date datee =
              Date(year: dateA.year, month: dateA.month, day: dateA.day);

          listOfExpenses.add(new Expenses(
            date: datee,
            category: categoryToAdd,
            amount: amountToAdd,
            expenseID: EIDtoAdd,
          ));
        }
      });
    }

    hastheMethodbeencalledyet = true;
  }

  Future<void> getAllFExpensesinListforUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expensesCollection =
          firestore.collection('FutureExpenses');
      Query expensesquery = expensesCollection.where("userID", isEqualTo: uid);
      expensesquery.get().then((QuerySnapshot) {
        for (var docSnapshot in QuerySnapshot.docs) {
          double amountToAdd = docSnapshot.get("Amount");

          String EIDtoAdd = docSnapshot.get("FutureExpenseID");
          Timestamp FdateToAdd = docSnapshot.get("Start Date");
          Timestamp EdateToAdd = docSnapshot.get("End Date");

          DateTime FdateA = FdateToAdd.toDate();

          Date Fdatee =
              Date(year: FdateA.year, month: FdateA.month, day: FdateA.day);

          DateTime EdateA = EdateToAdd.toDate();

          Date Edatee =
              Date(year: EdateA.year, month: EdateA.month, day: EdateA.day);

          double freqAmount = docSnapshot.get("Frequency Number");

          String freqTime = docSnapshot.get("Frequency Time");

          listOfFutureExpenses.add(new Pendingexpenses(
            firstdate: Fdatee,
            lastdate: Edatee,
            amount: amountToAdd,
            frequencyAmount: freqAmount,
            frequencyTime: freqTime,
            expenseID: EIDtoAdd,
          ));
        }
      });
    }
  }

  double mostSpentInMonthInGivenYear(int ye) {
    int length = listOfExpenses.length;
    double max = amountSpentInMonthInGivenYear(1, ye);
    if (justtotalYearamount(ye) == 0) {
      return 5000;
    }

    for (int i = 1; i <= 12; i++) {
      if (amountSpentInMonthInGivenYear(i, ye) > max) {
        max = amountSpentInMonthInGivenYear(i, ye);
      }
    }
    return max;
  }

  double totalCurrentYear(String cat, int y) {
    int length = listOfExpenses.length;
    double sum = 0;
    for (int i = 0; i < length; i++) {
      if ((listOfExpenses[i].category == cat) &&
          (listOfExpenses[i].date.year == DateTime.now().year - y)) {
        sum += listOfExpenses[i].amount;
      }
    }
    return sum;
  }

  double justtotalYearamount(int y) {
    int length = listOfExpenses.length;
    double sum = 0;
    for (int i = 0; i < length; i++) {
      if (listOfExpenses[i].date.year == DateTime.now().year - y) {
        sum += listOfExpenses[i].amount;
      }
    }
    return sum;
  }

  int yearNumber = 0;

  int yearNumberBar = 0;

  int screenIndexx = 0;

  String FEID = "test";

  void setFEID(String a) {
    FEID = a;
  }

  void changeScreenIndex(int amount) {
    screenIndexx = amount;

    notifyListeners();
  }

  Future<void> AddToCagtegoryAmount(double amount, String category) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
  print("for the $amount , we are in the AddToCagtegoryAmount");
    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        String categoryToa;
        if (category == "Housing") {
          categoryToa = 'housingAmount';
        } else if (category == "Transportation") {
          categoryToa = "transportationAmount";
        } else if (category == "Food") {
          categoryToa = 'foodAmount';
        } else if (category == "Utilities") {
          categoryToa = "utilitiesAmount";
        } else if (category == "Insurance") {
          categoryToa = "insuranceAmount";
        } else if (category == "Healthcare") {
          categoryToa = "healthcareAmount";
        } else if (category == "Savings") {
          categoryToa = "savingsAmount";
        } else if (category == "Personal") {
          categoryToa = "personalAmount";
        } else if (category == "Entertainment") {
          categoryToa = "entertainmentAmount";
        } else if (category == "Recurring") {
          categoryToa = 'recurringAmount';
            print("for the $amount , we are in correct recurringAmount if statement");
        } else {
          categoryToa = "miscAmount";
        }

        var prevTotal = snapshot.get(categoryToa);

        var newTotal = prevTotal + amount;
          print("for the $amount , the new total is $newTotal");
        await User.update({
          categoryToa: newTotal,
        });
          print("for the $amount , the new total in dataBase for recurring is ${snapshot.get(categoryToa)}");
      }
    }
    notifyListeners();
  }

  void DeleteToCategoryAmount(double amount, String category) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        String categoryToa;
        if (category == "Housing") {
          categoryToa = 'housingAmount';
        } else if (category == "Transportation") {
          categoryToa = "transportationAmount";
        } else if (category == "Food") {
          categoryToa = 'foodAmount';
        } else if (category == "Utilities") {
          categoryToa = "utilitiesAmount";
        } else if (category == "Insurance") {
          categoryToa = "insuranceAmount";
        } else if (category == "Healthcare") {
          categoryToa = "healthcareAmount";
        } else if (category == "Savings") {
          categoryToa = "savingsAmount";
        } else if (category == "Personal") {
          categoryToa = "personalAmount";
        } else if (category == "Entertainment") {
          categoryToa = "entertainmentAmount";
        } else if (category == "Recurring") {
          categoryToa = "recurringAmount";
        } else {
          categoryToa = "miscAmount";
        }

        var prevTotal = snapshot.get(categoryToa);

        double newTotal = prevTotal - amount;

        User.update({
          categoryToa: newTotal,
        });
      }
    }
    notifyListeners();
  }

  var colorForEditButton;
  var colorForDeleteButton;

  double tExpenses = 0.00;

  ColorScheme scheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 229, 149));

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

  double getFAmount(Pendingexpenses a) {
    return a.amount;
  }

  Date getFFDate(Pendingexpenses a) {
    return a.firstdate;
  }

  Date getFLDate(Pendingexpenses a) {
    return a.lastdate;
  }

  double getFrequencyAmount(Pendingexpenses a) {
    return a.frequencyAmount;
  }

  String getFrequencytime(Pendingexpenses a) {
    return a.frequencyTime;
  }

  bool isSignedin = false;
  void changeSignedInBoolean() {
    isSignedin = true;
    notifyListeners();
  }

  void changeSignedOutBoolean() {
    isSignedin = false;
    notifyListeners();
  }

  double totalExpenses = 0.0;

  double housingAmount = 0.0;
  double transportationAmount = 0.0;
  double foodAmount = 0.0;
  double utilitiesAmount = 0.0;
  double insuranceAmount = 0.0;
  double healthcareAmount = 0.0;
  double savingsAmount = 0.0;
  double personalAmount = 0.0;
  double entertainmentAmount = 0.0;
  double miscAmount = 0.0;
  double recurringAmount = 0.0;

  bool loadingForBudget = false;

  void loadingOn() {
    loadingForBudget = true;
  }

  void loadingOf() {
    loadingForBudget = false;
  }

  Future<void> getCatTotal() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String? email = user.email;
      if (email != null) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference usersCollection = firestore.collection('Users');

        DocumentReference User = usersCollection.doc(email);
        DocumentSnapshot snapshot = await User.get();
        housingAmount = await snapshot.get('housingAmount');
        transportationAmount = await snapshot.get('transportationAmount');
        foodAmount = await snapshot.get('foodAmount');
        utilitiesAmount = await snapshot.get('utilitiesAmount');
        insuranceAmount = await snapshot.get('insuranceAmount');
        totalExpenses = await snapshot.get('totalExpenses').toDouble();
        healthcareAmount = await snapshot.get('healthcareAmount');
        savingsAmount = await snapshot.get('savingsAmount');
        personalAmount = await snapshot.get('personalAmount');
        entertainmentAmount = await snapshot.get('entertainmentAmount');
        miscAmount = await snapshot.get('miscAmount');
        recurringAmount = await snapshot.get('recurringAmount');
      }
    }
    notifyListeners();
  }
}
