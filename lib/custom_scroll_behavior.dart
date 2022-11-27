import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
  };
}