// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/get_position_model.dart';
import '../services/google_sheets_api.dart';
import '../widgets/scrollable_widget.dart';

class FundsTablePage extends StatefulWidget {
  const FundsTablePage({super.key});

  @override
  _FundsTablePageState createState() => _FundsTablePageState();
}

class _FundsTablePageState extends State<FundsTablePage> {
  List<GetFundModel> getFunds = GoogleSheetsApi.getFunds;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: ScrollableWidget(child: buildDataTable()));

  Widget buildDataTable() {
    final columns = ['Ticker', 'Invested Amount', 'Current Value', 'Growth'];

    return Padding(
      padding: const EdgeInsets.all(15),
      child: DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columns),
        rows: getRows(getFunds),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column), onSort: onSort),
      )
      .toList();

  List<DataRow> getRows(List<GetFundModel> funds) =>
      funds.map((GetFundModel fund) {
        final cells = [
          fund.fundName,
          '₹ ${fund.fundInvestment}',
          '₹ ${fund.fundCurrentValue}',
          '${fund.fundPercent}%'
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      getFunds.sort(
        (fund1, fund2) => compareValue(
          ascending,
          fund1.fundCurrentValue!,
          fund2.fundCurrentValue!,
        ),
      );
    } else if (columnIndex == 3) {
      getFunds.sort(
        (fund1, fund2) => compareGrowth(
          ascending,
          fund1.fundPercent!,
          fund2.fundPercent!,
        ),
      );
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareValue(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  int compareGrowth(bool ascending, String value1, String value2) =>
      ascending ? value2.compareTo(value1) : value1.compareTo(value2);
}
