import 'package:flutter/material.dart';
import 'package:flyconnect/provider/edit_profile_provider.dart';
import 'package:flyconnect/provider/profile_provider.dart';
import 'package:flyconnect/routes/apppages.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:provider/provider.dart';
import 'provider/inbox_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InboxProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ Route configuration
      initialRoute: Routes.splash,
      routes: Appages.routes,
    );
  }
}
