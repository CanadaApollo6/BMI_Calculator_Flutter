import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import '../components/icon_content.dart';
import '../constants.dart';
import '../components/appbar_card.dart';
import '../components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

enum MeasurementSystem {
  metric,
  imperial,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender gender;
  MeasurementSystem measurementSystem = MeasurementSystem.imperial;

  static double baseImperialHeight = 70;
  double imperialHeight = baseImperialHeight * 1;
  double metricHeight = baseImperialHeight * 2.54;

  static double baseImperialWeight = 180;
  double imperialWeight = baseImperialWeight * 1;
  double metricWeight = baseImperialWeight * 0.454;

  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              Text('BMI CALCULATOR'),
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: AppBarCard(
                  colour: measurementSystem == MeasurementSystem.imperial
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: Center(
                    child: Text(
                      'IN/LB',
                      style: kAppBarTextStyle,
                    ),
                  ),
                  onPress: () {
                    setState(() {
                      measurementSystem = MeasurementSystem.imperial;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 22.0,
              ),
              Expanded(
                child: AppBarCard(
                  colour: measurementSystem == MeasurementSystem.metric
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: Center(
                    child: Text(
                      'CM/KG',
                      style: kAppBarTextStyle,
                    ),
                  ),
                  onPress: () {
                    setState(() {
                      measurementSystem = MeasurementSystem.metric;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                    colour: gender == Gender.male
                        ? kActiveCardColour
                        : kInactiveCardColour,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        gender = Gender.female;
                      });
                    },
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                    colour: gender == Gender.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'HEIGHT',
                            style: kLabelTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              measurementSystem == MeasurementSystem.metric
                                  ? metricHeight.toInt().toString()
                                  : imperialHeight.toInt().toString(),
                              style: kNumberTextStyle,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            measurementSystem == MeasurementSystem.metric
                                ? kCentimetresText
                                : kInchText,
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30.0),
                            thumbColor: kBottomContainerColour,
                            overlayColor: Color(0x29EB1555),
                          ),
                          child: Slider(
                            value: measurementSystem == MeasurementSystem.metric
                                ? metricHeight
                                : imperialHeight,
                            min: measurementSystem == MeasurementSystem.metric
                                ? kMetricMinHeight
                                : kImperialMinHeight,
                            max: measurementSystem == MeasurementSystem.metric
                                ? kMetricMaxHeight
                                : kImperialMaxHeight,
                            activeColor: kBottomContainerColour,
                            inactiveColor: Color(0xFF8D8E98),
                            onChanged: (double newValue) {
                              setState(() {
                                if (measurementSystem ==
                                    MeasurementSystem.metric) {
                                  metricHeight = newValue;
                                  imperialHeight = newValue / 2.54;
                                  return metricHeight;
                                } else {
                                  imperialHeight = newValue;
                                  metricHeight = newValue * 2.54;
                                  return imperialHeight;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              measurementSystem == MeasurementSystem.metric
                                  ? metricWeight.toInt().toString()
                                  : imperialWeight.toInt().toString(),
                              style: kNumberTextStyle,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            measurementSystem == MeasurementSystem.metric
                                ? kKilogramText
                                : kPoundText,
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (measurementSystem ==
                                      MeasurementSystem.metric) {
                                    metricWeight--;
                                    imperialWeight = metricWeight * 2.20;
                                    return metricWeight;
                                  } else {
                                    imperialWeight--;
                                    metricWeight = imperialWeight * 0.454;
                                    return imperialWeight;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  if (measurementSystem ==
                                      MeasurementSystem.metric) {
                                    metricWeight++;
                                    imperialWeight = metricWeight * 2.20;
                                    return metricWeight;
                                  } else {
                                    imperialWeight++;
                                    metricWeight = imperialWeight * 0.454;
                                    return imperialWeight;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(
                  height: measurementSystem == MeasurementSystem.metric
                      ? metricHeight / 100
                      : imperialHeight,
                  weight: measurementSystem == MeasurementSystem.metric
                      ? metricWeight
                      : imperialWeight * 703);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
