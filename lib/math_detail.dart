import 'package:flutter/cupertino.dart';

/// 数学项的详情页
class MathDetail extends StatelessWidget {
  final int id;
  final String title;

  const MathDetail({this.id, this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
        ),
      child: SafeArea(
        child: Container(),
      ),
    );
  }
}