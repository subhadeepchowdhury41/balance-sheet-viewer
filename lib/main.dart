

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api_collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Balance Sheet Viewer',
      home: Dashboard(),
    );
  }
}


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late List _companies = [];

  void initialize() async {
    await ApiCollection.getAllCompanies().then((companies) {
      _companies = [...companies];
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Text('Send'),
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ApiCollection.getAllCompanies(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading'),);
              } else {
                if (snapshot.data != null) {
                  print(snapshot.data);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:snapshot.data!.length,
                    itemBuilder: (context, index) {

                      return ListTile(
                        hoverColor: Colors.white38,
                          title: Text(snapshot.data![index]['symbol']),
                        leading: Text(snapshot.data![index]['name']),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No Data'),);
                }
              }
            }
          )
        ],
      ),
    );
  }
}
