import 'package:flutter/material.dart';
import 'activity/home.dart';
import 'activity/loading.dart';
import 'activity/location.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/":(context) => Loading_screen(),
      "/home":(context) => Home(),
      "/loading":(context) => Loading_screen()
    },
  debugShowCheckedModeBanner: false,));
}

