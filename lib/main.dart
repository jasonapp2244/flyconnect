import 'package:flutter/material.dart';
import 'package:flyconnect/routes/apppages.dart';
import 'package:flyconnect/routes/routes.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: Routes.onboarding,
      routes: Appages.routes,

      debugShowCheckedModeBanner: false,
    ),
  );
}
