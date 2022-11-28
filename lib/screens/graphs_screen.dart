import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/app_widgets/display_data_row.dart';
import 'package:untitled1/app_widgets/line_chart.dart';

import '../api_collection.dart';
import 'display_sheet_elements_screen.dart';

class GraphsDataScreen extends StatefulWidget {
  final String companySymbol;
  const GraphsDataScreen({
    Key? key,
    required this.companySymbol,
  }) : super(key: key);

  @override
  State<GraphsDataScreen> createState() => _GraphsDataScreenState();
}

class _GraphsDataScreenState extends State<GraphsDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(widget.companySymbol),
      ),
      body: FutureBuilder(
        future: ApiCollection.getBalanceSheets(widget.companySymbol),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text('Loading.....'),
                ),
              ],
            );
          } else {
            if (snapshot.data != null) {
              List data = snapshot.data!;
              List<Map<String, dynamic>> mapData =
                  (data).map((e) => e as Map<String, dynamic>).toList();
              return DisplaySheetElementsScreen(sheets: mapData);
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          }
        },
      ),
    );
  }
}
