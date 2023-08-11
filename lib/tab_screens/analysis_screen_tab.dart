import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:fundfolio/screens/breakdown_screen.dart';
import 'package:fundfolio/screens/insights_screen.dart';
import 'package:fundfolio/screens/returns_table_view.dart';

import '../widgets/portfolio_modal_sheet.dart';

class AnalysisScreenTab extends StatefulWidget {
  const AnalysisScreenTab({super.key});

  @override
  State<AnalysisScreenTab> createState() => _AnalysisScreenTabState();
}

class _AnalysisScreenTabState extends State<AnalysisScreenTab> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Investment Analysis'),
          bottom: const TabBar(
            indicatorColor: secondaryDark,
            tabs: [
              Tab(
                text: 'Insights',
                icon: Icon(Icons.trending_up_rounded, size: 28),
              ),
              Tab(
                text: 'Breakdown',
                icon: Icon(Icons.pie_chart_rounded, size: 28),
              ),
              Tab(
                text: 'Positions',
                icon: Icon(Icons.table_chart_outlined, size: 28),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                ),
                color: isDark ? fontSubHeading : Colors.black26,
                onPressed: () => portfolioModalSheet(context, isDark),
              ),
            )
          ],
        ),
        body: const TabBarView(
          children: [InsightsScreen(), BreakdownScreen(), FundsTablePage()],
        ),
      ),
    );
  }
}
