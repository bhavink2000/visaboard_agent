
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

import '../../../../App Helper/Ui Helper/ui_helper.dart';
import '../../constants/constants.dart';
import '../../model/slider.dart';


class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.8,
          width: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Image.asset(sliderArrayList[index].sliderImageUrl,fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
        AnimationLimiter(
          child: AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 1000),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: Text(
                  sliderArrayList[index].sliderHeading,
                  style: TextStyle(
                    fontFamily: Constants.OPEN_SANS,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.5,
                    color: PrimaryColorOne,
                    letterSpacing: 2
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: AnimationLimiter(
              child: AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Text(
                      sliderArrayList[index].sliderSubHeading,
                      style: TextStyle(
                        fontFamily: Constants.OPEN_SANS,
                        fontWeight: FontWeight.w500,
                        
                        fontSize: 12.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
