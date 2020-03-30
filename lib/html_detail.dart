import 'package:flutter/cupertino.dart';
import 'package:pgw/it_tab.dart';

class HtmlDetail extends StatefulWidget {

  @override
  _HtmlDetailState createState() => _HtmlDetailState();

}

class _HtmlDetailState extends State<HtmlDetail> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
      ),
      child: Container(),
    );
  }

}