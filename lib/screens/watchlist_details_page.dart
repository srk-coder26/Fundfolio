import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:fundfolio/models/line_chart_model.dart';
import 'package:fundfolio/models/watchlist_model.dart';
import 'package:fundfolio/widgets/two_tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WatchlistDetailsPage extends StatefulWidget {
  final GetWatchlistModel fund;
  const WatchlistDetailsPage({super.key, required this.fund});

  @override
  State<WatchlistDetailsPage> createState() => _WatchlistDetailsPageState();
}

class _WatchlistDetailsPageState extends State<WatchlistDetailsPage> {
  late List<PriceChartModel> data;
  late String _name;

  @override
  void initState() {
    data = [
      PriceChartModel(day: 27, price: 34.85),
      PriceChartModel(day: 28, price: 35.05),
      PriceChartModel(day: 29, price: 38.2),
      PriceChartModel(day: 30, price: 40.50),
      PriceChartModel(day: 31, price: 39.70),
    ];
    setState(() {
      _name = widget.fund.fundName!.contains('NSE:')
          ? widget.fund.fundName!.replaceAll(RegExp(r'NSE:'), '')
          : widget.fund.fundName!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Price Widget
    Widget price() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${widget.fund.cmp}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
              decoration: BoxDecoration(
                color: widget.fund.change!.contains('-')
                    ? Colors.red.shade400
                    : const Color(0xFF409166),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 2),
                  Icon(
                    widget.fund.change!.contains('-')
                        ? FontAwesomeIcons.caretDown
                        : FontAwesomeIcons.caretUp,
                    size: 20,
                    color: widget.fund.change!.contains('-')
                        ? Colors.black
                        : gCardBgColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.fund.change!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: widget.fund.change!.contains('-')
                              ? Colors.black
                              : gCardBgColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget timeFrames() {
      final timeFrameList = [
        '1D',
        '1M',
        '1Y',
        '3Y',
        '5Y',
      ];

      return SizedBox(
        height: 30,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: timeFrameList.length,
          itemBuilder: (_, index) => Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: index == 0 ? gCardBgColor : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF272727),
            ),
            child: Center(
              child: Text(
                timeFrameList[index],
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      );
    }

    Widget chart() {
      return SfCartesianChart(
        margin: const EdgeInsets.all(0),
        borderWidth: 0,
        borderColor: Colors.transparent,
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          minimum: 27,
          maximum: 31,
          isVisible: false,
          interval: 1,
          borderColor: Colors.transparent,
          borderWidth: 0,
        ),
        primaryYAxis: NumericAxis(
          minimum: 20,
          maximum: 55,
          interval: 5,
          isVisible: false,
          borderColor: Colors.transparent,
          borderWidth: 0,
        ),
        series: <ChartSeries<PriceChartModel, int>>[
          SplineAreaSeries(
            dataSource: data,
            xValueMapper: (PriceChartModel data, _) => data.day,
            yValueMapper: (PriceChartModel data, _) => data.price,
            splineType: SplineType.natural,
            gradient: LinearGradient(
                colors: [splineColor, bgcolor.withAlpha(150)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          SplineSeries(
            dataSource: data,
            color: accentColor,
            width: 2,
            isVisible: true,
            markerSettings: const MarkerSettings(
              color: splineColor,
              borderWidth: 3,
              borderColor: splineColor,
              shape: DataMarkerType.circle,
            ),
            xValueMapper: (PriceChartModel data, _) => data.day,
            yValueMapper: (PriceChartModel data, _) => data.price,
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.navigate_before, size: 24),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child:
                Icon(CupertinoIcons.tags, color: Color(0xFFFFD029), size: 25),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            children: [
              price(),
              const SizedBox(height: 30),
              timeFrames(),
              const SizedBox(height: 10),
              Center(child: chart()),
              const SizedBox(height: defaultSpacing * 1.5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Stock Details',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: fontSubHeading),
                ),
              ),
              const SizedBox(height: defaultSpacing / 1.5),
              TwoTile(
                title: 'Signal',
                trail: widget.fund.signal!.toUpperCase(),
                padding: 3,
              ),
              TwoTile(
                title: 'Target Buy Price',
                trail: '₹ ${widget.fund.targetBuy!}',
                padding: 3,
              ),
              TwoTile(
                title: 'Buy Difference',
                trail: '₹ ${widget.fund.buyDiff!}',
                padding: 3,
              ),
              TwoTile(
                title: 'EPS',
                trail: '₹ ${widget.fund.eps!}',
                padding: 3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
