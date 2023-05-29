import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/components/imageSize.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/shared_value_helper.dart';
import 'package:healthcare/helper/shimmer_helper.dart';
import 'package:healthcare/screens/appoinment_screen.dart';
import 'package:healthcare/screens/appointment_edit.dart';
import 'package:healthcare/screens/profile_screen.dart';
import 'package:healthcare/screens/calorie_calculator.dart';
import 'package:healthcare/widgets/checklist.dart';
import 'package:healthcare/widgets/mini_solid_button.dart';
import 'package:healthcare/widgets/reusableCard.dart';
import 'package:line_icons/line_icons.dart';
import 'add_pill_reminder.dart';
import 'calorie_calculator.dart';
import 'heart_prediction.dart';
import 'medicine_reminder.dart';

enum Field {
  nutritionChecker,
  cardioChecker,
  medicineRemainder,
  calorieCalculator,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedField;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: MyTheme().transparent,
              height: kToolbarHeight,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: MyTheme().transparent,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 4),
                          child: Text(
                            'Good ${greeting()}',
                            style: kTextStyleTitle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '${user_name.value.substring(0, user_name.value.indexOf(' '))}',
                            style: TextStyle(
                                color: MyTheme().dark,
                                fontSize: 21,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 70),
                          child: Text(
                            'Your target for today is to keep positive mindset and smile to everyone you meet.',
                            style: kTextStyleSubtitle,
                          ),
                        ),
                        Row(
                          children: [
                            // MiniSolidButton(
                            //     fontSize: 13,
                            //     callback: () {},
                            //     label: 'MIND TEST',
                            //     backgroundColor: MyTheme().primary),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            MiniSolidButton(
                                fontSize: 13,
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen(
                                                isBack: true,
                                              )));
                                },
                                label: 'SEE YOUR PROFILE',
                                backgroundColor: MyTheme().primary),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white,
                        width: 44,
                        height: 44,
                      )),
                ),
                Positioned(
                  right: 20,
                  top: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: user_image.value == ''
                        ? Image.asset(
                            'images/photo.png',
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          )
                        : Image.network(
                            user_image.value,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                ReusableCard(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HeartDisease()));
                  },
                  colour: selectedField == Field.cardioChecker
                      ? kActiveColor2
                      : kInActiveColor,
                  cardChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Cardio Checker',
                          style: kCardTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset('images/icons8-heartbeat-64.png'),
                      ),
                    ],
                  ),
                ),
                // ReusableCard(
                //   onPress: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => CalorieCalculator()));
                //   },
                //   colour: selectedField == Field.nutritionChecker
                //       ? kActiveColor2
                //       : kInActiveColor,
                //   cardChild: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child: Text(
                //           'Nutrition Chart',
                //           style: kCardTextStyle,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(right: 12),
                //         child: Image.asset('images/icons8-diet-64.png'),
                //       ),
                //     ],
                //   ),
                // ),
                ReusableCard(
                  onPress: () {
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicineReminder()));
                  },
                  colour: selectedField == Field.medicineRemainder
                      ? kActiveColor2
                      : kInActiveColor,
                  cardChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Medicine Reminder',
                          style: kCardTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset('images/capsules.png'),
                      ),
                    ],
                  ),
                ),
                ReusableCard(
                  onPress: () {
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalorieCalculator()));
                  },
                  colour: selectedField == Field.medicineRemainder
                      ? kActiveColor2
                      : kInActiveColor,
                  cardChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Calorie Calculator',
                              style: kCardTextStyle,
                            ),
                            Text(
                              '&',
                              style: kCardTextStyle,
                            ),
                            Text(
                              'Nutrition Chart',
                              style: kCardTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset('images/bmi_icon.png'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
