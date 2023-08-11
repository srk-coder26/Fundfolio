// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundfolio/models/watchlist_model.dart';
import 'package:fundfolio/screens/watchlist_details_page.dart';
import 'package:fundfolio/services/google_sheets_api.dart';
import 'package:fundfolio/widgets/loading.dart';
import 'package:fundfolio/widgets/two_tile.dart';
import '../constants/constants.dart';

class WatchlistScreenTab extends StatefulWidget {
  const WatchlistScreenTab({super.key});

  @override
  State<WatchlistScreenTab> createState() => _WatchlistScreenTabState();
}

class _WatchlistScreenTabState extends State<WatchlistScreenTab> {
  List<GetWatchlistModel> getWatchlist = GoogleSheetsApi.getWatchlist;
  final controller = TextEditingController();

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loadWatchlist == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // start loading until the data arrives
    if (GoogleSheetsApi.loadWatchlist == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.transparent,
        //     ),
        //     child: ClipRRect(
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //       child: Image.asset('assets/images/avatar.jpeg'),
        //     ),
        //   ),
        // ),
        title: Text('Master Watchlist'),
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
                      'Buy',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      'Hold',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text(
                      'Sell',
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
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? Color(0xFF121212) : fontSubHeading,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search...",
                suffixIcon: const Icon(Icons.search_rounded, size: 30),
              ),
              onChanged: searchFunds,
            ),
          ),
          const SizedBox(height: 15),
          GoogleSheetsApi.loadWatchlist == true
              ? Loading()
              : Expanded(
                  child: ListView.builder(
                    itemCount: getWatchlist.length,
                    itemBuilder: (context, index) {
                      final item = getWatchlist[index];
                      final name = item.fundName!.contains('NSE:')
                          ? item.fundName!.replaceAll(RegExp(r'NSE:'), '')
                          : item.fundName!;

                      return TwoTile(
                        title: name,
                        trail: '₹${item.cmp!}',
                        padding: 4,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WatchlistDetailsPage(fund: item),
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
    final suggestions = GoogleSheetsApi.getWatchlist.where((fund) {
      final fundName = fund.fundName!.toLowerCase();
      final input = query.toLowerCase();

      return fundName.contains(input);
    }).toList();

    setState(() => getWatchlist = suggestions);
  }

  void filterFunds(String query) {
    final suggestions = GoogleSheetsApi.getWatchlist.where((fund) {
      final fundType = fund.signal!.toLowerCase();
      final input = query.toLowerCase();
      final res = fundType.contains(input);
      return res;
    }).toList();
    if (suggestions.toList().isEmpty) {
      setState(() => getWatchlist = GoogleSheetsApi.getWatchlist);
    } else {
      setState(() => getWatchlist = suggestions);
    }
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        filterFunds('Show All');
        break;
      case 1:
        filterFunds('Buy');
        break;
      case 2:
        filterFunds('Hold');
        break;
      case 3:
        filterFunds('Sell');
        break;
    }
  }
}
