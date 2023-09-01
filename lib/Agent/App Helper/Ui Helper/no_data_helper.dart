//@dart=2.9
import 'package:flutter/material.dart';

class NoDataHelper extends StatelessWidget {
  const NoDataHelper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(image: AssetImage("assets/gif/no_data.png"),width: 250),
      ),
    );
  }
}
