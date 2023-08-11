// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:fundfolio/services/google_sheets_api.dart';
import 'package:fundfolio/widgets/instrument_tile.dart';
import 'package:fundfolio/widgets/returns_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/loading.dart';
import '../widgets/portfolio_modal_sheet.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key});

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loadHome == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // start loading until the data arrives
    if (GoogleSheetsApi.loadHome == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Portfolio'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
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
      body: GoogleSheetsApi.loadHome == true
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultSpacing,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Bar
                    // ListTile(
                    //   title: Text("Hey! Shiva Krishnan"),
                    //   leading: ClipRRect(
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(defaultRadius)),
                    //     child: Image.asset('assets/images/avatar.jpeg'),
                    //   ),
                    //   trailing: Image.asset('assets/icons/bell.png'),
                    // ),
                    // const SizedBox(height: defaultSpacing / 2),

                    // Showing the account Value
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '₹${GoogleSheetsApi.currentAmt}',
                            style: GoogleFonts.lilitaOne(
                              fontWeight: FontWeight.w500,
                              color: fontSubHeading,
                              fontSize: 38,
                            ),
                          ),
                          const SizedBox(height: defaultSpacing / 4),
                          Text(
                            "Current Value",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultSpacing),

                    // Returns Card Widget
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ReturnsCard(
                            returnsData: ReturnsData(
                              "Total Gains",
                              '₹ ${GoogleSheetsApi.totalGains}',
                              GoogleSheetsApi.gainsPercent.contains('-')
                                  ? Icons.trending_down_rounded
                                  : Icons.trending_up_rounded,
                            ),
                          ),
                        ),
                        SizedBox(width: defaultSpacing),
                        Expanded(
                          child: ReturnsCard(
                            returnsData: ReturnsData(
                              "Gains",
                              '${GoogleSheetsApi.gainsPercent} %',
                              Icons.percent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: defaultSpacing * 1.1),

                    // Investment Categories
                    Text(
                      'All Instruments',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: defaultSpacing / 1.5),

                    InstrumentTile(
                      ins: 'Gold & Silver',
                      icon: Icons.battery_full,
                      color: Colors.yellow.shade300,
                      currAmt: '₹ ${GoogleSheetsApi.gsCurrent}',
                      insAmt: '₹ ${GoogleSheetsApi.gsInvested}',
                      gains: '₹ ${GoogleSheetsApi.gsGains}',
                      gainsPercent: '${GoogleSheetsApi.gsPercent} %',
                    ),

                    InstrumentTile(
                      ins: 'Indian Equities',
                      icon: Icons.show_chart_outlined,
                      color: Colors.tealAccent,
                      currAmt: '₹ ${GoogleSheetsApi.ieCurrent}',
                      insAmt: '₹ ${GoogleSheetsApi.ieInvested}',
                      gains: '₹ ${GoogleSheetsApi.ieGains}',
                      gainsPercent: '${GoogleSheetsApi.iePercent} %',
                    ),

                    InstrumentTile(
                      ins: 'US Equities',
                      icon: Icons.bar_chart_rounded,
                      color: Colors.deepPurple.shade200,
                      gains: GoogleSheetsApi.useGains.contains('#N/A')
                          ? '₹ 0.00'
                          : '₹ ${GoogleSheetsApi.useGains}',
                      currAmt: GoogleSheetsApi.useCurrent.contains('#N/A')
                          ? ''
                          : ' ₹ ${GoogleSheetsApi.useCurrent}',
                      insAmt: '₹ ${GoogleSheetsApi.useInvested}',
                      gainsPercent: GoogleSheetsApi.usePercent.contains('#N/A')
                          ? ''
                          : '${GoogleSheetsApi.usePercent} %',
                    ),

                    InstrumentTile(
                      ins: 'Mutual Funds',
                      icon: Icons.money,
                      color: Colors.blueGrey.shade200,
                      currAmt: '₹ ${GoogleSheetsApi.mfCurrent}',
                      insAmt: '₹ ${GoogleSheetsApi.mfInvested}',
                      gains: '₹ ${GoogleSheetsApi.mfGains}',
                      gainsPercent: '${GoogleSheetsApi.mfPercent} %',
                    ),

                    InstrumentTile(
                      ins: 'Crypto',
                      icon: Icons.copyright_sharp,
                      color: Colors.pink.shade100,
                      currAmt: '',
                      insAmt: '₹ 0.00',
                      gains: '₹ 0.00',
                      gainsPercent: '',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
