// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fundfolio/screens/splash_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService extends StatefulWidget {
  const ConnectivityService({super.key});

  @override
  State<ConnectivityService> createState() => _ConnectivityServiceState();
}

class _ConnectivityServiceState extends State<ConnectivityService> {
  late StreamSubscription subscription;
  late bool isDeviceConnected;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Failed to connect to\nGoogle Sheets.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Text(
            "This usually means there's a network issue between your internet provider and the Google Sheets.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Retry'),
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
          if (isDeviceConnected) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
      );
}
