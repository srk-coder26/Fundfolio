// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:fundfolio/widgets/profile_account_tile.dart';

import '../widgets/portfolio_modal_sheet.dart';
import '../widgets/profile_general_tile.dart';

class HomeProfileTab extends StatelessWidget {
  const HomeProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: defaultSpacing),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ),
              color: isDark ? fontSubHeading : Colors.black26,
              onPressed: () => portfolioModalSheet(context, isDark),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultSpacing),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                      child:
                          Image.asset('assets/images/avatar.jpeg', width: 100),
                    ),
                    const SizedBox(height: defaultSpacing),
                    Text(
                      'Shiva Krishnan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'shivakrishnanm26@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultSpacing),
                    child: Text(
                      'General',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: defaultSpacing / 6),
                  ProfileGeneralTile(
                    title: 'Bank Location',
                    subtitle: 'Dubai Kuruku Sandhu',
                    icon: CupertinoIcons.location,
                  ),
                  ProfileGeneralTile(
                    title: 'My Wallet',
                    subtitle: 'Manage your investments',
                    icon: Icons.wallet,
                  ),
                  SizedBox(height: defaultSpacing),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultSpacing),
                    child: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: defaultSpacing),
                  ProfileAccountTile(
                    heading: 'My Account',
                    icon: CupertinoIcons.person,
                  ),
                  SizedBox(height: defaultSpacing),
                  ProfileAccountTile(
                    heading: 'Notification',
                    icon: CupertinoIcons.bell_fill,
                  ),
                  SizedBox(height: defaultSpacing),
                  ProfileAccountTile(
                    heading: 'Privacy',
                    icon: CupertinoIcons.lock_shield,
                  ),
                  SizedBox(height: defaultSpacing),
                  ProfileAccountTile(
                    heading: 'About',
                    icon: CupertinoIcons.info,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
