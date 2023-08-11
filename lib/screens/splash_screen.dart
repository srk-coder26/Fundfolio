import 'package:flutter/material.dart';
import 'package:fundfolio/screens/auth_screen.dart';
import 'package:get/get.dart';

import '../services/google_sheets_api.dart';
import '../services/internet_checker.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

//765EFC
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    GoogleSheetsApi().init();
    goToHome();
    // navigate();
    super.initState();
  }

  navigate() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.offAll(() => const InternetChecker());
  }

  void goToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/icon1.jpg", width: 200),
            // Container(
            //   margin: const EdgeInsets.only(top: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(top: 15),
            //         child: LinearPercentIndicator(
            //           width: 260,
            //           percent: 100 / 100,
            //           animation: true,
            //           animationDuration: 2000,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
