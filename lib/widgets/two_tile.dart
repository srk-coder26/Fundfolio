import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';

class TwoTile extends StatefulWidget {
  final String title, trail;
  final VoidCallback? press;
  final int padding;
  const TwoTile({
    super.key,
    required this.title,
    required this.trail,
    this.press,
    required this.padding,
  });

  @override
  State<TwoTile> createState() => _TwoTileState();
}

class _TwoTileState extends State<TwoTile> {
  @override

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultSpacing),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: defaultSpacing / widget.padding),
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
          onTap: widget.press,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.trail,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: widget.trail.contains('-')
                          ? Colors.red
                          : Colors.green,
                    ),
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
