import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'it_tab.dart';

/// 颜色rgb页
class ColorRgb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
      ),
      child: SafeArea(
        child: Container(),
      ),
    );
  }

}