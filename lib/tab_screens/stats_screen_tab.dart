// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundfolio/models/get_position_model.dart';
import 'package:fundfolio/screens/fund_details_page.dart';
import 'package:fundfolio/services/google_sheets_api.dart';
import 'package:fundfolio/widgets/loading.dart';
import 'package:fundfolio/widgets/two_tile.dart';
import '../constants/constants.dart';

class StatsScreenTab extends StatefulWidget {
  const StatsScreenTab({super.key});

  @override
  State<StatsScreenTab> createState() => _StatsScreenTabState();
}

class _StatsScreenTabState extends State<StatsScreenTab> {
  List<GetFundModel> getFunds = GoogleSheetsApi.getFunds;
  final controller = TextEditingController();

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loadPortfolio == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // start loading until the data arrives
    if (GoogleSheetsApi.loadPortfolio == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Investments Insights'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: fontSubHeading),
              child: PopupMenuButton<int>(
                position: PopupMenuPosition.under,
                icon: Icon(
                  CupertinoIcons.sort_up,
                  color: isDark ? fontSubHeading : Colors.black26,
                  size: 30,
                ),
                color: Color(0xFF272727),
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'Show All',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      'Indian Equities',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      'US Equities',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text(
                      'Mutual Funds',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      //
      body: Column(
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSpacing),
            child: TextField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? Color(0xFF121212) : fontSubHeading,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search...",
                hintStyle: Theme.of(context).textTheme.titleMedium,
                suffixIcon: const Icon(Icons.search_rounded, size: 30),
              ),
              onChanged: searchFunds,
            ),
          ),
          const SizedBox(height: 15),
          GoogleSheetsApi.loadPortfolio == true
              ? Loading()
              : Expanded(
                  child: ListView.builder(
                    itemCount: getFunds.length,
                    itemBuilder: (context, index) {
                      final item = getFunds[index];

                      return TwoTile(
                        title: item.fundName!,
                        trail: '₹${item.fundReturns!}',
                        padding: 2,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FundDetailsPage(fund: item),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void searchFunds(String query) {
    final suggestions = GoogleSheetsApi.getFunds.where((fund) {
      final fundName = fund.fundName!.toLowerCase();
      final input = query.toLowerCase();

      return fundName.contains(input);
    }).toList();

    setState(() => getFunds = suggestions);
  }

  void filterFunds(String query) {
    final suggestions = GoogleSheetsApi.getFunds.where((fund) {
      final fundType = fund.fundType!.toLowerCase();
      final input = query.toLowerCase();
      final res = fundType.contains(input);
      return res;
    }).toList();

    if (suggestions.toList().isEmpty) {
      setState(() => getFunds = GoogleSheetsApi.getFunds);
    } else {
      setState(() => getFunds = suggestions);
    }
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        filterFunds('Show All');
        break;
      case 1:
        filterFunds('Indian Equities');
        break;
      case 2:
        filterFunds('US Equities');
        break;
      case 3:
        filterFunds('Mutual Fund');
        break;
    }
  }
}
