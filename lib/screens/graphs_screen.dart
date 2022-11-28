import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_collection.dart';

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
      appBar: AppBar(
        title: Text(widget.companySymbol),
      ),
      body: FutureBuilder(
        future: ApiCollection.getBalanceSheetData(widget.companySymbol),
        builder: (context, AsyncSnapshot<Map> snapshot) {
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
              // print(snapshot.data);
              return Text(snapshot.data.toString());
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
