import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/screens/create_account_screen.dart';
import 'package:healthcare/screens/main_screen.dart';
import 'package:healthcare/widgets/gradient_button.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/widgets/buttonCustom.dart';

import '../components/imageSize.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _obscure = true;
  Color eye = Colors.grey;
  late OverlayEntry loader;

  @override
  void initState() {
    super.initState();
    loader = Global.overlayLoader(context);
  }

  @override
  void dispose() {
    super.dispose();
    loader.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'images/plus.png',
                  //   height: 30,
                  //   fit: BoxFit.cover,
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Login',
                    style: kTextStyleTitle,
                  ),
                  // Expanded(
                  //     child: ImageSize(
                  //   imagename: 'images/signIn.png',
                  // )),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Text(
                      'Enter your login details to access your account',
                      textAlign: TextAlign.center,
                      style: kTextStyleSubtitle,
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
                      child: Material(
                        shadowColor: MyTheme().light,
                        borderRadius: BorderRadius.circular(15),
                        elevation: 5,
                        child: TextFormField(
                          onSaved: (value) {
                            emailCon = value! as TextEditingController;
                          },
                          validator: (value) => value == ''
                              ? 'Please enter your email address'
                              : null,
                          controller: emailCon,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Material(
                      shadowColor: MyTheme().light,
                      borderRadius: BorderRadius.circular(15),
                      elevation: 5,
                      child: TextFormField(
                        onSaved: (value) {
                          passCon = value! as TextEditingController;
                        },
                        validator: (value) =>
                            value == '' ? 'Please enter a password' : null,
                        obscureText: _obscure,
                        controller: passCon,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline_sharp,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscure = !_obscure;
                                    if (_obscure) {
                                      eye = Colors.grey;
                                    } else {
                                      eye = Colors.blue;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: eye,
                                )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Button(
                        ButtonLabel: 'Sign In',
                        onTapFunc: () async {
                          if (emailCon.value.text.isNotEmpty &&
                              passCon.value.text.isNotEmpty) {
                            Overlay.of(context)!.insert(loader);
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: emailCon.value.text,
                                      password: passCon.value.text);
                              if (userCredential.user != null) {
                                loader.remove();
                                Navigator.pushAndRemoveUntil(
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
                                      return const MainScreen();
                                    }),
                                    (context) => false);
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                                showToast(
                                  'No user found for that email.',
                                  context: context,
                                  animation:
                                      StyledToastAnimation.slideFromBottom,
                                );
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                                showToast(
                                  'Wrong password provided for that user.',
                                  context: context,
                                  animation:
                                      StyledToastAnimation.slideFromBottom,
                                );
                              }
                            }
                            loader.remove();
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an acoount?',
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
                                return const CreateAccount();
                              }));
                        },
                        child: Text(
                          'Sign Up',
                          style: kTextStyleTextBtn2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyTheme().dark,
                    )),
              ),
            )
          ],
        ));
  }
}
