import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ProfileGeneralTile extends StatelessWidget {
  final String title; final IconData icon;
  final String subtitle;
  const ProfileGeneralTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ListTile(
      horizontalTitleGap: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultSpacing / 4,
          vertical: defaultSpacing / 2,
        ),
        child: Icon(icon,color: isDark ? gCardBgColor : fontHeading),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right_rounded,
        color: isDark ? gCardBgColor : fontHeading,
      ),
    );
  }
}