import 'package:flutter/cupertino.dart';
import 'package:pgw/color_rgb.dart';
import 'package:pgw/colors_add_detail.dart';
import 'package:pgw/widgets.dart';

/// 编程Tab
class ItTab extends StatefulWidget {
  static const title = '编程';
  static const icon = Icon(CupertinoIcons.bell);

  @override
  _ItTabState createState() => _ItTabState();
}

class _ItTabState extends State<ItTab> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '😼',
                    style: TextStyle(
                      fontSize: 100
                    ),
                  ),
                ),
              ),
              ItemCard(
                index: 0,
                header: '颜色RGB',
                content: '🚀',
              ),
              ItemCard(
                index: 1,
                header: '颜色相加',
                content: '🔥',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 编程Tab中的子项
class ItemCard extends StatelessWidget {
  final int index;
  final String header;
  final String content;

  const ItemCard({this.index, this.header, this.content});


  @override
  Widget build(BuildContext context) {
    return PressableCard(
      color: CupertinoColors.systemGreen,
      flattenAnimation: AlwaysStoppedAnimation(0),
      child: Stack(
        children: [
          Container(
            height: 120,
            width: 250,
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 48),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color(0x1F000000),
              height: 40,
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: (){
        // 跳到详情页
        Navigator.of(context, rootNavigator: true).push<void>(
          CupertinoPageRoute(
            title: header,
            builder: (context) {
              Widget result;
              switch (index) {
                case 0 :
                  result = ColorRgb();
                  break;
                case 1 :
                  result = ColorsAddDetail();
                  break;
              };
              return result;
            },
          ),
        );
      },
    );
  }
}