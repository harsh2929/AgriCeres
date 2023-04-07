import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'functionality.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Color backgroundColor = Color.fromARGB(255, 35, 219, 118);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      systemNavigationBarColor: backgroundColor,
    ));

    return EasySplashScreen(
      logo: Image.asset('assets/app_icon.png'),
      title: const Text(
        "\nएग्रोसेरेस\n অগ্রসেরেস\n அஃப்ரோஸ்ப்ரெஸ்\n એગ્રોસેરેસ\n",
        style: TextStyle(
          fontSize: 35,
          fontFamily: 'odibeeSans',
        ),
      ),
      backgroundColor: backgroundColor,
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: const HomeScreen(),
      durationInSeconds: 2,
    );
  }
}
