// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';

class ReturnsData {
  final String label, amount;
  final IconData icon;
  ReturnsData(this.label, this.amount, this.icon);
}

class ReturnsCard extends StatelessWidget {
  final ReturnsData returnsData;
  const ReturnsCard({super.key, required this.returnsData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 90,
        padding: EdgeInsets.all(defaultSpacing),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              spreadRadius: 3,
              blurRadius: 12,
            )
          ],
          color: returnsData.label == "Gains" ? secondaryDark : primaryDark,
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    returnsData.label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: defaultSpacing / 3),
                    child: Text(
                      returnsData.amount,
                      style: Theme.of(context).textTheme.titleLarge,
                    ), 
                  ),
                ],
              ),
            ),
            Icon(returnsData.icon, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
