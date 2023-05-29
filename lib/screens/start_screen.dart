import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/screens/create_account_screen.dart';
import 'package:healthcare/screens/home_screen.dart';
import 'package:healthcare/screens/main_screen.dart';
import 'package:healthcare/screens/sign_in_screen.dart';
import 'package:healthcare/widgets/gradient_button.dart';
import 'package:healthcare/widgets/buttonCustom.dart';
import 'package:healthcare/constants.dart';

import '../components/imageSize.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late FirebaseAuth auth;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    check_auth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Cardio Checker',
              style: kTextStyleTitle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Welcome',
              style: kTextStyleTitle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'A Personal Cardio care app which is always keeping you aware of your heart and regular medicine schedules',
                textAlign: TextAlign.center,
                style: kTextStyleSubtitle,
              ),
            ),
            Expanded(
              child: ImageSize(
                imagename: 'images/homepage1.png',
                Width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Button(
                  ButtonLabel: 'Get Started',
                  onTapFunc: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(transitionsBuilder:
                            (context, animation, secondary, child) {
                          return SlideTransition(
                            position: animation.drive(Tween(
                                begin: const Offset(0.1, 0.0),
                                end: Offset.zero)),
                            child: child,
                          );
                        }, pageBuilder: (context, an, an2) {
                          return const CreateAccount();
                        }));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: kTextStyleTextBtn,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(transitionsBuilder:
                              (context, animation, secondary, child) {
                            return SlideTransition(
                              position: animation.drive(Tween(
                                  begin: const Offset(0.1, 0.0),
                                  end: Offset.zero)),
                              child: child,
                            );
                          }, pageBuilder: (context, an, an2) {
                            return const SignIn();
                          }));
                    },
                    child: Text(
                      'Sign In',
                      style: kTextStyleTextBtn2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void check_auth() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    });
  }
}
