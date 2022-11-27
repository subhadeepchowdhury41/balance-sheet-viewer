import 'package:flutter/material.dart';
import 'package:untitled1/api_collection.dart';
import 'package:untitled1/custom_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance Sheet Viewer',
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
    );
  }
}


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchCtrl = TextEditingController();
  // final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 100,),
                FutureBuilder(
                  future: ApiCollection.getAllCompanies(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10,),
                          Center(child: Text('Loading.....'),),
                        ],
                      );
                    } else {
                      if (snapshot.data != null) {
                        print(snapshot.data);
                        return ListView.builder(
                          // controller: _scrollController,
                          shrinkWrap: true,
                          itemCount:snapshot.data!.length,
                          itemBuilder: (context, index) {

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                child: Text(
                                    snapshot.data![index]['price'].toString(),
                                  style: const TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ),
                              title: Text(snapshot.data![index]['symbol']),
                              subtitle: Text(snapshot.data![index]['name']),
                              trailing: ElevatedButton(
                                onPressed: () {

                                },
                                child: const Text('Balance Sheet'),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No Data'),);
                      }
                    }
                  }
                ),
              ],
            ),
          ),
          SearchCompany(searchCtrl: _searchCtrl),
        ],
      ),
    );
  }
}

class SearchCompany extends StatelessWidget {
  const SearchCompany({
    Key? key,
    required TextEditingController searchCtrl,
  }) : _searchCtrl = searchCtrl, super(key: key);

  final TextEditingController _searchCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white12],
            stops: [0.7, 1]
          )
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,

                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: _searchCtrl,
                    decoration: const InputDecoration(

                      border: OutlineInputBorder(),
                        hintText: 'Search by Company Name'),),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(0, 50)
                  ),
                  onPressed: () {

                  },
                  child: const Text('Search')),
            ),
          )
        ],
      ),
    );
  }
}
