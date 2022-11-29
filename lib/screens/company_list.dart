import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/graphs_screen.dart';
import 'package:untitled1/screens/search_list.dart';

class CompaniesList extends StatefulWidget {
  final List companies;
  const CompaniesList({
    Key? key,
    required this.companies,
  }) : super(key: key);

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  final TextEditingController _searchCtrl = TextEditingController();

  late List<dynamic> _companies = [];
  late List<dynamic> _foundComp = [];
  List<dynamic> _itComp = [];
  List<dynamic> _agriComp = [];
  List<dynamic> _defenceComp = [];
  List<dynamic> _eCommerceComp = [];
  List<dynamic> _pubSecComp = [];

  @override
  void initState() {
    super.initState();
    _companies = widget.companies;
    _foundComp = _companies;
    // debugPrint('companies length --> ${_companies.length}\n');
  }

  void runSearch(String search) {
    List res = [];
    if (search.isEmpty) {
      res = _companies;
    } else {
      res = _companies
          .where((companies) => companies['name']
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundComp = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchCompany(
          searchCtrl: _searchCtrl,
          onChanged: (value) {
            runSearch(value);
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _foundComp.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              // print('current comp --> $index');
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Text(
                    _foundComp[index]['price'].toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                title: Text(_foundComp[index]['name']),
                subtitle: Text(_foundComp[index]['symbol']),
                trailing: ElevatedButton(
                  onPressed: () {
                    /// Navigate to graphs screen
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => GraphsDataScreen(
                          companySymbol: _foundComp[index]['symbol'],
                        ),
                      ),
                    );
                  },
                  child: const Text('Balance Sheet'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
// 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
