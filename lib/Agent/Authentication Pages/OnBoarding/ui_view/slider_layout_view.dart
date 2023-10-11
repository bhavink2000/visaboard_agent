import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../Login Screen/login_screen.dart';
import '../constants/constants.dart';
import '../model/slider.dart';
import '../widgets/slide_dots.dart';
import '../widgets/slide_items/slide_item.dart';


class SliderLayoutView extends StatefulWidget {
  SliderLayoutView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: InkWell(
                        onTap: (){
                          _currentPage == 2
                              ? Navigator.pushNamed(context, AppRoutesName.login)
                              : _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                        },
                        child: _currentPage == 2 ? Text(
                          Constants.DONE,
                          style: TextStyle(
                            fontFamily: Constants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: PrimaryColorOne
                          ),
                        ) : Text(
                          Constants.NEXT,
                          style: TextStyle(
                            fontFamily: Constants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: PrimaryColorOne
                          ),
                        )
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                    child: InkWell(
                        onTap: (){
                          _currentPage == 0
                              ? Navigator.pushNamed(context, AppRoutesName.login)
                              : _pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                        },
                        child: _currentPage==0
                            ? Text(
                          Constants.SKIP,
                          style: TextStyle(
                            fontFamily: Constants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: PrimaryColorOne
                          ),
                        ) : Text(
                          Constants.BACK,
                          style: TextStyle(
                            fontFamily: Constants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: PrimaryColorOne
                          ),
                        )
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < sliderArrayList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
