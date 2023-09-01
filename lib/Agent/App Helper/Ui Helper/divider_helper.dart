import 'package:flutter/material.dart';

import 'ui_helper.dart';

class DividerDrawer extends StatelessWidget {
  DividerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: DividerPadding,
        child: AllDivider
    );
  }
}
