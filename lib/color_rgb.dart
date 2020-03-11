import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'it_tab.dart';

/// 颜色rgb页
class ColorRgb extends StatefulWidget {

  @override
  _ColorRgbState createState() => _ColorRgbState();

}

class _ColorRgbState extends State<ColorRgb> {
  /// 保存r, g, b的选择值，默认为255
  var r = 255, g = 255, b = 255;
  /// 值范围0~255
  final choices = List<int>(256);

  var selected = -1;
  /// 记录修改r, g, b中的哪个
  var tab = 'default';

  _ColorRgbState() {
    for(var i = 0; i < 256; i++) {
      choices[i] = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
      ),
      child: SafeArea(
        child: ConstrainedBox(
          // 让Column的宽度占据整个屏幕宽度
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Container(
            color: CupertinoColors.systemGrey5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: Text('''提示：计算机当前主流的标准表示颜色的方是使用三个8位无符号整数（0到255）表示红色、绿色和蓝色的强度，即RGB值。'''),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, r, g, b),
                  radius: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('R:$r'),
                      Text('G:$g'),
                      Text('B:$b'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200, // 固定宽度，防止button文字内容变化时导致button宽度变化
                  child: FloatingActionButton.extended(
                    heroTag: 'r', // 多个button时，需求设置此属性为不同值，否则引起相关崩溃
                    backgroundColor: Colors.red,
                    label: Text('R=$r，点击修改'),
                    onPressed: () => pickColorInt('r'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: FloatingActionButton.extended(
                    heroTag: 'g',
                    backgroundColor: Colors.green,
                    label: Text('G=$g，点击修改'),
                    onPressed: () => pickColorInt('g'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child:  FloatingActionButton.extended(
                    heroTag: 'b',
                    backgroundColor: Colors.blue,
                    label: Text('B=$b，点击修改'),
                    onPressed: () => pickColorInt('b'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 根据tab值，修改r, g, b中的某一个值
  void pickColorInt(String tab) {
    switch (tab) {
      case 'r':
        selected = r;
        break;
      case 'g':
        selected = g;
        break;
      case 'b':
        selected = b;
        break;
    }
    // 弹出r, g, b值选择框
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: selected),
              itemExtent: 40,
              children: List<Widget>.generate(choices.length, (index){
                return Center(
                  child: Text(
                    choices[index].toString(),
                  ),
                );
              }),
              onSelectedItemChanged: (value){
//                print("-------------------$value");
                switch (tab){
                  case 'r':
                    r = value;
                    break;
                  case 'g':
                    g = value;
                    break;
                  case 'b':
                    b = value;
                    break;
                  default:
                    break;
                }
                // 刷新
                setState(() {

                });
              },
            ),
          );
        });
  }
}