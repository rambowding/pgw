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
  /// 数学项名称列表
  static const List<String> itemsNames  = ['加减乘除'];
  /// 数学项的个数
  final _itemsLength = itemsNames.length;
  /// 注意不能少于itemsNames.length
  static const List<Color> itemsColors = [
    CupertinoColors.systemTeal,
    CupertinoColors.systemIndigo,
    CupertinoColors.systemPurple,
    CupertinoColors.systemOrange
  ];

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
          // Navigator.of的参数rootNavigator设置为true时，可解决当在MathDetail中弹dialog时
          // 可避免整个MathDetail重新build，原因不是很理解
          onPressed: () => Navigator.of(context, rootNavigator: true).push<void>(
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