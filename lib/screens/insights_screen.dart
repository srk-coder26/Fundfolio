import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/get_position_model.dart';
import '../services/google_sheets_api.dart';
import '../widgets/loading.dart';
import '../widgets/two_tile.dart';
import 'fund_details_page.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  List<GetFundModel> gainerFunds = GoogleSheetsApi.getFunds;
  List<GetFundModel> loserFunds = GoogleSheetsApi.getFunds;

  @override
  void initState() {
    filterGainers('Yes');
    filterLosers('Yes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultSpacing * 1.5),

        // Investment Categories
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Top Gainers',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: fontSubHeading),
          ),
        ),
        const SizedBox(height: defaultSpacing / 1.5),

        GoogleSheetsApi.loadPortfolio == true
            ? const Loading()
            : Expanded(
                child: ListView.builder(
                  itemCount: gainerFunds.length,
                  itemBuilder: (context, index) {
                    final item = gainerFunds[index];

                    return TwoTile(
                      title: item.fundName!,
                      trail: '${item.fundChangePercent}%',
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

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Top Losers',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: fontSubHeading),
          ),
        ),
        const SizedBox(height: defaultSpacing / 1.5),

        GoogleSheetsApi.loadPortfolio == true
            ? const Loading()
            : Expanded(
                child: ListView.builder(
                  itemCount: loserFunds.length,
                  itemBuilder: (context, index) {
                    final item = loserFunds[index];

                    return TwoTile(
                      title: item.fundName!,
                      trail: '${item.fundChangePercent}%',
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
    );
  }

  void filterGainers(String q) {
    final suggestions = GoogleSheetsApi.getFunds.where((fund) {
      final fundGainer = fund.gainerFunds!.toLowerCase();
      final input = q.toLowerCase();

      return fundGainer.contains(input);
    }).toList();

    setState(() => gainerFunds = suggestions);
  }

  void filterLosers(String q) {
    final suggestions = GoogleSheetsApi.getFunds.where((fund) {
      final fundLoser = fund.loserFunds!.toLowerCase();
      final input = q.toLowerCase();

      return fundLoser.contains(input);
    }).toList();

    setState(() => loserFunds = suggestions);
  }
}
