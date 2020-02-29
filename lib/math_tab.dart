import 'package:flutter/cupertino.dart';
import 'package:pgw/math_detail.dart';

import 'widgets.dart';

/// 数学Tab
class MathTab extends StatefulWidget {
  static const title = '数学';
  static const icon = Icon(CupertinoIcons.bell_solid);

  @override
  _MathTabState createState() => _MathTabState();
}

class _MathTabState extends State<MathTab> {
  // 数学列表的个数
  static const _itemsLength = 4;

  static const List<Color> itemsColors = [
    CupertinoColors.systemTeal,
    CupertinoColors.systemIndigo,
    CupertinoColors.systemPurple,
    CupertinoColors.systemOrange
  ];

  static const List<String> itemsNames  = ['加法', '减法', '乘法', '除法'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
        ),
        CupertinoSliverRefreshControl(
//          onRefresh: _refreshData,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(_listBuilder),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;

    final color = itemsColors[index];

    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: HeroAnimatingMathCard(
          song: itemsNames[index],
          color: color,
          heroAnimation: AlwaysStoppedAnimation(0),
          onPressed: () => Navigator.of(context).push<void>(
            CupertinoPageRoute(
              builder: (context) => MathDetail(
                id: index,
                title: itemsNames[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}