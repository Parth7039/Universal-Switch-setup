import 'package:codeverse/adminlogin.dart';
import 'package:codeverse/roles.dart';
import 'package:flutter/material.dart';

import 'adminpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universal Switch setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Adminlogin(),
    );
  }
}

