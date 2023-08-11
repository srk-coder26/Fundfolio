import 'package:flutter/material.dart';
import 'package:fundfolio/services/google_sheets_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants/constants.dart';
import '../models/pie_chart_model.dart';

class BreakdownScreen extends StatefulWidget {
  const BreakdownScreen({super.key});

  @override
  State<BreakdownScreen> createState() => _BreakdownScreenState();
}

class _BreakdownScreenState extends State<BreakdownScreen> {
  late List<BreakdownData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late double _mfBreak, _ieBreak, _useBreak, _goldBreak;

  @override
  void initState() {
    parseInt();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultSpacing * 1.5),

          // Investment Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Investment Breakdown',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: fontSubHeading),
            ),
          ),
          const SizedBox(height: defaultSpacing*3.4),

          SfCircularChart(
            palette: const [
              Color(0xFF2972b6),
              Color(0xFF010048),
              Color(0xFF090088),
              Color(0xFF001d4f),
            ],
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
              alignment: ChartAlignment.center,
              textStyle: GoogleFonts.montserrat(
                color: fontSubHeading,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              iconHeight: 18,
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<BreakdownData, String>(
                dataSource: _chartData,
                radius: '140',
                legendIconType: LegendIconType.pentagon,
                xValueMapper: (BreakdownData data, _) => data.label,
                yValueMapper: (BreakdownData data, _) => data.value,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: GoogleFonts.montserrat(
                    color: fontSubHeading,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                enableTooltip: true,
              )
            ],
          ),
        ],
      ),
    );
  }

  List<BreakdownData> getChartData() {
    final List<BreakdownData> dataSet = [
      BreakdownData(_goldBreak, 'Gold & Silver'),
      BreakdownData(_ieBreak, 'Indian Equities'),
      BreakdownData(_useBreak, 'US Equities'),
      BreakdownData(_mfBreak, 'Mutual Funds'),
    ];
    return dataSet;
  }

  void parseInt() {
    setState(() {
      _goldBreak = double.parse(GoogleSheetsApi.goldBreak);
      _ieBreak = double.parse(GoogleSheetsApi.ieBreak);
      _mfBreak = double.parse(GoogleSheetsApi.mfBreak);
      GoogleSheetsApi.useBreak.contains('#N/A')
          ? _useBreak = 0.0
          : _useBreak = double.parse(GoogleSheetsApi.useBreak);
    });
  }
}
