import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'package:sidebarx/sidebarx.dart';
// import 'core/services/service_locator.dart';
// import 'core/widgets/home_layout.dart';
// import 'core/util/themes.dart';
import 'package:flutter/material.dart';
import 'functionality.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroCeres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      // home: const HomeScreen(),
      home: const SplashPage(),
    );
  }
}
