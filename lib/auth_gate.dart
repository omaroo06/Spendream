import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'MenuScreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Image.asset(
                'assets/newLogin.png',
                height: 3000,
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Spendream, please sign in!')
                    : const Text('Welcome to Spendream, please sign up!'),
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    color: colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              )),
                          SizedBox(height: 30),
                          const Text(
                            'By signing in, you agree to our terms and conditions.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : const Text(
                        'By signing in, you agree to our terms and conditions.',
                        style: TextStyle(color: Colors.grey),
                      ),
              );
            },
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              }),
            ],
          );
        }
        return MenuScreen();
      },
    );
  }
}
