import 'package:flutter/cupertino.dart';
import 'package:pgw/it_tab.dart';

/// 颜色相加详情页
class ColorsAddDetail extends StatefulWidget {

  @override
  _ColorsAddDetailState createState() => _ColorsAddDetailState();
}

class _ColorsAddDetailState extends State<ColorsAddDetail> {

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