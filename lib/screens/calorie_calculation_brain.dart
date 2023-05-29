import 'dart:math';

class CalCulatorBrain {
  final double? height;
  final double? weight;
  final int? age;
  final String? gender;

  CalCulatorBrain(
      {required this.height,
      required this.weight,
      required this.age,
      required this.gender});

  double calorie = 0.0;
  double? getResult() {
    if (gender == 'female' &&
        (height != null && weight != null && age != null)) {
      calorie = 655.1 + (9.563 * weight!) + (1.850 * height!) - (4.676 * age!);
      return calorie.floorToDouble();
    } else if (gender == 'male' &&
        (height != null && weight != null && age != null)) {
      calorie = 66.5 + (13.75 * weight!) + (5.003 * height!) - (6.75 * age!);
      return calorie.floorToDouble();
    }
  }
}
