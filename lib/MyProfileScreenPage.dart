import 'dart:async';
import 'dart:io';

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
import 'package:google_fonts/google_fonts.dart';
import 'DateClass.dart';

class ProfileScreenn extends StatefulWidget {
  const ProfileScreenn({super.key});

  @override
  _ProfileScreennState createState() => _ProfileScreennState();
}

class _ProfileScreennState extends State<ProfileScreenn> {
  var email;

    
 
   IconData pass=Icons.lock_reset;
   String changePass="Send Password Reset Link";
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    var appState = context.watch<MyAppState>();
     double scaleW=appState.scaleWidth;
    double scaleH=appState.scaleHeight;

    if (user != null) {
      String uid = user.uid;

      email = user.email;

      return Container(
          child: Center(
              child: Column(
        children: [
          SizedBox(height: 25*scaleH),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle, size: 180*scaleH, color: Colors.grey),
            ],
          ),
          SizedBox(
            height: 20*scaleH,
          ),
          Text("${email}",
              style: GoogleFonts.arOneSans(
                textStyle: TextStyle(
                    fontSize: 15*scaleW, decoration: TextDecoration.underline),
              )),
          SizedBox(height: 10*scaleH),
          Text(
              "Spendreamer since ${Date(year: user!.metadata.creationTime!.year, month: user.metadata.creationTime!.month, day: user.metadata.creationTime!.day)}",style: TextStyle(fontSize: 12*scaleW),),
          SizedBox(
            height: 50*scaleH,
          ),
          OutlinedButton.icon(
              onPressed: () async {
                if (this.mounted) {
                setState(() {
                    pass = Icons.check;
                    changePass="Password Reset Link Sent";
                  });
                }
                await auth.sendPasswordResetEmail(email: email);
                
                  
await Future.delayed(Duration(seconds: 2));
                if(this.mounted){
                setState(() {
                   pass=Icons.lock_reset;
                   changePass="Send Password Reset Link";
                });
                }
                
                
              },
              label:  Text(changePass,style: TextStyle(fontSize: 12*scaleW),),
              icon:
                  Icon(pass,size:24*scaleW) //need to figure out sizing
              ),
          SizedBox(height: 80*scaleH),
          SizedBox(
            height: 42*scaleH,
            width: 400*scaleW,
            child: OutlinedButton.icon(
              onPressed: () async {
                appState.changeSignedOutBoolean();
                await FirebaseAuth.instance.signOut();

                appState.changeBoolean();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthGate()),
                );
              },
              label:  Text("Sign out",style: TextStyle(fontSize: 12*scaleW),),
              icon: Icon(Icons.logout,size: 24*scaleW,),
            ),
          ),
          SizedBox(
            height: 15*scaleH,
          ),
          SizedBox(
            width: 400*scaleW,
            height: 42*scaleH,
            child: OutlinedButton.icon(
              onPressed: () async {
                await appState.deleteAccount();
                await appState.clearExpenseList();
                await appState.clearFExpenseList();
                appState.changeBoolean();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthGate()),
                );
              }, // this delete button works now, deletes from user authentication, users colleciton, and expenses collection
              icon: Icon(Icons.delete,size:24*scaleW),
              label:  Text(
                "Delete account", style:TextStyle(fontSize: 12*scaleW)
              ),

              style: OutlinedButton.styleFrom(
                  iconColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 172, 21, 10)),
            ),
          ),
        ],
      )));
    } else {
      return Text(
          "df"); //if statement here to prevent error from when user signs out and user is null
    }
  }
}
