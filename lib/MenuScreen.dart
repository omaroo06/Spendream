import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'BudgetingScreen.dart';
import 'ExpensesScreen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'app.dart';
import 'auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'FutureExpensesScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MyProfileScreenPage.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Widget> pages = [
    
    ProfileScreenn(),
   
    ExpensesPage(),
    //FuturePage(),
    BudgetingPage(),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final colorScheme = Theme.of(context).colorScheme;
    double scaleee = appState.scale;

    double scaleH = appState.scaleHeight;
    double scaleW = appState.scaleWidth;

    
    int screenIndex = appState.screenIndexx;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 60 * scaleH,
        title: Text(
          'SPENDREAM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
            fontSize: 40 * scaleW,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.primary,
      ),
      body: pages[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 224, 232, 223),
        unselectedFontSize: 8 * scaleW,
        selectedFontSize: 14 * scaleW,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
         
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 24 * scaleW), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.money,
                size: 24 * scaleW,
              ),
              label: "Expenses"),
          //BottomNavigationBarItem(
            //  icon: Icon(
              //  Icons.pending_actions,
                //size: 24 * scaleW,
              //),
              //label: "Recurring"),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 24 * scaleW), label: "Summary"),
          
        ],
        currentIndex: screenIndex,
        onTap: (int index) async {
          appState.changeScreenIndex(index);
          appState.yearNumber = 0;
          appState.yearNumberBar = 0;
          appState.colorForEditButton =
              const Color.fromARGB(255, 234, 196, 130);
          appState.colorForDeleteButton =
              const Color.fromARGB(255, 239, 71, 71);
          
        },
      ),
    );
  }
}
