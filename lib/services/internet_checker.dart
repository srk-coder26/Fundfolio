// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fundfolio/screens/splash_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

class InternetChecker extends StatefulWidget {
  const InternetChecker({Key? key}) : super(key: key);

  @override
  State<InternetChecker> createState() => _InternetCheckerState();
}

class _InternetCheckerState extends State<InternetChecker> {
  bool hasInternet = false;
  late StreamSubscription subscription;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final haveInternet = await InternetConnectionChecker().hasConnection;

      setState(() => hasInternet = haveInternet);
      if (hasInternet == false) {
        final text = hasInternet
            ? "Internet is Connected, But try again after some time"
            : "Please check your internet connection";
        final Color color = hasInternet ? Colors.green : Colors.red;
        showSimpleNotification(
          Text(text, style: Theme.of(context).textTheme.headline4),
          background: color,
        );
      } else if (hasInternet == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SplashPage()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            "Internet Issue",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/images/no_net.json",
                  reverse: true,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Opps!, Internet has been\nnot connected",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            )),
          ),
        ),
      );
}
