import 'package:flutter/material.dart';
import 'package:flyconnect/routes/apppages.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/testreel.dart';

void main() {
  runApp(
    MaterialApp(
      // initialRoute: Routes.splash,
     // routes: Appages.routes,
   home: ReelsScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
