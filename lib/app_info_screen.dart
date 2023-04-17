import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'functionality.dart';
import 'encyclopedia_screen.dart';
import 'home_screen.dart';
import 'package:flutter/services.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({Key? key}) : super(key: key);

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  Color backgroundColor = Color.fromARGB(255, 20, 244, 13);
  Color secondaryColor = Color.fromARGB(255, 8, 96, 4);
  Color accentColor = Color.fromARGB(255, 42, 146, 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          //todo implement transition to other screens
          // print(index);
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Encyclopedia(),
              ),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppInfoScreen(),
              ),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Functionality(),
              ),
            );
          }
        },
        index: 2,
        backgroundColor: backgroundColor,
        color: secondaryColor,
        buttonBackgroundColor: backgroundColor,
        animationDuration: const Duration(
          milliseconds: 300,
        ),
        items: [
          NeumorphicIcon(
            Icons.menu_book_rounded,
            style: NeumorphicStyle(
              color: accentColor,
              intensity: 20,
            ),
          ),
          NeumorphicIcon(
            Icons.home_rounded,
            style: NeumorphicStyle(
              color: accentColor,
              intensity: 20,
            ),
          ),
          NeumorphicIcon(
            Icons.info_rounded,
            style: NeumorphicStyle(
              color: accentColor,
              intensity: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/app_icon.svg',
                        width: 30,
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "",
                          style: TextStyle(
                            fontFamily: 'odibeeSans',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/infoapp.svg',
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Neumorphic(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 20),
                        style: NeumorphicStyle(
                          color: accentColor,
                          intensity: 20,
                          depth: 20,
                        ),
                        child: Text(
                          'App Wiki',
                          style: TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 25,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                      LottieBuilder.asset(
                        'assets/104305-loding-page-nature.json',
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Neumorphic(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                ),
                                style: NeumorphicStyle(
                                  border: NeumorphicBorder(
                                    color: accentColor,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Image(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/harsh.jpg'),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: NeumorphicText(
                                        'About Me',
                                        style: const NeumorphicStyle(
                                          color: Colors.black,
                                        ),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://www.linkedin.com/in/harsh-bishnoi-50a625229/';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/linkedin.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Neumorphic(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                style: NeumorphicStyle(
                                  border: NeumorphicBorder(
                                    color: accentColor,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Image(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/agrodemo.png'),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: NeumorphicText(
                                        'App demo',
                                        style: const NeumorphicStyle(
                                          color: Colors.black,
                                        ),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String surl = '';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/yt.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Neumorphic(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  left: 20,
                                ),
                                style: NeumorphicStyle(
                                  border: NeumorphicBorder(
                                    color: accentColor,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Image(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/docs.jpg'),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: NeumorphicText(
                                        'Official docs',
                                        style: const NeumorphicStyle(
                                          color: Colors.black,
                                        ),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://docs.google.com/document/d/1BoSBQ9rZ968o2GDG1QQ8IExcy9s_sQxuoIisVbOK9oc/edit?usp=sharing';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/gdocs.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Neumorphic(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                  right: 20,
                                ),
                                style: NeumorphicStyle(
                                  border: NeumorphicBorder(
                                    color: accentColor,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Image(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/solve.png'),
                                  ),
                                ),
                              ),
                              
                              Container(
                                width: 150,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: NeumorphicText(
                                        'Hack. Info',
                                        style: const NeumorphicStyle(
                                          color: Colors.black,
                                        ),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://cloud.google.com/';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/google_cloud-icon.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   alignment: Alignment.topLeft,
                          //   margin: const EdgeInsets.only(
                          //     top: 10,
                          //     left: 20,
                          //   ),
                          //   child: SvgPicture.asset(
                          //     'assets/flutter.svg',
                          //     width: 100,
                          //     height: 35,
                          //   ),
                          // ),
                          // Container(
                          //   alignment: Alignment.topLeft,
                          //   margin: const EdgeInsets.only(
                          //     top: 10,
                          //     left: 10,
                          //   ),
                          //   child: SvgPicture.asset(
                          //     'assets/tensorflow.svg',
                          //     width: 100,
                          //     height: 35,
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
