import 'dart:math' as math;

import 'package:awesome_bottom_nav/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Bottom Nav',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainScreen> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _growAnimation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _animationController.forward();
   /* _growAnimation = Tween(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.bounceOut,
      ),
    );*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Welcome to the\n',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                        children: [
                          TextSpan(
                            text: "Today's recipe",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                            ),
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  FadeTransition(
                    opacity: _animationController,
                    child: ScaleTransition(
                      scale: _animationController,
                      child: Image.asset(
                        'assets/img/cook.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 400,
                      ),
                    ),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),

            Positioned(
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(
                    180 * math.pi / 180,
                  ),
                  child: CustomTab(
                      flip: true,
                      backgroundColor: Colors.lightBlueAccent,
                      iconData: FontAwesome5.fish,
                      title: "Today's fish",
                      body:
                          "Yada yada\n1 cup of this\n2 cups of that\n3 cups of something else",
                      clipper: FirstTabClipper()),
                ),
              ),
            ),

            //second tab
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: CustomTab(
                  middle: true,
                  backgroundColor: Colors.orange,
                  iconData: Maki.bar,
                  title: "Today's beer",
                  body:
                      "Yada yada\n1 cup of this\n2 cups of that\n3 cups of something else",
                  clipper: SecondTabClipper(),
                ),
              ),
            ),
            //first tab
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: CustomTab(
                  backgroundColor: Color(0xffF50057),
                  iconData: Maki.fast_food,
                  title: "Today's chicken",
                  body:
                      "Yada yada\n1 cup of this\n2 cups of that\n3 cups of something else",
                  clipper: FirstTabClipper(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstTabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 15)
      ..quadraticBezierTo(4, 2, 22, 0)
      ..lineTo(size.width / 3.86, 0)
      ..quadraticBezierTo(size.width / 3.2, 2, size.width / 3.09, 18)
      ..lineTo(size.width / 3.07, 50)
      ..quadraticBezierTo(size.width / 3.06, 60, size.width / 2.72, 65)
      ..moveTo(size.width / 2.72, 65)
      ..lineTo(size.width, 65)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class SecondTabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, 65)
      ..lineTo(0, size.height)
      ..moveTo(0, 65)
      ..lineTo(size.width / 3.5, 65)
      ..quadraticBezierTo(size.width / 3.1, 65, size.width / 3.2, 35)
      ..lineTo(size.width / 3.2, 15)
      ..quadraticBezierTo(size.width / 3.08, 2, size.width / 2.81, 0)
      ..lineTo(size.width / 1.56, 0)
      ..quadraticBezierTo(size.width / 1.5, 1, size.width / 1.49, 15)
      ..lineTo(size.width / 1.48, 50)
      ..quadraticBezierTo(size.width / 1.48, 65, size.width / 1.39, 65)
      ..lineTo(size.width, 65)

//      ..lineTo(size.width / 3.86, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

//      ..quadraticBezierTo(4, 2, 22, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
