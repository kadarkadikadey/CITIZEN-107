import 'package:citizen_107/common/costom_button.dart';
import 'package:citizen_107/login_screen/login_page/login_page.dart';
import 'package:citizen_107/login_screen/singup_page/singup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CITIZEN 107')),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (contaxt, snapshot) {
          bool isLoggedIn = snapshot.hasData && snapshot.data != null;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Hello, Welcome to Citizen 107',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '==> Happy to see you that you are Willing to intested in doing Volunter Work for your Near By Emergancy',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '==>  If You Are Alredy Become Volunter Worker then Login To Continew Your Service And Gain Emergency Messages',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 30),
                  CostomButton(
                    // Change text if already logged in
                    text: isLoggedIn ? 'Already Logged In' : 'Login',
                    // Setting onPressed to null usually disables a button in Flutter
                    onPressed: isLoggedIn
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          }
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '==> If You Are New To This App and Want To Become Volunter Worker Then Follow The Signup Process To Become Volunter',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 30),
                  CostomButton(
                    text: 'SignUp',
                    // Also disable Signup if they are already logged in
                    onPressed: isLoggedIn
                        ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SingupPage(),
                              ),
                            );
                        }
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SingupPage(),
                              ),
                            );
                          },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '==>  Please Read The Polices and Services to Better Understanding',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
