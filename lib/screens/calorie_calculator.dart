import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/screens/calorie_calculation_brain.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/helper/shimmer_helper.dart';
import 'package:healthcare/screens/allAboutYourCalorie.dart';
import 'package:healthcare/screens/nutritionChartResult.dart';
import 'package:healthcare/screens/start_screen.dart';
import 'package:healthcare/widgets/buttonCustom.dart';
import 'package:healthcare/widgets/reusableCard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:shimmer/shimmer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:healthcare/screens/calorie_calculation_brain.dart';

enum Gender {
  male,
  female,
}

class CalorieCalculator extends StatefulWidget {
  late String? genderName;
  double calorie = 0.0;
  CalorieCalculator({
    this.genderName,
  });

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late String userId;
  int age = 0;
  String genderName = '';

  @override
  // TODO: implement widget

  var selectedGender;

  TextEditingController pName = TextEditingController();
  TextEditingController pBlood = TextEditingController();
  TextEditingController pHeight = TextEditingController();
  TextEditingController pWeight = TextEditingController();
  TextEditingController pContact = TextEditingController();

  // double GetCalorieResult() {
  //   return calorie;
  // }

  double bmi = 0.0;
  late bool permissionGranted;

  late OverlayEntry loader;

  void initState() {
    super.initState();
    userId = auth.currentUser!.uid;
    print(userId);
    loader = Global.overlayLoader(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loader.dispose();
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("1");
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await per.openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      print("2");
      setState(() {
        permissionGranted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kActiveColor,
          centerTitle: true,
          title: Text(
            'Calorie Calculator',
            style: kCardTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: StreamBuilder<DocumentSnapshot>(
              stream: db.collection('users').doc(userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double height =
                      double.parse(snapshot.data!.get('height')) / 100;
                  double bmi = double.parse(snapshot.data!.get('weight')) /
                      (height * height);
                  print(bmi);

                  double height_cm = double.parse(snapshot.data!.get('height'));
                  double weight_kg = double.parse(snapshot.data!.get('weight'));

                  if (selectedGender == Gender.male) {
                    // 66.5 + 13.8 * weight_kg + 5 * (height_cm) / (6.8 * age);
                    widget.calorie = 66.5 +
                        (13.75 * weight_kg) +
                        (5.003 * height_cm) -
                        (6.75 * age);
                    print(widget.calorie);
                  } else if (selectedGender == Gender.female) {
                    widget.calorie = 655.1 +
                        (9.563 * weight_kg) +
                        (1.850 * height_cm) -
                        (4.676 * age);
                    print(widget.calorie);
                  }

                  return Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          ReusableCard(
                            colour: kInActiveColor,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your BMI',
                                  style: kCardTextStyle,
                                ),
                                Text(bmi.toStringAsFixed(2))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'For calculating your calories please select your gender and define your age',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    setState(() {
                                      selectedGender = Gender.female;

                                      widget.genderName = 'female';
                                      print(selectedGender);
                                    });
                                  },
                                  colour: selectedGender == Gender.female
                                      ? kActiveColor2
                                      : kInActiveColor,
                                  cardChild: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/female.png'),
                                      Text(
                                        'FEMALE',
                                        style: kCardTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ReusableCard(
                                  onPress: () {
                                    setState(() {
                                      selectedGender = Gender.male;
                                      widget.genderName = 'male';
                                      print(selectedGender);
                                    });
                                  },
                                  colour: selectedGender == Gender.male
                                      ? kActiveColor2
                                      : kInActiveColor,
                                  cardChild: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('images/male.png'),
                                      Text(
                                        'MALE',
                                        style: kCardTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ReusableCard(
                            colour: kInActiveColor,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Age',
                                  style: kTextStyleTitle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(age.toString(), style: kNumStyle),
                                  ],
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: kColor,
                                    overlayColor: Color(0x15A435F0),
                                    activeTrackColor: Colors.white,
                                    inactiveTrackColor: Color(0xFFC4C5C9),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 12),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 20),
                                  ),
                                  child: Slider(
                                      value: age.toDouble(),
                                      min: 0,
                                      max: 100,
                                      onChanged: (double newAge) {
                                        setState(() {
                                          age = newAge.round();
                                          // print(height);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Button(
                            ButtonLabel: 'Calculate Calorie',
                            onTapFunc: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Your Calories',
                                  style: kTextStyleTitle,
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text(
                                        widget.calorie.toStringAsFixed(2),
                                        style: kCardTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Would you like to See your diet chart?',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text(
                                      'Cancel',
                                      style: kCardTextStyle,
                                    ),
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: kCardTextStyle,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecommendedChart(
                                                    CalorieResult:
                                                        widget.calorie,
                                                  )));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ShimmerHelper().buildBasicShimmer(
                            height: 100, width: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),
                        ShimmerHelper().buildBasicShimmer(
                            height: 100, width: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),
                        ShimmerHelper().buildBasicShimmer(
                          height: 100,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ShimmerHelper().buildBasicShimmer(
                            height: 100, width: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),
                        ShimmerHelper().buildBasicShimmer(
                            height: 100, width: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),
                        ShimmerHelper().buildBasicShimmer(
                            height: 100, width: double.infinity),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
