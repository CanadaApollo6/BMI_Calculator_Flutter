import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});

  final double height;
  final double weight;
  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5 && _bmi < 25) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Consider cutting calories.';
    } else if (_bmi > 18.5 && _bmi < 25) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You might consider lean bulking';
    }
  }
}
