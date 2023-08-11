import 'dart:math';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:fundfolio/constants/constants.dart';

class InstrumentTile extends StatelessWidget {
  final String ins, insAmt, currAmt, gains, gainsPercent;
  final IconData? icon;
  final Color? color;
  const InstrumentTile({
    super.key,
    required this.ins,
    this.icon,
    this.color,
    required this.insAmt,
    required this.currAmt,
    required this.gains,
    required this.gainsPercent,
  });

  Color getRandomColor() {
    return Color(Random().nextInt(0xFF0000));
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return FocusedMenuHolder(
      menuBoxDecoration:
          const BoxDecoration(border: Border(bottom: BorderSide.none)),
      menuItems: [
        FocusedMenuItem(
          title: Text(
            'Current Value:             $currAmt',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 16, color: fontSubHeading),
          ),
          // trailingIcon: const Icon(Icons.trending_up_rounded),
          onPressed: () {},
          backgroundColor: isDark ? const Color(0xFF272727) : gCardBgColor,
        ),
        FocusedMenuItem(
          title: Text(
            'Invsted Amount:         $insAmt',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 16, color: fontSubHeading),
          ),
          // trailingIcon: const Icon(Icons.money_rounded),
          onPressed: () {},
          backgroundColor: isDark ? const Color(0xFF272727) : gCardBgColor,
        ),
      ],
      blurSize: 10,
      blurBackgroundColor: Colors.black26,
      menuWidth: MediaQuery.of(context).size.width - defaultSpacing * 2,
      menuItemExtent: 45,
      animateMenuItems: false,
      duration: const Duration(seconds: 0),
      menuOffset: 0,
      openWithTap: true,
      onPressed: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: defaultSpacing / 3),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset.zero,
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
          color: isDark ? const Color(0xFF121212) : background,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(defaultSpacing / 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultRadius / 2)),
            ),
            child: Icon(icon, color: fontDark),
          ),
          title: Text(ins, style: Theme.of(context).textTheme.bodyLarge),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(currAmt),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gains,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: gains.contains('-') ? Colors.red : Colors.green,
                    ),
              ),
              const SizedBox(height: 3),
              Text(
                gainsPercent,
                style: TextStyle(
                  color: gainsPercent.contains('-') ? Colors.red : Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
