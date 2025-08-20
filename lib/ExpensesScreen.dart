import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'app.dart';

import 'ExpensesClass.dart';
import 'DateClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'dart:async';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  var category;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  bool editButtonPressed = false;

  var dateEdited;
  var EIDtoPreserve;
  var dateToEdit;
  var categoryToEdit;
  String sortAmount = "Cost";

  String sortDate = "Date";

  String sortCategory = "Category";

  bool SortAmount = false;
  bool SortDate = false;
  bool SortCategory = false;

  final TextEditingController categoryController = TextEditingController();
  var expensesLen;
  int indexToEdit = -1;
  String whichCatSortString="assets/AtoZZZZZZ.png";
  var expenses;
  var appState;
  double totalExpense = 0;
  DateTime? pickedDate;

  void sortCategoryMethod() {
    setState(() {
      if (SortCategory == false) {
        sortAMethod();
        whichCatSortString="assets/ZtoAA.png";
        SortCategory = true;
      } else {
        sortZMethod();
        whichCatSortString="assets/AtoZZZZZZ.png";
        SortCategory = false;
      }
    });
  }

  void sortAMethod() {
    setState(() {
      int A;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        A = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (appState.listOfExpenses[j].category
                  .compareTo(appState.listOfExpenses[A].category) <
              0) {
            A = j;
          }
        }
        if (i != A) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = appState.listOfExpenses[A];
          appState.listOfExpenses[A] = temp;
        }
      }
    });
  }

  void sortZMethod() {
    setState(() {
      int Z;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        Z = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (appState.listOfExpenses[j].category
                  .compareTo(appState.listOfExpenses[Z].category) >
              0) {
            Z = j;
          }
        }
        if (i != Z) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = appState.listOfExpenses[Z];
          appState.listOfExpenses[Z] = temp;
        }
      }
    });
  }

  void sortDateMethod() {
    setState(() {
      if (SortDate == false) {
        sortNeMethod();

        SortDate = true;
      } else {
        sortOlMethod();

        SortDate = false;
      }
    });
  }

  void sortOlMethod() {
    setState(() {
      int old;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        old = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (calculateDateValue(j) < calculateDateValue(old)) {
            old = j;
          }
        }
        if (i != old) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = appState.listOfExpenses[old];
          appState.listOfExpenses[old] = temp;
        }
      }
    });
  }

  void sortNeMethod() {
    setState(() {
      int neww;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        neww = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (calculateDateValue(j) > calculateDateValue(neww)) {
            neww = j;
          }
        }
        if (i != neww) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = appState.listOfExpenses[neww];
          appState.listOfExpenses[neww] = temp;
        }
      }
    });
  }

  double calculateDateValue(int index) {
    return ((appState.listOfExpenses[index].date.year -
                (DateTime.now().year) -
                10) *
            365) +
        (appState.listOfExpenses[index].date.month * 30.473) +
        (appState.listOfExpenses[index].date.day);
  }

  void sortHiMethod() {
    setState(() {
      int max;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        max = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (appState.listOfExpenses[j].amount >
              appState.listOfExpenses[max].amount) {
            max = j;
          }
        }
        if (i != max) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = appState.listOfExpenses[max];
          appState.listOfExpenses[max] = temp;
        }
      }
    });
  }

  void sortMethod() {
    setState(() {
      if (SortAmount == false) {
        sortHiMethod();

        SortAmount = true;
      } else {
        sortLoMethod();

        SortAmount = false;
      }
    });
  }

  void sortLoMethod() {
    setState(() {
      int min;

      for (var i = 0; i < appState.listOfExpenses.length; i++) {
        min = i;

        for (int j = i + 1; j < appState.listOfExpenses.length; j++) {
          if (expenses[j].amount < appState.listOfExpenses[min].amount) {
            min = j;
          }
        }

        if (i != min) {
          var temp = appState.listOfExpenses[i];
          appState.listOfExpenses[i] = expenses[min];
          appState.listOfExpenses[min] = temp;
        }
      }
    });
  }

  void clearButtonmethod() {
    setState(() {
      yearController.clear();
      amountController.clear();
      categoryController.clear();
      category = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    appState = context.watch<MyAppState>();
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
     final double scalee=appState.scale;
     double scaleW=appState.scaleWidth;
     double scaleH=appState.scaleHeight;
     
     
    
    if (appState.hastheMethodbeencalledyet == false) {
      appState.getAllExpensesinListforUser();
    }
    expenses = appState.listOfExpenses;

    appState.getCount();
    return Container(
      child: Center(
          child: Column(
        children: [
          SizedBox(height: 20*scaleH),
          Row(
            children: [
              Expanded(
                child: Transform.scale(
                  
                  scale:1,
                  child: TextFormField(
                    enableSuggestions: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.{0,1}\d*$'))
                    ],
                    //keyboardType: TextInputType.text,
                    //removing the keyboard type bc need decimal and need to close the keyboard
                    controller: amountController,
                    maxLength: 9,
                    style: TextStyle(fontSize: 14*scaleW),
                    decoration:  InputDecoration(
                       icon: Icon(Icons.attach_money,size: 24*scaleW,),
                      hintText: "",
                      counterText: '',
                      labelText: "Amount (\$)",
                      labelStyle: TextStyle(fontSize: (15*scaleW)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Transform.scale(
                  
                  scale:1,
                  child: TextFormField(
                      controller: yearController,
                      decoration:  InputDecoration(
                        labelText: "Date",
                        labelStyle: TextStyle(fontSize: 15*scaleW),
                        icon:  Icon(Icons.date_range,size:24*scaleW),
                        
                      ),
                      style:TextStyle(fontSize: 14*scaleW),
                      readOnly: true,
                      onTap: () async {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime((DateTime.now().year) - 10),
                          lastDate: DateTime(
                              DateTime.now().year,
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
                          
                        }
                        
                      }),
                ),
              ),
              SizedBox(width: 5*scaleW),
              Transform.scale(
                
                scale:1,
                child: Icon(Icons.category,size: 24*scaleW,)),
              Expanded(
                child: Transform.scale(
                   
                    scale:1,
                    child: DropdownMenu(
                      controller: categoryController,
                      onSelected: (string) {
                        if (string != null) {
                          setState(() {
                            {
                              categorySelect(string);
                            }
                          });
                        }
                      },
                     
                      width: 134*scaleW,
                    
                      menuHeight: 300,
                      textStyle: TextStyle(fontSize: 10*scaleW),
                      helperText: "Select Category",
                      
                      label: Text(
                        "Category",
                        style: TextStyle(fontSize: 10*scaleW*0.835),
                      ),
                      
                      dropdownMenuEntries: <DropdownMenuEntry<String>>[
                        DropdownMenuEntry(
                            leadingIcon: const Icon(Icons.house),
                            value: "Housing",
                            label: 'Housing',
                            labelWidget: Text(
                              "Housing",
                              
                              
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.emoji_transportation),
                            value: "Transportation",
                            label: 'Transportation',
                            labelWidget: Text(
                              "Transportation",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.fastfood),
                            value: "Food",
                            label: 'Food',
                            labelWidget: Text(
                              "Food",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.lightbulb),
                            value: "Utilities",
                            label: 'Utilities',
                            labelWidget: Text(
                              "Utilities",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.monitor_heart),
                            value: "Insurance",
                            label: 'Insurance',
                            labelWidget: Text("Insurance",
                                style: TextStyle(fontSize: 10*scaleW))),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.medical_services),
                            value: "Healthcare",
                            label: 'Healthcare',
                            labelWidget: Text(
                              "Healthcare",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.monetization_on),
                            value: "Savings",
                            label: 'Savings',
                            labelWidget: Text(
                              "Savings",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.shop),
                            value: "Personal",
                            label: 'Personal',
                            labelWidget: Text(
                              "Personal",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.movie),
                            value: "Entertainment",
                            label: 'Entertainment',
                            labelWidget: Text(
                              "Entertainment",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                         DropdownMenuEntry(
                            leadingIcon: Icon(Icons.miscellaneous_services),
                            value: "Miscellaneous",
                            label: 'Miscellaneous',
                            labelWidget: Text(
                              "Miscellaneous",
                              style: TextStyle(fontSize: 10*scaleW),
                            )),
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(height: 20*scaleH),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (editButtonPressed == false) ...[
                ElevatedButton.icon(
                  onPressed: () async {
                    if (!mounted) return; 
                    try {
                      String a = amountController.text;

                      double amountToAdd = double.parse(a);
                      if (pickedDate != null && category != null) {
                        Date dateToAdd = Date(
                            day: pickedDate!.day,
                            month: pickedDate!.month,
                            year: pickedDate!.year);
                        DateTime dateAdd = DateTime(
                            dateToAdd.year, dateToAdd.month, dateToAdd.day);
                        Timestamp date = Timestamp.fromDate(dateAdd);

                        String EID = "hi";
                        void transmitEIDvalue(String e) {
                          setState(() {
                            EID = e;
                          });
                        }

                        String categoryToAd = category;
                        if (user != null) {
                          String uid = user.uid;
                          final FirebaseFirestore firestore =
                              FirebaseFirestore.instance;

                          CollectionReference expensesCollection =
                              firestore.collection('Expenses');
                          expensesCollection.add({
                            'Amount': amountToAdd,
                            'Category': category,
                            'userID': uid,
                            'ExpenseID': "",
                            'Date': date,
                          }).then((DocumentReference doc) {
                            EID = doc.id;
                            doc.update({'ExpenseID': doc.id});
                           
                           
                            if (categoryToAd != null) {
                              setState(() {
                                appState.addNewExpenseToExpenseList(
                                    categoryToAd, amountToAdd, EID, dateToAdd);
                              });
                            } else {
                              
                            }
                          });
                        }

                        await appState.getCount();

                        await appState.AddToCagtegoryAmount(amountToAdd, category);
                        await appState.getCatTotal();
                        setState(() {});
                        yearController.clear();
                        amountController.clear();
                        categoryController.clear();
                        category = null;
                       
                        appState.colorForEditButton =
                            const Color.fromARGB(255, 234, 196, 130);
                        appState.colorForDeleteButton =
                            const Color.fromARGB(255, 239, 71, 71);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Color.fromARGB(255, 222, 157, 6),
                              duration: const Duration(seconds: 1),
                              content: Row(
                                children: [
                                  Icon(Icons.error),
                                  Text(
                                      "ERROR: Please fill in all required fields",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              )),
                        );
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromARGB(255, 222, 157, 6),
                            duration: Duration(seconds: 1),
                            content: Row(
                              children: [
                                Icon(Icons.error),
                                Text(
                                    "ERROR: Please fill in all required fields",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: appState.scheme.onSecondaryContainer,
                    size:24*scaleW,
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  label: Text(
                    "Add Expense",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer,fontSize: 14*scaleW),
                  ),
                ),
                 SizedBox(width: 10*scaleW),
                ElevatedButton.icon(
                 
                  onPressed: clearButtonmethod,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  label: Text(
                    "Clear",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer,fontSize: 14*scaleW*1.13),
                  ),
                ),
                
                
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () async {
                    if (!mounted) return; 
                    Date dateToAdd = Date(year: 1995, month: 9, day: 3);
                    String a = amountController.text;
                    if (yearController.text == dateToEdit) {
                      dateToAdd = dateEdited;
                    }
                    if (categoryController.text == categoryToEdit) {
                      category = categoryToEdit;
                    }
                    if ((pickedDate != null || dateToAdd == dateEdited) &&
                        category != null) {
                      
                      double amountToAdd = double.parse(a);
                      Expenses expenseToDelete =
                          appState.listOfExpenses[indexToEdit];
                      double amountToDelete = expenseToDelete.amount;
                      String cat = appState
                          .getCategory(appState.listOfExpenses[indexToEdit]);

                      setState(() {});

                      if (expenseToDelete.expenseID.isNotEmpty) {
                        DocumentReference docToDelete = FirebaseFirestore
                            .instance
                            .collection("Expenses")
                            .doc(expenseToDelete.expenseID);
                        docToDelete.delete();

                        int i = indexToEdit;
                        appState.listOfExpenses.removeAt(i);
                      }
                     

                      if (dateToAdd != dateEdited) {
                        dateToAdd = Date(
                            day: pickedDate!.day,
                            month: pickedDate!.month,
                            year: pickedDate!.year);
                      }

                      Expenses expensetoAdd = Expenses(
                        date: dateToAdd,
                        category: category,
                        amount: amountToAdd,
                        expenseID: EIDtoPreserve,
                      );

                      appState.listOfExpenses.insert(indexToEdit, expensetoAdd);
                      FirebaseAuth auth = FirebaseAuth.instance;
                      DateTime dateAdd = DateTime(
                          dateToAdd.year, dateToAdd.month, dateToAdd.day);
                      Timestamp date = Timestamp.fromDate(dateAdd);
                      final User? user = auth.currentUser;
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;
                      CollectionReference usersCollection =
                          firestore.collection('Expenses');
                      if (user != null) {
                        String? email = user.email;
                        DocumentReference UserToAdd =
                            usersCollection.doc(EIDtoPreserve);
                        if (email != null) {
                          UserToAdd.set({
                           
                            'userID': user.uid,
                            'Category': category,
                            'Amount': amountToAdd,
                            'ExpenseID': EIDtoPreserve,
                            'Date': date,
                          });
                        }
                        ;
                      }

                      yearController.clear();
                      amountController.clear();
                      categoryController.clear();

                      editButtonPressed = false;
                      indexToEdit = -1;
                      appState.colorForEditButton =
                          const Color.fromARGB(255, 234, 196, 130);
                      appState.colorForDeleteButton =
                          const Color.fromARGB(255, 239, 71, 71);
                     

                     appState.loadingOn();
                     
                      await appState.DeleteToCategoryAmount(
                          amountToDelete, cat);
                      await appState.removingFromTotalExpenses(amountToDelete);
                      await appState.AddToCagtegoryAmount(
                          amountToAdd, category);
                      await appState.addFromTotalExpenses(amountToAdd);
                       await appState.getCatTotal();
                       appState.loadingOf();
                       

                      category = null;
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                            backgroundColor: Color.fromARGB(255, 222, 157, 6),
                            duration: Duration(seconds: 1),
                            content: Row(
                              children: [
                                Icon(Icons.error,size: 24*scaleW,),
                                Text("ERROR: Please fill all required fields",
                                    style: TextStyle(fontSize: 14*scaleW)),
                              ],
                            )),
                      );
                    }
                  },
                  icon: Icon(Icons.check,size:24*scaleW),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  label: Text(
                    "Confirm",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer,fontSize: 14*scaleW),
                  ),
                ),
              ]
            ],
          ),
           SizedBox(height: 40*scaleH),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SizedBox(
                width: 15*scaleW,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  
                  scale:1,
                  child: 
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    onPressed: sortMethod,
                    label: Text(
                      sortAmount,
                      style: TextStyle(
                          fontSize: 10*scaleW,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    
                    icon: 
                    
                    Transform.flip(
                        flipY: SortAmount,
                        
                        child: Icon(
                          Icons.swap_vert,
                          color: appState.scheme.onTertiaryContainer,size:24*scaleW,
                        )),
                        
                  ),

                  
                ),
              ),
               SizedBox(
                width: 20*scaleW,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  
                  scale:1,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    onPressed: sortDateMethod,
                    label: Text(
                      sortDate,
                      style: TextStyle(
                          fontSize: 10*scaleW,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    icon: Transform.flip(
                        flipY: SortDate,
                        child: Icon(Icons.swap_vert,size:24*scaleW,
                            color: appState.scheme.onTertiaryContainer)),
                  ),
                ),
              ),
               SizedBox(
                width: 20*scaleW,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  
                  scale:1,
                  child: ElevatedButton.icon(
                    
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    
                    onPressed: sortCategoryMethod,
                    label: Text(
                      sortCategory,
                      style: TextStyle(
                          fontSize: 10*scaleW*0.9,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    icon: Image.asset(whichCatSortString,height:24*scaleW ),
                    
                    
                    
                  ),
                ),
              ),
               SizedBox(
                width: 15*scaleW,
              ),
            ],
          ),
           SizedBox(height: 40*scaleH),
          Expanded(
            child: ListView.builder(
              itemCount: appState.listOfExpenses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.all(16*scaleH),
                        tileColor: appState.scheme.primaryContainer,
                        leading: Icon(Icons.monetization_on_outlined,size: 24*scaleW,),
                        title: Text(
                          "\$${appState.getAmount(appState.listOfExpenses[index]).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: appState.scheme.onPrimaryContainer,fontSize: 14*scaleW),
                        ),
                        subtitle: Text(
                            "${appState.getDate(appState.listOfExpenses[index])} \n${appState.getCategory(appState.listOfExpenses[index])}",style: TextStyle(fontSize:12*scaleW),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                             
                              scale:0.75,
                              child: ElevatedButton(
                                
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(
                                            appState.colorForEditButton)),
                                onPressed: () => setState(() {
                                  if (editButtonPressed == false) {
                                    amountController.text =
                                        "${appState.getAmount(appState.listOfExpenses[index]).toStringAsFixed(2)}";
                                    yearController.text =
                                        "${appState.getDate(appState.listOfExpenses[index]).month}/${appState.getDate(appState.listOfExpenses[index]).day}/${appState.getDate(appState.listOfExpenses[index]).year}";
                                    categoryController.text =
                                        "${appState.getCategory(appState.listOfExpenses[index])}";
                                    editButtonPressed = true;
                                    indexToEdit = index;
                                    dateEdited = appState.getDate(
                                        appState.listOfExpenses[index]);
                                    dateToEdit =
                                        "${appState.getDate(appState.listOfExpenses[index]).month}/${appState.getDate(appState.listOfExpenses[index]).day}/${appState.getDate(appState.listOfExpenses[index]).year}";
                                    categoryToEdit = categoryController.text;
                                    EIDtoPreserve = appState
                                        .listOfExpenses[index].expenseID;
                                    appState.colorForEditButton =
                                        const Color.fromARGB(255, 232, 164, 45);
                                    appState.colorForDeleteButton =
                                        const Color.fromARGB(
                                            255, 237, 143, 143);
                                  } else {
                                    indexToEdit = -1;
                                    yearController.clear();
                                    amountController.clear();
                                    categoryController.clear();
                                    editButtonPressed = false;
                                    appState.colorForEditButton =
                                        const Color.fromARGB(
                                            255, 234, 196, 130);
                                    appState.colorForDeleteButton =
                                        const Color.fromARGB(255, 239, 71, 71);
                                  }
                                }),
                                child: Icon(Icons.edit,size: 24*scaleW,
                                    color:
                                        appState.scheme.onSecondaryContainer),
                              ),
                            ),

                            

                            Transform.scale(
                             
                             scale:0.75,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll<Color>(
                                              appState.colorForDeleteButton)),
                                  onPressed: () async {
                                    if (!mounted) return; 
                                    if (editButtonPressed == false) {
                                      Expenses expenseToDelete =
                                          appState.listOfExpenses[index];
                                      double amountToDelete =
                                          expenseToDelete.amount;
                                      String cat = appState.getCategory(
                                          appState.listOfExpenses[index]);

                                    
                                      if (expenseToDelete
                                          .expenseID.isNotEmpty) {
                                        DocumentReference docToDelete =
                                            FirebaseFirestore.instance
                                                .collection("Expenses")
                                                .doc(expenseToDelete.expenseID);
                                        docToDelete.delete();

                                        int i = index;
                                        appState.listOfExpenses.removeAt(i);

                                        await appState.DeleteToCategoryAmount(
                                            amountToDelete, cat);
                                        await appState
                                            .removingFromTotalExpenses(
                                                expenseToDelete.amount);
                                        await appState.getCatTotal();

                                        setState(() {});
                                      } else {}
                                    }
                                  },
                                  child: Icon(Icons.delete,size:24*scaleW,
                                      color: appState
                                          .scheme.onSecondaryContainer)),
                            )
                          ],
                        )),

                    const Divider(),
                    //customize Divider?
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  String categorySelect(String string) => category = string;
}
