import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
} 


// Hello

//make flask API route for login database


//NEXT STEPS: Make dropdown for category, 
//make sort button which maybe for now sorts the expenses by amount spent (greatest to least or vice versa)
//make budgeting screen which for now just diplays the total money spent and how its distrbuted for each category.
//Develop backend