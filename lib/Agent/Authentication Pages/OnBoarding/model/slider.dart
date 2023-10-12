import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider({
      required this.sliderImageUrl,
      required this.sliderHeading,
      required this.sliderSubHeading
  });
}

final sliderArrayList = [
    Slider(
        sliderImageUrl: 'assets/image/logo.png',
        sliderHeading: Constants.SLIDER_HEADING_1,
        sliderSubHeading: Constants.SLIDER_DESC1),
    Slider(
        sliderImageUrl: 'assets/image/onboarding_two.png',
        sliderHeading: Constants.SLIDER_HEADING_2,
        sliderSubHeading: Constants.SLIDER_DESC2),
    Slider(
        sliderImageUrl: 'assets/image/onboarding_three.png',
        sliderHeading: Constants.SLIDER_HEADING_3,
        sliderSubHeading: Constants.SLIDER_DESC3),
];
