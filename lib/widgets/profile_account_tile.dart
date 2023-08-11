import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';

class ProfileAccountTile extends StatelessWidget {
  final String heading;
  final IconData icon;
  const ProfileAccountTile(
      {super.key, required this.heading, required this.icon});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultSpacing + 4),
          child: Icon(icon, color: isDark ? gCardBgColor : fontHeading),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultSpacing),
          child: Text(
            heading,
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: defaultSpacing),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: isDark ? gCardBgColor : fontHeading,
              ),
            ),
          ),
        )
      ],
    );
  }
}
