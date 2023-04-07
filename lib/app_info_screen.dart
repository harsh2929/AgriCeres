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
  Color backgroundColor = Color.fromARGB(255, 74, 230, 74);
  Color secondaryColor = Color.fromARGB(255, 3, 105, 35);
  Color accentColor = Color.fromARGB(255, 36, 169, 213);

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
                        'assets/download.svg',
                        width: 30,
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "AgroCeres",
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
                    'assets/googleamd.svg',
                    width: 40,
                    height: 40,
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
                        padding: const EdgeInsets.all(10),
                        style: NeumorphicStyle(
                          color: accentColor,
                          intensity: 20,
                          depth: 20,
                        ),
                        child: Text(
                          'About AgroCeres',
                          style: TextStyle(
                            fontFamily: 'odibeeSans',
                            fontSize: 35,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                      LottieBuilder.asset(
                        'assets/106709-hanging-plant-gently-swinging.json',
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
                                    image: AssetImage('assets/sagarp.png'),
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
                                        'Sagar Paul',
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
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://github.com/harsh2929/AgriCeres';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/github.svg',
                                            width: 20,
                                            height: 20,
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
                                    image: AssetImage('assets/paulg.jpg'),
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
                                        'Paul G',
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
                                                'https://linkedin.com/in/paul-g-tharayil-04a9971b1';
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
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://github.com/harsh2929';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/github.svg',
                                            width: 20,
                                            height: 20,
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
                                    image: AssetImage('assets/varunc.jpg'),
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
                                        'Application Documentation', /////////////////////////////////////////////////////////
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
                                                'https://linkedin.com/in/varun-c-b598101a4';
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
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://github.com/varunc20101';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/github.svg',
                                            width: 20,
                                            height: 20,
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
                                    image: AssetImage('assets/nihalm.jpg'),
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
                                        'Nihal Manoj',
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
                                                'https://www.linkedin.com/in/nihal-james-manoj-3b7364246';
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
                                        GestureDetector(
                                          onTap: () async {
                                            String surl =
                                                'https://github.com/Blieve4ever';
                                            Uri url = Uri.parse(surl);
                                            await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: SvgPicture.asset(
                                            'assets/github.svg',
                                            width: 20,
                                            height: 20,
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
                      Neumorphic(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        style: NeumorphicStyle(
                          color: backgroundColor,
                          intensity: 20,
                          depth: 5,
                        ),
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About AgroLab',
                              style: TextStyle(
                                fontFamily: 'odibeeSans',
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: const Text(
                                'AgriCeres is an appliaction created with a motive to help farmers from the ground up, starting from produce to selling their produces and providing seamless interface with the help of Google cloud and Amd instances',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: SvgPicture.asset(
                          'assets/made-with-love-in-india.svg',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                            ),
                            child: SvgPicture.asset(
                              'assets/flutter.svg',
                              width: 100,
                              height: 35,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                            ),
                            child: SvgPicture.asset(
                              'assets/tensorflow.svg',
                              width: 100,
                              height: 35,
                            ),
                          ),
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
