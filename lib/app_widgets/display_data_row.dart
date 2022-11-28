import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final String field;
  final dynamic value;
  const DisplayData({
    Key? key,
    required this.value,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(value.toString());
    return Container(
      margin: const EdgeInsets.only(bottom: 2.5),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue.shade50,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  field,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
