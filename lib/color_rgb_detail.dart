import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'it_tab.dart';

/// 颜色rgb页
class ColorRgbDetail extends StatefulWidget {

  @override
  _ColorRgbDetailState createState() => _ColorRgbDetailState();

}

class _ColorRgbDetailState extends State<ColorRgbDetail> {
  /// 保存r, g, b的选择值，默认为255
  var r = 255, g = 255, b = 255;
  /// 值范围0~255
  final choices = List<int>(256);

  var selected = -1;
  /// 记录修改r, g, b中的哪个
  var tab = 'default';

  _ColorRgbDetailState() {
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
      child: SingleChildScrollView(
        child: SafeArea(
          child: ConstrainedBox(
            // 让Column的宽度占据整个屏幕宽度
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: MediaQuery.of(context).size.height - 2 * MediaQuery.of(context).padding.top,
            ),
            child: Container(
              color: CupertinoColors.systemGrey5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: Text('将红、绿和蓝色混在一起，取值不同可以产生不同的颜色，取值范围是0-255'),
                  ),
//                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
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
//                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
                  SizedBox(
                    width: 200, // 固定宽度，防止button文字内容变化时导致button宽度变化
                    child: FloatingActionButton.extended(
                      heroTag: 'r', // 多个button时，需求设置此属性为不同值，否则引起相关崩溃
                      backgroundColor: Colors.red,
                      label: Text('R=$r，点击修改'),
                      onPressed: () => pickColorInt('r'),
                    ),
                  ),
//                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
                  SizedBox(
                    width: 200,
                    child: FloatingActionButton.extended(
                      heroTag: 'g',
                      backgroundColor: Colors.green,
                      label: Text('G=$g，点击修改'),
                      onPressed: () => pickColorInt('g'),
                    ),
                  ),
//                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
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