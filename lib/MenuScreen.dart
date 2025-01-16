import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'BudgetingScreen.dart';
import 'ExpensesScreen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'app.dart';
import 'auth_gate.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Widget> pages = [
    ProfileScreen(
      actions: [
        SignedOutAction((context) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AuthGate()),
          );
        })
      ],
    ),
    ExpensesPage(),
    BudgetingPage()
  ];

  // void selectingScreenMethod(int index) {
  //   setState(() {
  //     screenIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final colorScheme = Theme.of(context).colorScheme;

    int screenIndex = appState.screenIndexx;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'SPENDREAM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
            fontSize: 40,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.primary,
      ),
      body: pages[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Expenses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Summary"),
        ],
        currentIndex: screenIndex,
        onTap: (int index) {
          setState(() {
            appState.changeScreenIndex(index);
            appState.yearNumber=0;
            appState.yearNumberBar=0;
            appState.colorForEditButton=const Color.fromARGB(255, 234, 196, 130);
            appState.colorForDeleteButton=const Color.fromARGB(255, 239, 71, 71);
          });
        },
      ),
    );
  }
}
