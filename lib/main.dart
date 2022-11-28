import 'package:flutter/material.dart';
import 'package:untitled1/api_collection.dart';
import 'package:untitled1/custom_scroll_behavior.dart';
import 'package:untitled1/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance Sheet Viewer',
      // scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
    );
  }
}
