import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:fundfolio/tab_screens/analysis_screen_tab.dart';
import 'package:fundfolio/tab_screens/profile_screen_tab.dart';
import 'package:fundfolio/tab_screens/home_screen_tab.dart';
import 'package:fundfolio/tab_screens/stats_screen_tab.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fundfolio/tab_screens/watchlist_screen_tab.dart';

class MainScreenHost extends StatefulWidget {
  const MainScreenHost({super.key});

  @override
  State<MainScreenHost> createState() => _MainScreenHostState();
}

class _MainScreenHostState extends State<MainScreenHost> {
  var currentIndex = 0;

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const WatchlistScreenTab();
      case 1:
        return const StatsScreenTab();
      case 2:
        return const HomeScreenTab();
      case 3:
        return const AnalysisScreenTab();
      case 4:
        return const HomeProfileTab();
      default:
        return const WatchlistScreenTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildTabContent(currentIndex),
      //   bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: currentIndex,
      //     type: BottomNavigationBarType.fixed,
      //     showUnselectedLabels: false,
      //     backgroundColor: isDark ? Colors.black26 : Colors.white60,
      //     onTap: (index) {
      //       setState(() {
      //         currentIndex = index;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         // icon: const Icon(Icons.card_travel_rounded),
      //         icon: Icon(CupertinoIcons.tags),
      //         label: 'Watchlist',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(CupertinoIcons.chart_bar_alt_fill),
      //         label: "Insights",
      //       ),
      //       BottomNavigationBarItem(
      //         // icon: const Icon(Icons.card_travel_rounded),
      //         icon: Icon(FontAwesomeIcons.suitcase),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.analytics_outlined),
      //         label: "Analysis",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(FontAwesomeIcons.userAstronaut),
      //         label: "Profile",
      //       ),
      //     ],
      //   ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: isDark ? Colors.black26 : Colors.white60,
          // color:  Colors.white60,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0322,
                    left: size.width * .0322,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: const BoxDecoration(
                    color: secondaryDark,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: size.width * .076,
                  color: index == currentIndex
                      ? Colors.blueAccent
                      : isDark
                          ? fontSubHeading
                          : Colors.black54,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    CupertinoIcons.tags,
    CupertinoIcons.chart_bar_alt_fill,
    Icons.card_travel_rounded,
    Icons.analytics_outlined,
    FontAwesomeIcons.userAstronaut,
  ];
}
