import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:spend_dream/PendingExpenses.dart';
import 'app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DateClass.dart';

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  _FuturePageState createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  final TextEditingController yearController = TextEditingController();

  final TextEditingController lastyearController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController frequencyController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  var timeLength = "Day(s)";

  DateTime? pickedDate;
  DateTime? pickedDate2;

  DateTime? initialForLastDate = DateTime.now();

  var firstDate;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    double scalee = appState.scale;
    double scaleW = appState.scaleWidth;
    double scaleH = appState.scaleHeight;

    if (frequencyController.text == "") {
      frequencyController.text = "1";
    }

    return Container(
        child: Center(
            child: Column(
      children: [
        SizedBox(height: 30 * scaleH),
        Row(
          children: [
            SizedBox(width: 20 * scaleW),
            Expanded(
              child: Transform.scale(
                scale: 1,
                child: TextFormField(
                    controller: yearController,
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      labelStyle: TextStyle(fontSize: 15 * scaleW),
                      icon: Icon(
                        Icons.date_range,
                        size: 24 * scaleW,
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime((DateTime.now().year),
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(
                            DateTime.now().year + 5,
                            DateTime.now().month,
                            DateTime.now().day,
                            23,
                            59,
                            59,
                            999),
                      );
                      if (pickedDate != null) {
                        yearController.text =
                            "${pickedDate!.month}/${pickedDate!.day}/${pickedDate!.year}";
                        initialForLastDate = pickedDate;
                      }
                    }),
              ),
            ),
            Expanded(
              child: Transform.scale(
                scale: 1,
                child: TextFormField(
                    controller: lastyearController,
                    decoration: InputDecoration(
                      labelText: "End Date",
                      labelStyle: TextStyle(fontSize: 15 * scaleW),
                      icon: Icon(Icons.date_range, size: 24 * scaleW),
                    ),
                    readOnly: true,
                    onTap: () async {
                      pickedDate2 = await showDatePicker(
                        context: context,
                        initialDate: initialForLastDate,
                        firstDate: DateTime(initialForLastDate!.year,
                            initialForLastDate!.month, initialForLastDate!.day),
                        lastDate: DateTime(
                            initialForLastDate!.year + 30,
                            initialForLastDate!.month,
                            initialForLastDate!.day,
                            23,
                            59,
                            59,
                            999),
                      );
                      if (pickedDate2 != null) {
                        lastyearController.text =
                            "${pickedDate2!.month}/${pickedDate2!.day}/${pickedDate2!.year}";
                      }
                    }),
              ),
            ),
            SizedBox(width: 20 * scaleW),
          ],
        ),
        SizedBox(height: 20 * scaleH),
        Row(
          children: [
            //const SizedBox(width: 20),
            SizedBox(
              width: 140,
              child: Transform.scale(
                scale: 1,
                child: TextFormField(
                  enableSuggestions: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.{0,1}\d*$'))
                  ],
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  maxLength: 9,
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money, size: 24 * scaleW),
                    hintText: "",
                    counterText: '',
                    labelText: "Amount (\$)",
                    labelStyle: TextStyle(fontSize: 15 * scaleW),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10 * scaleW,
            ),

            Text(
              "Every: ",
              style: TextStyle(fontSize: 14 * scaleW),
            ),

            SizedBox(
              child: Transform.scale(
                scale: 1,
                child: TextFormField(
                  enableSuggestions: false,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: frequencyController,
                  maxLength: 9,
                  decoration: InputDecoration(
                    labelText: "(e.g. 2)",
                    counterText: '',
                    labelStyle: TextStyle(fontSize: 15 * scaleW),
                  ),
                ),
              ),
              width: 42 * scaleW,
            ),
            SizedBox(width: 34 * scaleW),
            Expanded(
              child: Transform.scale(
                  scale: 1,
                  child: DropdownMenu(
                    controller: timeController,
                    onSelected: (string) {
                      if (string != null) {
                        setState(() {
                          timeLength = string;
                        });
                      }
                    },
                    width: 134 * scaleW,
                    menuHeight: 300 * scaleH,
                    textStyle: TextStyle(fontSize: 10 * scaleW),
                    initialSelection: 'Day(s)',
                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(
                          value: "Day(s)",
                          label: 'Day(s)',
                          labelWidget: Text(
                            "Day(s)",
                            style: TextStyle(fontSize: 10 * scaleW),
                          )),
                      DropdownMenuEntry(
                          value: "Week(s)",
                          label: 'Week(s)',
                          labelWidget: Text(
                            "Week(s)",
                            style: TextStyle(fontSize: 10 * scaleW),
                          )),
                      DropdownMenuEntry(
                          value: "Month(s)",
                          label: 'Month(s)',
                          labelWidget: Text(
                            "Month(s)",
                            style: TextStyle(fontSize: 10 * scaleW),
                          )),
                      DropdownMenuEntry(
                          value: "Year(s)",
                          label: 'Year(s)',
                          labelWidget: Text(
                            "Year(s)",
                            style: TextStyle(fontSize: 10 * scaleW),
                          )),
                    ],
                  )),
            ),
            // SizedBox(width: 76,)
            SizedBox(width: 20 * scaleW),
          ],
        ),
        SizedBox(height: 10 * scaleH),
        SizedBox(
          height: 30 * scaleH,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                if (!mounted) return;
                try {
                  String a = amountController.text;

                  double amountToAdd = double.parse(a);

                  String f = frequencyController.text;

                  double frequencyNumberToAdd = double.parse(f);
                  if (pickedDate != null &&
                      pickedDate2 != null &&
                      timeLength != null) {
                    Date dateToAddStart = Date(
                        day: pickedDate!.day,
                        month: pickedDate!.month,
                        year: pickedDate!.year);
                    DateTime dateAddStartt = DateTime(dateToAddStart.year,
                        dateToAddStart.month, dateToAddStart.day);
                    Timestamp dateStart = Timestamp.fromDate(dateAddStartt);

                    Date dateToAddEnd = Date(
                        day: pickedDate2!.day,
                        month: pickedDate2!.month,
                        year: pickedDate2!.year);
                    DateTime dateAddEndd = DateTime(dateToAddEnd.year,
                        dateToAddEnd.month, dateToAddEnd.day);
                    Timestamp dateEnd = Timestamp.fromDate(dateAddEndd);

                    String EID = "hi";
                    void transmitEIDvalue(String e) {
                      setState(() {
                        EID = e;
                      });
                    }

                    if (user != null) {
                      String uid = user.uid;
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;

                      //time Controller is fine here
                      CollectionReference futureExpensesCollection =
                          firestore.collection('FutureExpenses');

                      int amountOfDaysInTotal =
                          dateEnd.toDate().day - dateStart.toDate().day;
                      int totalTimeleft = -1;

                      int yearsDiff =
                          (dateAddEndd.year - dateAddStartt.year).toInt();
                      int monthsDiff =
                          (dateAddEndd.month - dateAddStartt.month).toInt();
                      int daysDiff =
                          (dateAddEndd.difference(dateAddStartt)).inDays;

                      if (timeLength == "Year(s)") {
                        totalTimeleft = yearsDiff;
                        print("end: ${dateEnd.toDate().year}");
                        print("start: ${dateStart.toDate().year}");
                      } else if (timeLength == "Month(s)") {
                        totalTimeleft = monthsDiff + (yearsDiff * 12);
                      } else if (timeLength == "Week(s)") {
                        totalTimeleft = ((daysDiff) / 7).toInt();
                      } else {
                        totalTimeleft = daysDiff;
                      }

                      print("time left: ${totalTimeleft} ${timeLength}");

                      int howManyTimesPaymentWillOccur =
                          (totalTimeleft / frequencyNumberToAdd).toInt() + 1;

                      print(
                          "the payment will occur: ${howManyTimesPaymentWillOccur}");

                      //next to do is make a new collection of DatesThatWillbePayed, amount, categgory (recurring), date. when it is that date, it will be removed from tnat collection and added to expenses colleciton. when it is end date, remove the future exxpense from list and the collection.

                      // every time i login, on the other screen, first go through all datesToBePayed Collection, filter by userID, then check if any of the dates are today's dates, if they are, go through the future expense collection to find expense amount to add teh expenses, check if on that future expense, today is the enddate if it is, then remvoe that futrue rexpesne, oh and also remove the DateToPayed
                      await futureExpensesCollection.add({
                        'Amount': amountToAdd,
                        'Frequency Number': frequencyNumberToAdd,
                        'Frequency Time': timeLength,
                        'userID': uid,
                        'FutureExpenseID': "",
                        'Start Date': dateStart,
                        'End Date': dateEnd,
                      }).then((DocumentReference doc) {
                        EID = doc.id;
                        doc.update({'FutureExpenseID': doc.id});

                        if (timeLength != null) {
                          setState(() {
                            appState.addFutureExpenseToFutureExpenseList(
                              amountToAdd,
                              EID,
                              dateToAddStart,
                              dateToAddEnd,
                              frequencyNumberToAdd,
                              timeLength,
                            );
                            appState.setFEID(doc.id);
                          });
                        } else {}
                      });
                      String FEID = appState.FEID;
                      CollectionReference datesCollection =
                          firestore.collection('DatesToAddExpense');
                      Date tempp = Date(
                          year: dateAddStartt.year,
                          month: dateAddStartt.month,
                          day: dateAddStartt.day);
                      DateTime temp =
                          DateTime(tempp.year, tempp.month, tempp.day);
                      print("Date is $temp");
                      datesCollection.add({
                        'DateToPay': Timestamp.fromDate(temp),
                        'FutureExpenseID': FEID,
                        'userID': uid,
                      });

                      appState.datesToBePayed.add(temp);
                      for (int i = 1;
                          i <= howManyTimesPaymentWillOccur - 1;
                          i++) {
                        if (timeLength == "Year(s)") {
                          temp = DateTime(
                              tempp.year + (frequencyNumberToAdd).toInt(),
                              tempp.month,
                              tempp.day);

                          datesCollection.add({
                            'DateToPay': Timestamp.fromDate(temp),
                            'FutureExpenseID': FEID,
                            'userID': uid,
                          });
                        } else if (timeLength == "Month(s)") {
                          temp = DateTime(
                              tempp.year,
                              tempp.month + (frequencyNumberToAdd).toInt(),
                              tempp.day);
                          datesCollection.add({
                            'DateToPay': Timestamp.fromDate(temp),
                            'FutureExpenseID': FEID,
                            'userID': uid,
                          });
                        } else if (timeLength == "Week(s)") {
                          temp = DateTime(tempp.year, tempp.month,
                              tempp.day + (frequencyNumberToAdd * 7).toInt());
                          datesCollection.add({
                            'DateToPay': Timestamp.fromDate(temp),
                            'FutureExpenseID': FEID,
                            'userID': uid,
                          });
                        } else {
                          temp = DateTime(tempp.year, tempp.month,
                              tempp.day + (frequencyNumberToAdd).toInt());

                          datesCollection.add({
                            'DateToPay': Timestamp.fromDate(temp),
                            'FutureExpenseID': FEID,
                            'userID': uid,
                          });
                        }
                        tempp = Date(
                            year: temp.year, month: temp.month, day: temp.day);

                        appState.datesToBePayed.add(temp);
                      }
                      print("list: ${appState.datesToBePayed}");
                    }

                    // await appState.getCount();

                    //await appState.AddToCagtegoryAmount(amountToAdd, futureCategory);
                    //await appState.getCatTotal();
                    setState(() {});
                    appState.makeRecurringPayment();
                    yearController.clear();
                    lastyearController.clear();
                    frequencyController.clear();
                    appState.getCatTotal();
                    timeController.text = "Day(s)";
                    timeLength = "Year(s)";
                    amountController.clear();

                    //gotta make time dropdwon back to Years
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Color.fromARGB(255, 222, 157, 6),
                          duration: const Duration(seconds: 1),
                          content: Row(
                            children: [
                              Icon(Icons.error, size: 24 * scaleW),
                              Text("ERROR: Please fill in all required fields",
                                  style: TextStyle(fontSize: 14 * scaleW)),
                            ],
                          )),
                    );
                  }
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Color.fromARGB(255, 222, 157, 6),
                        duration: Duration(seconds: 1),
                        content: Row(
                          children: [
                            Icon(Icons.error, size: 24 * scaleW),
                            Text("ERROR: Please fill in all required fields",
                                style: TextStyle(fontSize: 14 * scaleW)),
                          ],
                        )),
                  );
                }
              },
              label: Text(
                "Schedule Payment",
                style: TextStyle(
                    color: appState.scheme.onSecondaryContainer,
                    fontSize: 14 * scaleW),
              ),
              icon: Icon(Icons.add_card, size: 24 * scaleW),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      appState.scheme.secondaryContainer)),
            ),
            SizedBox(width: 10 * scaleW),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  yearController;
                  lastyearController.clear();
                  frequencyController.clear();

                  amountController.clear();
                  timeController.text = "Day(s)";
                  timeLength = "Year(s)";
                  //gotta make time dropdwon back to Years
                });
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      appState.scheme.secondaryContainer)),
              label: Text(
                "Clear",
                style: TextStyle(
                    color: appState.scheme.onSecondaryContainer,
                    fontSize: 14 * scaleW),
              ),
            )
          ],
        ),
        SizedBox(height: 30),
        Text("Pending Expenses",
            style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    fontSize: 35 * scaleW,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline))),
        SizedBox(height: 40 * scaleH),
        Expanded(
          child: ListView.builder(
            itemCount: appState.listOfFutureExpenses.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(12),
                    tileColor: appState.scheme.primaryContainer,
                    leading: Icon(Icons.access_time, size: 24 * scaleW),
                    title: Text(
                      "\$${appState.getFAmount(appState.listOfFutureExpenses[index]).toStringAsFixed(2)} every ${appState.getFrequencyAmount(appState.listOfFutureExpenses[index]).toInt()} ${appState.getFrequencytime(appState.listOfFutureExpenses[index])}",
                      style: TextStyle(
                          color: appState.scheme.onPrimaryContainer,
                          fontSize: 14 * scaleW),
                    ),
                    subtitle: Text(
                      "${appState.getFFDate(appState.listOfFutureExpenses[index])} - ${appState.getFLDate(appState.listOfFutureExpenses[index])} ",
                      style: TextStyle(fontSize: 12 * scaleW),
                    ),
                    trailing: ElevatedButton(
                        onPressed: () async {
                          if (!mounted) return;
                          Pendingexpenses recurringPaymentToDelete =
                              appState.listOfFutureExpenses[index];
                          if (recurringPaymentToDelete.expenseID.isNotEmpty) {
                            DocumentReference docFutureExpenseDelete =
                                FirebaseFirestore.instance
                                    .collection("FutureExpenses")
                                    .doc(recurringPaymentToDelete.expenseID);
                            //we have DOC ID, so now go through the dates and delete them.

                            DocumentSnapshot futureExpenseIDsnap=await docFutureExpenseDelete.get();

                            String FUID=futureExpenseIDsnap.get("FutureExpenseID");

                            CollectionReference datesCollection =
                                FirebaseFirestore.instance
                                    .collection("DatesToAddExpense");
                            Query datesQuery = datesCollection.where(
                                "FutureExpenseID",
                                isEqualTo: FUID);

                            //query where dates are the ones associated with future expense

                            datesQuery.get().then((QuerySnapshot) async {
                              for (var docSnapshot in QuerySnapshot.docs) {
                                docSnapshot.reference.delete();
                              }
                            });
                            

                            //ERROR - dates are NOT being deleted
                            docFutureExpenseDelete.delete();
                            int i = index;
                                        appState.listOfFutureExpenses.removeAt(i);
                                        setState(() {
                                          
                                        });
                          }

                          //the future Expense gets deleted
                        },
                        child: Icon(
                          Icons.remove,
                          size: 24 * scaleW,
                        )),
                  ),

                  const Divider(),
                  //customize Divider?
                ],
              );
            },
          ),
        ),
      ],
    )));

    //ADD Delete Recurring Payment feature, no need for edit button.
  }
}
