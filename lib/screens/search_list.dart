import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCompany extends StatelessWidget {
  const SearchCompany({
    Key? key,
    required TextEditingController searchCtrl,
    required this.onChanged,
  })  : _searchCtrl = searchCtrl,
        super(key: key);

  final TextEditingController _searchCtrl;
  final Function(String val) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white12],
              stops: [0.7, 1])),
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
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (value) {
                      onChanged(value);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search by Company Name'),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }
}
