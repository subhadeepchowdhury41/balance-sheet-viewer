import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/app_constants.dart';
import 'package:untitled1/app_models/app_classes.dart';
import 'package:untitled1/app_widgets/display_data_row.dart';
import 'package:untitled1/app_widgets/line_chart.dart';

class DisplaySheetElementsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> sheets;
  const DisplaySheetElementsScreen({
    Key? key,
    required this.sheets,
  }) : super(key: key);

  @override
  State<DisplaySheetElementsScreen> createState() =>
      _DisplaySheetElementsScreenState();
}

class _DisplaySheetElementsScreenState
    extends State<DisplaySheetElementsScreen> {
  List<Map<String, dynamic>> _balanceSheets = [];
  int _currentDateIndex = 0;

  @override
  void initState() {
    super.initState();
    // print(widget.sheets);
    _balanceSheets = widget.sheets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Balance Sheet for ${_balanceSheets[_currentDateIndex]['date']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      elevation: 20,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 0,
                            child: Text('2021', style: kPopUpMenuItemTextStyle),
                          ),
                          PopupMenuItem(
                              value: 1,
                              child:
                                  Text('2020', style: kPopUpMenuItemTextStyle)),
                          PopupMenuItem(
                              value: 2,
                              child:
                                  Text('2019', style: kPopUpMenuItemTextStyle)),
                          PopupMenuItem(
                              value: 3,
                              child:
                                  Text('2018', style: kPopUpMenuItemTextStyle)),
                          PopupMenuItem(
                              value: 4,
                              child:
                                  Text('2017', style: kPopUpMenuItemTextStyle)),
                        ];
                      },
                      onSelected: (dateNumber) {
                        setState(() {
                          _currentDateIndex = dateNumber;
                        });
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: Text(
                '( All revenue is in USD )',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),

            /// balance sheets elements
            ..._balanceSheets[_currentDateIndex].keys.map((field) {
              return GestureDetector(
                onTap: () {
                  /// TODO: SHOW LINE-CHART OF SELECTED FIELD ON POPUP
                  showLineChart(field);
                },
                child: DisplayData(
                    value: _balanceSheets[_currentDateIndex][field],
                    field: field),
              );
            }),
            // SFLineChartSample(),
          ],
        ),
      ),
    );
  }

  void showLineChart(String field) {
    if (_checkValidField(field) == false) {
      return;
    }

    /// get chart data
    List<SFLineChartData> lineData = [];
    for (var sheet in _balanceSheets) {
      String date = sheet['date'].toString().substring(0, 4);
      int value = sheet[field];
      lineData.add(SFLineChartData(date, value));
    }

    /// show chart
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade700,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              field,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            SFLineChartSample(lineData: lineData),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  bool _checkValidField(String field) {
    if (field == 'date' ||
        field == 'symbol' ||
        field == 'reportedCurrency' ||
        field == 'cik' ||
        field == 'fillingDate' ||
        field == 'acceptedDate' ||
        field == 'calendarYear' ||
        field == 'period' ||
        field == 'link' ||
        field == 'finalLink') {
      return false;
    }
    return true;
  }
}
