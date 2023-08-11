// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_new

import 'package:flutter/material.dart';
import 'package:fundfolio/models/get_position_model.dart';
import 'package:fundfolio/models/watchlist_model.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "fund-394717",
    "private_key_id": "ab7dc456c0c5b5ed2058d411173154308cb7b320",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCvbCsgwsylbeM0\nqo9yaDpJi4e7KtzvZgrDhfmio+EdJJ9wsbGBHOIZUaI1hC5SQvJa46HL9UYocD+Y\nWuSvz0538zdMGM1JMclC19fxKIhSLF7vrOiC8o4G+cmIvZSrOsbtcMvmLYJZ042x\n4rq7Jx+9zy8FwJwCqjBNytcdu6BjRE3DEkWBv0og8/c1A1fcPeF5++mwq6tP2hux\nzH0ihfX6zpM3x8D6qpPMMe2/f3W0LkoalTlV2BmJleGeMGAvEBqHSLaJ5bSL6bM3\nefEHElrHYHnyBOwPuibx8VYMQ2PMmwrVeQGaX529Mfh1RvLQjBLsa07QKEQPiyhR\na2o2le2pAgMBAAECggEAF20qlUVubukt3mqonW6t2gR4K9adiprl9RZ/L+kStwGd\nCT+xpLxmtVrhfqQYS4QFOX4MrWAj7mKPG5mH0LKul/Yy/EaTo6KyberFO79d9RtX\n0koVAufBb80LzOcEY5mF10+o6yRItBY8ZfURWszuwDpa3TnLm89+g+UCtUXJNXhB\nEGqaPAcW7qPXm2GTuoSGKVy9NMLnfASofJ2CWGbnP3gqPj+vUi/+jbvhSx++zYCr\nA4bNSUtlZrebuDrfvZdeIPLeyriIgNBj/fHrhfaGKDIKc3HlUodLg370OyIDOVxh\nigTIm3vR5drn852k4TwBjRs82eiDKz2kljEE0ORIwQKBgQDUsVyzNx3T08tzqAVs\nQsa0mxJ+a8gA9/QL1FW/UWBShqiewxvDryitWfpVqJWw2ZbtUe2EJpzqiBcOnqyc\n3Va4+9dEpZCp57mKKMo7w2y9KfxL8oas2BmgqzGlAKyhrMDsCglnWdWLOy56ut7g\naWnSlk44PWOSlm+iaBKNiUqlSwKBgQDTJBaa/V7rIrjyBe/n+DrIT53gse6KFRYi\njFK8PXRGIkOfjw7PYB6pNCKP7bK4xCRzl+3ilBEZ4jn0swlhQhJteDnCdasPhBp9\n0LyJCn17BQyVvDT7OhDnTmYTf/Cp7GH92NK+R+Xg2Z/eph5YowNIBqV0fgTlT+Ys\n4MJPSGgEWwKBgQCxOwG1zI2sP2Xe//lU1ufhAv8MHR/Rvsu7N7oj69lJqy/C622t\nR72rhbiVvB7P+OBM7OHwJoTG4ZPk+M94/u8OwbwFVbkP+ymeOJMb7aIklmHHn1Yd\nnQzt1vlNNxyis+MmTM69MhxBIpV+a0zgzrYBZoHTV0Qrl/N57yLWkbqDtQKBgQDR\ndmPWrrWTn4bK04kFIAVw40tEtkBnTDQBYiRSCsVnLmbXzBxtLnY8djQzhSRgmHVx\nF7Avr6SngP7t+w+7JMkTQMpMWF+zrOJ7HrFrYrTJbmDlyyjkct6CGgy6G5qteIxe\nQNQRYVJ0lnE7eKFyXYXL1owd3UcOFw3KR898x+ApMQKBgCklTypIHw6iZTPx3kPh\nK+HEvgNjXaHwSOgRiQAcWV/IVNfCQLql1xPiWn74ytx3QOYfJnYUeOATOCs7FuOy\n/HsE5PhFBNRSGKUwN1FdT4oaX6rpCxy1XjWzyfUfAddrMCJfLSGANV18yVQsnlMD\nxohzcv5UMtISnCr350oXWesQ\n-----END PRIVATE KEY-----\n",
    "client_email": "fund-10@fund-394717.iam.gserviceaccount.com",
    "client_id": "112998314689413752861",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fund-10%40fund-394717.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }

  ''';

  // set up & connect to the spreadsheet
  static const _spreadsheetId = '1fzT8FkNa4ytTLp8Yd1gl5TpbHp47ifw6kbkLpkBxNp4';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _backend;

  // some variables to keep track of..
  static List<GetFundModel> getFunds = [];
  static List<GetWatchlistModel> getWatchlist = [];
  static List<dynamic> topperFunds = [];
  static bool loadHome = true;
  static bool loadPortfolio = true;
  static bool loadWatchlist = true;

  // Initialising the individual Values
  static String currentAmt = '';
  static String investedAmt = '';
  static String totalGains = '';
  static String gainsPercent = '';
  static String gsCurrent = '';
  static String gsInvested = '';
  static String gsGains = '';
  static String gsPercent = '';
  static String ieCurrent = '';
  static String ieInvested = '';
  static String ieGains = '';
  static String iePercent = '';
  static String useCurrent = '';
  static String useInvested = '';
  static String useGains = '';
  static String usePercent = '';
  static String mfCurrent = '';
  static String mfInvested = '';
  static String mfGains = '';
  static String mfPercent = '';
  static String mfBreak = '';
  static String ieBreak = '';
  static String useBreak = '';
  static String goldBreak = '';

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _backend = ss.worksheetByTitle('Backend');
    loadHomeValues();
    getDataFromSheet();
    getWatchlistFromSheet();
  }

  static Future getWatchlistFromSheet() async {
    const url =
        "https://script.google.com/macros/s/AKfycbwpqPy7t_Nqj2NpD7wRqtRnRGQz62S0Z27rR3TS4EAujccZGKDcfX2-peI7kFcttN0Esg/exec";

    var raw = await http.get(Uri.parse(url));

    if (raw.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(raw.body);
      jsonResponse.forEach((element) {
        GetWatchlistModel model = new GetWatchlistModel();
        model.fundName = "${element['Symbol']}";
        model.signal = "${element['Signal']}";
        model.cmp = "${element['CMP']}";
        model.targetBuy = "${element['Target Buy']}";
        model.change = "${element['Change %']}";
        model.eps = "${element['EPS']}";
        model.buyDiff = "${element['Buy Difference']}";

        getWatchlist.add(model);
      });
      print('Watchlist Values has been loaded');
      loadWatchlist = false;
      // return jsonResponse.map((data) => GetFundModel.fromJson(data)).toList();
    } else {
      Get.snackbar(
        "Opps!..",
        'Failed to fetch the Watchlist Data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.black,
      );
      throw Exception('Failed to fetch the sheet Data');
    }
  }

  static Future getDataFromSheet() async {
    const url =
        "https://script.google.com/macros/s/AKfycbxV4JmQBhQxQZE_-GHLDb4bdRnJTSGjIjdZHi90vlC4DHgLmfqMa2A2Yrzgg4W8UBbq/exec";

    var raw = await http.get(Uri.parse(url));

    if (raw.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(raw.body);
      jsonResponse.forEach((element) {
        GetFundModel model = new GetFundModel();
        model.fundName = "${element['Fund Names']}";
        model.fundType = "${element['Stock Type']}";
        model.fundCurrentPrice = "${element['LMP']}";
        model.fundCurrentChange = "${element['Change ₹']}";
        model.fundReturns = "${element['Gain ₹']}";
        model.fundPercent = "${element['Gain %']}";
        model.fundChangePercent = "${element['Change %']}";
        model.fundInvestment = "${element['IOS']}";
        model.fundUnits = "${element['Units']}";
        model.fundCurrentValue = "${element['Current Value']}";
        model.gainerFunds = "${element['Gainer']}";
        model.loserFunds = "${element['Loser']}";

        getFunds.add(model);
      });
      print('Positions Values has been loaded');
      loadPortfolio = false;
      // return jsonResponse.map((data) => GetFundModel.fromJson(data)).toList();
    } else {
      Get.snackbar(
        "Opps!..",
        'Failed to fetch the Positions Data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.black,
      );
      throw Exception('Failed to fetch the sheet Data');
    }
  }

  // Get the individual values from spreadsheet
  static Future loadHomeValues() async {
    if (_backend == null) return;

    try {
      currentAmt = await _backend!.values.value(column: 2, row: 2);
      investedAmt = await _backend!.values.value(column: 2, row: 3);
      totalGains = await _backend!.values.value(column: 2, row: 4);
      gainsPercent = await _backend!.values.value(column: 2, row: 5);

      // Gold Values
      gsCurrent = await _backend!.values.value(column: 11, row: 2);
      gsInvested = await _backend!.values.value(column: 11, row: 3);
      gsGains = await _backend!.values.value(column: 11, row: 4);
      gsPercent = await _backend!.values.value(column: 11, row: 5);

      // Indian Equities Values
      ieCurrent = await _backend!.values.value(column: 8, row: 2);
      ieInvested = await _backend!.values.value(column: 8, row: 3);
      ieGains = await _backend!.values.value(column: 8, row: 4);
      iePercent = await _backend!.values.value(column: 8, row: 5);

      // US Equities Values
      useCurrent = await _backend!.values.value(column: 5, row: 9);
      useInvested = await _backend!.values.value(column: 5, row: 10);
      useGains = await _backend!.values.value(column: 5, row: 11);
      usePercent = await _backend!.values.value(column: 5, row: 12);

      // Mutual Funds Values
      mfCurrent = await _backend!.values.value(column: 5, row: 2);
      mfInvested = await _backend!.values.value(column: 5, row: 3);
      mfGains = await _backend!.values.value(column: 5, row: 4);
      mfPercent = await _backend!.values.value(column: 5, row: 5);

      // Investment Break down Values
      useBreak = await _backend!.values.value(column: 5, row: 13);
      mfBreak = await _backend!.values.value(column: 5, row: 6);
      ieBreak = await _backend!.values.value(column: 8, row: 6);
      goldBreak = await _backend!.values.value(column: 11, row: 6);

      print('Backend Values has been loaded');
      loadHome = false;
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Opps!..",
        'Failed to load backend details. Try again after some time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.shade100,
        colorText: Colors.black,
      );
      loadHome = true;
    }
  }
}
