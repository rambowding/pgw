import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw/it_tab.dart';

/// 颜色相加详情页
class ColorsAddDetail extends StatefulWidget {

  @override
  _ColorsAddDetailState createState() => _ColorsAddDetailState();
}

class _ColorsAddDetailState extends State<ColorsAddDetail> {

  /// 颜色选择区的值
  static const rgbColors = [
    [255, 0, 0], // Red
    [255, 165, 0], // Orange
    [255, 255, 0], // Yellow
    [0, 255, 0], // Green
    [0, 0, 255], // Blue
    [75, 0, 130], // Indigo
    [128, 0, 128], // Purple
    [0, 0, 0], // black
    [0, 255, 255], // Cyan
  ];

  /// 左边颜色
  var leftRgbColor = [255, 255, 255];

  /// 右边颜色
  var rightRgbColor = [255, 255, 255];

  /// 结果颜色
  var resultRgbColor = [255, 255, 255];

  /// 是否是对左边选择颜色
  var isUseLeft = true;

  /// R,G,B默认值为-2，当输入非法时设为-1
  /// 输入的R值
  var inputR = -2;
  /// 输入的G值
  var inputG = -2;
  /// 输入的B值
  var inputB = -2;

  /// 保存选择的颜色
  void _saveSelectedColor(int index) {
    isUseLeft ? leftRgbColor = rgbColors[index] : rightRgbColor = rgbColors[index];
    setState(() {});
  }

  /// 从数组中构造Color对象
  Color _buildColorFromArray(int index) {
    return Color.fromARGB(255, rgbColors[index][0], rgbColors[index][1], rgbColors[index][2]);
  }

  /// 颜色相加的结果
  Color _addColor() {
    int r = leftRgbColor[0] + rightRgbColor[0];
    if (r > 255) r = 255;

    int g = leftRgbColor[1] + rightRgbColor[1];
    if (g > 255) g = 255;

    int b = leftRgbColor[2] + rightRgbColor[2];
    if (b > 255) b = 255;

    resultRgbColor = [r, g, b];
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
      ),
      resizeToAvoidBottomInset: false, // 弹输入法时不让尺寸发生变化，否则会报尺寸不够的错误
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 文字提示
            Card(
              elevation: 0,
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
              child: Text('将两个RGB值颜色相加，可以产生新的不同颜色'),
            ),
            // 加法区
            Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
              color: CupertinoColors.lightBackgroundGray,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          isUseLeft = true;
                          setState(() {

                          });
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, leftRgbColor[0], leftRgbColor[1], leftRgbColor[2]),
                              radius: 30.0,
                            ),
                            Text(leftRgbColor.toString()),
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(
                      child: Text('+',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          isUseLeft = false;
                          setState(() {

                          });
                        },
                        child: Column(

                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, rightRgbColor[0], rightRgbColor[1], rightRgbColor[2]),
                              radius: 30.0,
                            ),
                            Text(rightRgbColor.toString()),
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                    Expanded(
                      child: Text('=',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: _addColor(),
                            radius: 30.0,
                          ),
                          Text(resultRgbColor.toString()),
                        ],
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
            ),

            // 箭头区
            Card(
              elevation: 0,
              margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '⇡',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: isUseLeft ? CupertinoColors.systemBlue : CupertinoColors.white,
                      ),
                    ),
                    flex: 8,
                  ),
                  Expanded( // 仅占位作用
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '⇡',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: isUseLeft ? CupertinoColors.white : CupertinoColors.systemBlue,
                      ),
                    ),
                    flex: 8,
                  ),
                  Expanded( // 仅占位作用
                    child: Container(),
                    flex: 9,
                  ),
                ],
              ),
            ),

            // 颜色选择区
            Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _saveSelectedColor(0),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(0),
                          child: Text('Red'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _saveSelectedColor(1),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(1),
                          child: Text('Orange'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _saveSelectedColor(2),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(2),
                          child: Text('Yellow'),
                          radius: 40.0,
                        ),
                      ),
                    ]
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _saveSelectedColor(3),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(3),
                          child: Text('Green'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _saveSelectedColor(4),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(4),
                          child: Text('Blue'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _saveSelectedColor(5),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(5),
                          child: Text('Indigo'),
                          radius: 40.0,
                        ),
                      ),
                    ]
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _saveSelectedColor(6),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(6),
                          child: Text('Purple'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _saveSelectedColor(7),
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(7),
                          child: Text('Black'),
                          radius: 40.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _saveSelectedColor(8);
                        },
                        child: CircleAvatar(
                          backgroundColor: _buildColorFromArray(8),
                          child: Text('Cyan'),
                          radius: 40.0,
                        ),
                      ),
                    ]
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20.0, 0, 30),),
                  FloatingActionButton.extended(
                    label: Text('RGB值手动输入'),
                    backgroundColor: Colors.amber,
                    onPressed: (){
                      showCupertinoDialog<int>(context: context,
                          builder: (context){
                            return CupertinoAlertDialog(
                              title: Text('输入范围在0~255之间'),
                              content: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text('R:'),
                                      SizedBox(
                                        width: 100,
                                        // CupertinoTextField如果不显示设置width，会报以下crash
                                        // RenderEditable object was given an infinite size during layout.
                                        child: CupertinoTextField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            try {
                                              var intValue = int.parse(value);
                                              if (intValue < 0 || intValue > 255) {
                                                inputR = -1;
                                              } else {
                                                inputR = intValue;
                                              }
                                            }
                                            on FormatException catch(e) {
                                              inputR = -1;
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text('G:'),
                                      SizedBox(
                                        width: 100,
                                        child: CupertinoTextField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            try {
                                              var intValue = int.parse(value);
                                              if (intValue < 0 || intValue > 255) {
                                                inputG = -1;
                                              } else {
                                                inputG = intValue;
                                              }
                                            }
                                            on FormatException catch(e) {
                                              inputG = -1;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text('B:'),
                                      SizedBox(
                                        width: 100,
                                        child: CupertinoTextField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            try {
                                              var intValue = int.parse(value);
                                              if (intValue < 0 || intValue > 255) {
                                                inputB = -1;
                                              } else {
                                                inputB = intValue;
                                              }
                                            }
                                            on FormatException catch(e) {
                                              inputB = -1;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text('取消'),
                                  onPressed: (){
                                    Navigator.of(context).pop(0);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text('确认'),
                                  onPressed: () {
                                    // 非法输入或者未输入均弹提示
                                    if (inputR == -1 || inputG == -1 || inputB == -1 || inputR == -2) {
                                      BotToast.showText(text: '请输入0~255之间的数字');
                                    } else {
                                      Navigator.of(context).pop(1);
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                      ).then((onValue){
                        if (onValue == 1) { // 点了确定按钮
                          // 刷新
                          setState(() {
                            if (isUseLeft) {
                              // 单个赋值会报以下异常，原因未知
                              // Unsupported operation: Cannot modify an unmodifiable list
                              leftRgbColor = [inputR, inputG, inputB];
                            } else {
                              rightRgbColor = [inputR, inputG, inputB];
                            }
                          });
                        } else if (onValue == 0) { // 点了取消按钮
                          // 恢复默认值
                          inputR = -2;
                          inputG = -2;
                          inputB = -2;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}