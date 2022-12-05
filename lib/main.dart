// import 'package:flutter/material.dart';
//
// import 'screens/overview_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: OverViewScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFLite Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        splash: Column(
          children: [
            const Text(
              'Task To_do',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              child: Image.asset(
                'assets/to-do.png',
              ),
            ),
          ],
        ),
        nextScreen: const Home(),
      ),
    );
  }
}
