// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:fundfolio/tab_screens/main_screen_host.dart';
import 'package:fundfolio/services/local_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool authenticated = false;

  void goToHome() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreenHost()),
    );
    setState(() {
      authenticated = false;
    });
    return null;
  }

  clickAuth() async {
    if (authenticated == false) {
      final auth = await LocalAuth.authenticate();
      setState(() {
        authenticated = auth;
      });
      if (authenticated) {
        goToHome();
      }
    }
  }

  @override
  void initState() {
    if(authenticated == false)
    {
      clickAuth();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Fundfolio",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 80.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/user-2.png', width: 120.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Biometric Auth',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Authenticate with Biometric Sensors',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          clickAuth();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.fingerprint),
                            const SizedBox(width: 10),
                            Text(
                              'Login with Biometric',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
