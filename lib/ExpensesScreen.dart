import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'ExpensesClass.dart';
import 'DateClass.dart';

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

  var dateToEdit;
  var categoryToEdit;
  String sortAmount = "Cost";

  String sortDate = "Date";

  String sortCategory = "Category";

  bool SortAmount = false;
  bool SortDate = false;
  bool SortCategory = false;

  final TextEditingController categoryController = TextEditingController();

  int indexToEdit = -1;

  var expenses;

  double totalExpense = 0;
  DateTime? pickedDate;

  void sortCategoryMethod() {
    setState(() {
      if (SortCategory == false) {
        sortAMethod();

        SortCategory = true;
      } else {
        sortZMethod();

        SortCategory = false;
      }
    });
  }

  void sortAMethod() {
    setState(() {
      int A;

      for (var i = 0; i < expenses.length; i++) {
        A = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (expenses[j].category.compareTo(expenses[A].category) < 0) {
            A = j;
          }
        }
        if (i != A) {
          var temp = expenses[i];
          expenses[i] = expenses[A];
          expenses[A] = temp;
        }
      }
    });
  }

  void sortZMethod() {
    setState(() {
      int Z;

      for (var i = 0; i < expenses.length; i++) {
        Z = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (expenses[j].category.compareTo(expenses[Z].category) > 0) {
            Z = j;
          }
        }
        if (i != Z) {
          var temp = expenses[i];
          expenses[i] = expenses[Z];
          expenses[Z] = temp;
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

      for (var i = 0; i < expenses.length; i++) {
        old = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (calculateDateValue(j) < calculateDateValue(old)) {
            old = j;
          }
        }
        if (i != old) {
          var temp = expenses[i];
          expenses[i] = expenses[old];
          expenses[old] = temp;
        }
      }
    });
  }

  void sortNeMethod() {
    setState(() {
      int neww;

      for (var i = 0; i < expenses.length; i++) {
        neww = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (calculateDateValue(j) > calculateDateValue(neww)) {
            neww = j;
          }
        }
        if (i != neww) {
          var temp = expenses[i];
          expenses[i] = expenses[neww];
          expenses[neww] = temp;
        }
      }
    });
  }

  double calculateDateValue(int index) {
    return ((expenses[index].date.year - (DateTime.now().year) - 10) * 365) +
        (expenses[index].date.month * 30.473) +
        (expenses[index].date.day);
  }

  void sortHiMethod() {
    setState(() {
      int max;

      for (var i = 0; i < expenses.length; i++) {
        max = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (expenses[j].amount > expenses[max].amount) {
            max = j;
          }
        }
        if (i != max) {
          var temp = expenses[i];
          expenses[i] = expenses[max];
          expenses[max] = temp;
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

      for (var i = 0; i < expenses.length; i++) {
        min = i;

        for (int j = i + 1; j < expenses.length; j++) {
          if (expenses[j].amount < expenses[min].amount) {
            min = j;
          }
        }

        if (i != min) {
          var temp = expenses[i];
          expenses[i] = expenses[min];
          expenses[min] = temp;
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
    var appState = context.watch<MyAppState>();

    expenses = appState.listOfExpenses;

    return Container(
      child: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
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
                    decoration: const InputDecoration(
                      icon: Icon(Icons.attach_money),
                      hintText: "",
                      counterText: '',
                      labelText: "Amount (\$)",
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Transform.scale(
                  scale: 1,
                  child: TextFormField(
                      controller: yearController,
                      decoration: const InputDecoration(
                        labelText: "Date",
                        labelStyle: TextStyle(fontSize: 15),
                        icon: Icon(Icons.date_range),
                      ),
                      readOnly: true,
                      onTap: () async {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime((DateTime.now().year) - 10),
                          lastDate: DateTime((DateTime.now().year) + 10),
                        );
                        if (pickedDate != null) {
                          yearController.text =
                              "${pickedDate!.month}/${pickedDate!.day}/${pickedDate!.year}";
                        }
                      }),
                ),
              ),
              const SizedBox(width: 5),
              Transform.scale(scale: 1, child: Icon(Icons.category)),
              Expanded(
                child: Transform.scale(
                    scale: 1,
                    child: DropdownMenu(
                      controller: categoryController,
                      onSelected: (string) {
                        if (string != null) {
                          setState(() {
                            category = string;
                          });
                        }
                      },
                      width: 134,
                      menuHeight: 300,
                      textStyle: TextStyle(fontSize: 10),
                      helperText: "Select Category",
                      label: Text(
                        "Category",
                        style: TextStyle(fontSize: 10),
                      ),
                      enableSearch: true,
                      enableFilter: true,
                      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.house),
                            value: "Housing",
                            label: 'Housing',
                            labelWidget: Text(
                              "Housing",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.emoji_transportation),
                            value: "Transportation",
                            label: 'Transportation',
                            labelWidget: Text(
                              "Transportation",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.fastfood),
                            value: "Food",
                            label: 'Food',
                            labelWidget: Text(
                              "Food",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.lightbulb),
                            value: "Utilities",
                            label: 'Utilities',
                            labelWidget: Text(
                              "Utilities",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.monitor_heart),
                            value: "Insurance",
                            label: 'Insurance',
                            labelWidget: Text("Insurance",
                                style: TextStyle(fontSize: 10))),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.medical_services),
                            value: "Healthcare",
                            label: 'Healthcare',
                            labelWidget: Text(
                              "Healthcare",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.monetization_on),
                            value: "Savings",
                            label: 'Savings',
                            labelWidget: Text(
                              "Savings",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.shop),
                            value: "Personal",
                            label: 'Personal',
                            labelWidget: Text(
                              "Personal",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.movie),
                            value: "Entertainment",
                            label: 'Entertainment',
                            labelWidget: Text(
                              "Entertainment",
                              style: TextStyle(fontSize: 10),
                            )),
                        DropdownMenuEntry(
                            leadingIcon: Icon(Icons.miscellaneous_services),
                            value: "Miscellaneous",
                            label: 'Miscellaneous',
                            labelWidget: Text(
                              "Miscellaneous",
                              style: TextStyle(fontSize: 10),
                            )),
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (editButtonPressed == false) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      String a = amountController.text;

                      try {
                        double amountToAdd = double.parse(a);
                        if (pickedDate != null && category != null) {
                          Date dateToAdd = Date(
                              day: pickedDate!.day,
                              month: pickedDate!.month,
                              year: pickedDate!.year);
                          Expenses expensetoAdd = Expenses(
                              date: dateToAdd,
                              category: category,
                              amount: amountToAdd);
                          if (category == "Housing") {
                            appState.addToHousingAmount(amountToAdd);
                          } else if (category == "Transportation") {
                            appState.addToTransportationAmount(amountToAdd);
                          } else if (category == "Food") {
                            appState.addToFoodAmount(amountToAdd);
                          } else if (category == "Utilities") {
                            appState.addToUtilitiesAmount(amountToAdd);
                          } else if (category == "Insurance") {
                            appState.addToInsuranceAmount(amountToAdd);
                          } else if (category == "Healthcare") {
                            appState.addToHealthcareAmount(amountToAdd);
                          } else if (category == "Savings") {
                            appState.addToSavingsAmount(amountToAdd);
                          } else if (category == "Personal") {
                            appState.addToPersonalAmount(amountToAdd);
                          } else if (category == "Entertainment") {
                            appState.addToEntertainmentAmount(amountToAdd);
                          } else {
                            appState.addToMiscAmount(amountToAdd);
                          }

                          appState.listOfExpenses.add(expensetoAdd);
                          //expenses.add(expensetoAdd);
                          yearController.clear();
                          amountController.clear();
                          categoryController.clear();
                          category = null;
                          totalExpense += expensetoAdd.amount;
                          appState.addToTotalExpenses(expensetoAdd.amount);
                          appState.colorForEditButton=const Color.fromARGB(255, 234, 196, 130);
                          appState.colorForDeleteButton=const Color.fromARGB(255, 239, 71, 71);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 222, 157, 6),
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
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: appState.scheme.onSecondaryContainer,
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  label: Text(
                    "Add Expense",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: clearButtonmethod,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  child: Text(
                    "Clear",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer),
                  ),
                ),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () => setState(() {
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
                      try {
                        double amountToAdd = double.parse(a);
                        Expenses expenseToDelete = expenses[indexToEdit];
                        double amountToDelete = expenseToDelete.amount;
                        String cat =
                            appState.getCategory(expenses[indexToEdit]);
                        if (cat == "Housing") {
                          appState.removeHousingAmount(amountToDelete);
                        } else if (cat == "Transportation") {
                          appState.removeTransportationAmount(amountToDelete);
                        } else if (cat == "Food") {
                          appState.removeFoodAmount(amountToDelete);
                        } else if (cat == "Utilities") {
                          appState.removeUtilitiesAmount(amountToDelete);
                        } else if (cat == "Insurance") {
                          appState.removeInsuranceAmount(amountToDelete);
                        } else if (cat == "Healthcare") {
                          appState.removeHealthcareAmount(amountToDelete);
                        } else if (cat == "Savings") {
                          appState.removeSavingsAmount(amountToDelete);
                        } else if (cat == "Personal") {
                          appState.removePersonalAmount(amountToDelete);
                        } else if (cat == "Entertainment") {
                          appState.removeEntertainmentAmount(amountToDelete);
                        } else {
                          appState.removeMiscAmount(amountToDelete);
                        }

                        //expenses.removeAt(index);
                        appState.listOfExpenses.remove(expenseToDelete);
                        appState
                            .deleteFromTotalExpenses(expenseToDelete.amount);
                        //now need to add it back into the list at indexToEdit positon

                        

                        if (dateToAdd != dateEdited) {
                          dateToAdd = Date(
                              day: pickedDate!.day,
                              month: pickedDate!.month,
                              year: pickedDate!.year);
                        }

                        Expenses expensetoAdd = Expenses(
                            date: dateToAdd,
                            category: category,
                            amount: amountToAdd);
                        if (category == "Housing") {
                          appState.addToHousingAmount(amountToAdd);
                        } else if (category == "Transportation") {
                          appState.addToTransportationAmount(amountToAdd);
                        } else if (category == "Food") {
                          appState.addToFoodAmount(amountToAdd);
                        } else if (category == "Utilities") {
                          appState.addToUtilitiesAmount(amountToAdd);
                        } else if (category == "Insurance") {
                          appState.addToInsuranceAmount(amountToAdd);
                        } else if (category == "Healthcare") {
                          appState.addToHealthcareAmount(amountToAdd);
                        } else if (category == "Savings") {
                          appState.addToSavingsAmount(amountToAdd);
                        } else if (category == "Personal") {
                          appState.addToPersonalAmount(amountToAdd);
                        } else if (category == "Entertainment") {
                          appState.addToEntertainmentAmount(amountToAdd);
                        } else {
                          appState.addToMiscAmount(amountToAdd);
                        }

                        appState.listOfExpenses
                            .insert(indexToEdit, expensetoAdd);
                        //expenses.add(expensetoAdd);
                        yearController.clear();
                        amountController.clear();
                        categoryController.clear();
                        category = null;
                        totalExpense += expensetoAdd.amount;
                        appState.addToTotalExpenses(expensetoAdd.amount);
                        editButtonPressed = false;
                        indexToEdit = -1;
                        appState.colorForEditButton=const Color.fromARGB(255, 234, 196, 130);
                        appState.colorForDeleteButton=const Color.fromARGB(255, 239, 71, 71);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Color.fromARGB(255, 222, 157, 6),
                              content: Row(
                                children: [
                                  Icon(Icons.error),
                                  Text(
                                      "ERROR: Please fill  all required fields",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              )),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromARGB(255, 222, 157, 6),
                            content: Row(
                              children: [
                                Icon(Icons.error),
                                Text(
                                    "ERROR: Please fill eee all required fields",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )),
                      );
                    }

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //const SnackBar(
                    // backgroundColor: Color.fromARGB(255, 222, 157, 6),
                    // content: Row(
                    //children: [
                    //Icon(Icons.error),
                    // Text(
                    //   "ERROR: Please fill in all required fields",
                    // style: TextStyle(fontSize: 14)),
                    // ],
                    //)),
                    //);
                  }),
                  icon: Icon(Icons.check),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          appState.scheme.secondaryContainer)),
                  label: Text(
                    "Confirm",
                    style:
                        TextStyle(color: appState.scheme.onSecondaryContainer),
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  scale: 1,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    onPressed: sortMethod,
                    label: Text(
                      sortAmount,
                      style: TextStyle(
                          fontSize: 10,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    icon: Transform.flip(
                        flipY: SortAmount,
                        child: Icon(
                          Icons.swap_vert,
                          color: appState.scheme.onTertiaryContainer,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  scale: 1,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    onPressed: sortDateMethod,
                    label: Text(
                      sortDate,
                      style: TextStyle(
                          fontSize: 10,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    icon: Transform.flip(
                        flipY: SortDate,
                        child: Icon(Icons.swap_vert,
                            color: appState.scheme.onTertiaryContainer)),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  scale: 1,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            appState.scheme.tertiaryContainer)),
                    onPressed: sortCategoryMethod,
                    label: Text(
                      sortCategory,
                      style: TextStyle(
                          fontSize: 10,
                          color: appState.scheme.onTertiaryContainer),
                    ),
                    icon: Transform.flip(
                        flipX: SortCategory,
                        child: Icon(Icons.sort_by_alpha,
                            color: appState.scheme.onTertiaryContainer)),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.all(16),
                        tileColor: appState.scheme.primaryContainer,
                        leading: Icon(Icons.money),
                        title: Text(
                          "\$${appState.getAmount(expenses[index]).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: appState.scheme.onPrimaryContainer),
                        ),
                        subtitle: Text(
                            "${appState.getDate(expenses[index])} \n${appState.getCategory(expenses[index])}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 0.75,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(appState.colorForEditButton)),
                                onPressed: () => setState(() {
                                  if (editButtonPressed == false) {
                                    amountController.text =
                                        "${appState.getAmount(expenses[index]).toStringAsFixed(2)}";
                                    yearController.text =
                                        "${appState.getDate(expenses[index]).month}/${appState.getDate(expenses[index]).day}/${appState.getDate(expenses[index]).year}";
                                    categoryController.text =
                                        "${appState.getCategory(expenses[index])}";
                                    editButtonPressed = true;
                                    indexToEdit = index;
                                    dateEdited =
                                        appState.getDate(expenses[index]);
                                    dateToEdit =
                                        "${appState.getDate(expenses[index]).month}/${appState.getDate(expenses[index]).day}/${appState.getDate(expenses[index]).year}";
                                    categoryToEdit = categoryController.text;
                                    
                                    appState.colorForEditButton=const Color.fromARGB(255, 232, 164, 45);
                                    appState.colorForDeleteButton=const Color.fromARGB(255, 237, 143, 143);
                                    
                                  } else {
                                    indexToEdit = -1;
                                    yearController.clear();
                                    amountController.clear();
                                    categoryController.clear();
                                    editButtonPressed = false;
                                    appState.colorForEditButton=const Color.fromARGB(255, 234, 196, 130);
                                    appState.colorForDeleteButton=const Color.fromARGB(255, 239, 71, 71);
                                  }
                                }),
                                child: Icon(Icons.edit,
                                    color:
                                        appState.scheme.onSecondaryContainer),
                              ),
                            ),

                            //SizedBox(width:5),

                            Transform.scale(
                              scale: 0.75,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll<Color>(appState.colorForDeleteButton)),
                                  onPressed: () => setState(() {
                                        if(editButtonPressed==false){
                                        Expenses expenseToDelete =
                                            expenses[index];
                                        double amountToDelete =
                                            expenseToDelete.amount;
                                        String cat = appState
                                            .getCategory(expenses[index]);
                                        if (cat == "Housing") {
                                          appState.removeHousingAmount(
                                              amountToDelete);
                                        } else if (cat == "Transportation") {
                                          appState.removeTransportationAmount(
                                              amountToDelete);
                                        } else if (cat == "Food") {
                                          appState
                                              .removeFoodAmount(amountToDelete);
                                        } else if (cat == "Utilities") {
                                          appState.removeUtilitiesAmount(
                                              amountToDelete);
                                        } else if (cat == "Insurance") {
                                          appState.removeInsuranceAmount(
                                              amountToDelete);
                                        } else if (cat == "Healthcare") {
                                          appState.removeHealthcareAmount(
                                              amountToDelete);
                                        } else if (cat == "Savings") {
                                          appState.removeSavingsAmount(
                                              amountToDelete);
                                        } else if (cat == "Personal") {
                                          appState.removePersonalAmount(
                                              amountToDelete);
                                        } else if (cat == "Entertainment") {
                                          appState.removeEntertainmentAmount(
                                              amountToDelete);
                                        } else {
                                          appState
                                              .removeMiscAmount(amountToDelete);
                                        }

                                        //expenses.removeAt(index);
                                        appState.listOfExpenses
                                            .remove(expenseToDelete);
                                        appState.deleteFromTotalExpenses(
                                            expenseToDelete.amount);
                                        }
                                      }),
                                  child: Icon(Icons.delete,
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
}
