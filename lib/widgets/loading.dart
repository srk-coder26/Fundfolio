// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fundfolio/constants/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitThreeInOut(
      size: 50,
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: index.isEven ? primaryDark : secondaryDark
          ),
        );
      },
    ));
  }
}
