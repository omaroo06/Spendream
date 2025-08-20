import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'MenuScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    
    var appState = context.watch<MyAppState>();
    final colorScheme = Theme.of(context).colorScheme;
    
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
  
   appState.scaleHeight=screenHeight/932;
    appState.scaleWidth=screenWidth/430;


    
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
         //start comment
          //if(snapshot.data==null||!snapshot.hasData){
            return SignInScreen(
            providers: [EmailAuthProvider()],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Image.asset(
                'assets/newLogin.png',
                height: 3000*appState.scale,
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ?  Text('Welcome to Spendream, please sign in!',style: TextStyle(fontSize: 14*appState.scale),)
                    :  Text('Welcome to Spendream, please sign up!',style: TextStyle(fontSize: 14*appState.scale),),
              );
            },
            footerBuilder: (context, action) {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: action == AuthAction.signIn
                    ? Column(
                        children: [
                          Card(
                              color: colorScheme.secondaryContainer,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Track your spending today to unlock a brighter tomorrow',
                                  style: TextStyle(
                                    fontSize: 12*appState.scale,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    color: colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              )),
                          SizedBox(height: 30*appState.scale),
                           Text(
                            'By signing in, you agree to our terms and conditions.',
                            style: TextStyle(color: Colors.grey,fontSize: 14*appState.scale),
                          ),
                        ],
                      )
                    :  Text(
                        'By signing in, you agree to our terms and conditions.',
                        style: TextStyle(color: Colors.grey,fontSize: 14*appState.scale),
                      ),
              );
            },
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) async {
                FirebaseAuth auth = FirebaseAuth.instance;
                
                final User? user = auth.currentUser;

                if (user != null) {
                  String uid = user.uid;
                  
                  String? email = user.email;
                  if (email != null) {
             
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    CollectionReference usersCollection =
                        firestore.collection('Users');

                    DocumentReference UserToAdd = usersCollection.doc(email);
                    Future<void> createNewUser() async {
                      QuerySnapshot querySnapshot = await usersCollection
                          .where('email', isEqualTo: email)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        
                        return; 
                      } else {
                        
                        DocumentSnapshot snapshot = await UserToAdd.get();
                       
                        if (!snapshot.exists) {
                          await UserToAdd.set({
                            'Name': "",
                            'userID': uid,
                            'email': email,
                            'totalExpenses': 0.0,
                            'housingAmount': 0.0,
                            'transportationAmount': 0.0,
                            'foodAmount': 0.0,
                            'utilitiesAmount': 0.0,
                            'insuranceAmount': 0.0,
                            'healthcareAmount': 0.0,
                            'savingsAmount': 0.0,
                            'personalAmount': 0.0,
                            'entertainmentAmount': 0.0,
                            'miscAmount': 0.0,
                            'recurringAmount':0.0,
                          });

                         
                        }

                        
                      }
                    }

                    await createNewUser();
                  }
                }
               
                if (appState.hastheMethodbeencalledyet == false) {
                   await appState.clearExpenseList();
                  await appState.getAllExpensesinListforUser();
                  
                 

               }
                

                  await appState.makeRecurringPayment();
                  await appState.deleteFutureExpenseOnLastDate();
                 
                  await appState.clearFExpenseList();
                  await appState.getAllFExpensesinListforUser();

                   await appState.getCatTotal();

                await appState.getCount();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              }),
                AuthStateChangeAction<UserCreated>((context, state) async {

FirebaseAuth auth = FirebaseAuth.instance;
                
                final User? user = auth.currentUser;

                
                if (user != null) {
                  String uid = user.uid;
                  
                  String? email = user.email;
                  if (email != null) {
             
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    CollectionReference usersCollection =
                        firestore.collection('Users');

                    DocumentReference UserToAdd = usersCollection.doc(email);
                    Future<void> createNewUser() async {
                      QuerySnapshot querySnapshot = await usersCollection
                          .where('email', isEqualTo: email)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        
                        return; 
                      } else {
                        
                        DocumentSnapshot snapshot = await UserToAdd.get();
                       
                        if (!snapshot.exists) {
                          await UserToAdd.set({
                            'Name': "",
                            'userID': uid,
                            'email': email,
                            'totalExpenses': 0.0,
                            'housingAmount': 0.0,
                            'transportationAmount': 0.0,
                            'foodAmount': 0.0,
                            'utilitiesAmount': 0.0,
                            'insuranceAmount': 0.0,
                            'healthcareAmount': 0.0,
                            'savingsAmount': 0.0,
                            'personalAmount': 0.0,
                            'entertainmentAmount': 0.0,
                            'miscAmount': 0.0,
                            'recurringAmount':0.0,
                          });

                         
                        }

                        
                      }
                    }

                    await createNewUser();
                  }
                }
                
                if (appState.hastheMethodbeencalledyet == false) {
                   await appState.clearExpenseList();
                  await appState.getAllExpensesinListforUser();

                  
               }
               await appState.getCatTotal();

                await appState.getCount();
                
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );

                }),

            ],
          );
        
          
        });
  }
}
