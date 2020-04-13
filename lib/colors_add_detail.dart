import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw/it_tab.dart';
import 'package:provider/provider.dart';
import 'package:pgw/provider_model.dart';

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

  /// R,G,B默认值为-2，当输入非法时设为-1
  /// 输入的R值
  var inputR = -2;
  /// 输入的G值
  var inputG = -2;
  /// 输入的B值
  var inputB = -2;

  /// 从数组中构造Color对象
  Color _buildColorFromArray(int index) {
    return Color.fromARGB(255, rgbColors[index][0], rgbColors[index][1], rgbColors[index][2]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
      ),
      resizeToAvoidBottomInset: false, // 弹输入法时不让尺寸发生变化，否则会报尺寸不够的错误
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AddAreaModel()),
          ChangeNotifierProvider.value(value: ArrowAreaModel()),
        ],
        child: SingleChildScrollView(
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
                          child: Consumer2<ArrowAreaModel, AddAreaModel>(
                            builder: (context, ArrowAreaModel arrowModel, AddAreaModel addModel, _) {
                              return GestureDetector(
                                onTap: (){
                                  arrowModel.update(true);
                                },
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Color.fromARGB(255, addModel.leftRgbColor[0],
                                          addModel.leftRgbColor[1], addModel.leftRgbColor[2]),
                                      radius: 30.0,
                                    ),
                                    Text(addModel.leftRgbColor.toString()),
                                  ],
                                ),
                              );
                            },
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
                          child: Consumer2<ArrowAreaModel, AddAreaModel>(
                            builder: (context, ArrowAreaModel arrowModel, AddAreaModel addModel, _) {
                              return GestureDetector(
                                onTap: () => arrowModel.update(false),
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Color.fromARGB(255, addModel.rightRgbColor[0],
                                          addModel.rightRgbColor[1], addModel.rightRgbColor[2]),
                                      radius: 30.0,
                                    ),
                                    Text(addModel.rightRgbColor.toString()),
                                  ],
                                ),
                              );
                            },
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
                          child: Consumer2<ArrowAreaModel, AddAreaModel>(
                            builder: (context, ArrowAreaModel arrowModel, AddAreaModel addModel, _) {
                              return Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Color.fromARGB(255, addModel.resultRgbColor[0],
                                        addModel.resultRgbColor[1], addModel.resultRgbColor[2]),
                                    radius: 30.0,
                                  ),
                                  Text(addModel.resultRgbColor.toString()),
                                ],
                              );
                            },
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
                        child: Consumer<ArrowAreaModel>(
                          builder: (context, ArrowAreaModel model, _) {
                            return Text(
                              '⇡',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: model.isLeft ? CupertinoColors.systemBlue : CupertinoColors.white,
                              ),
                            );
                          },
                        ),
                        flex: 8,
                      ),
                      Expanded( // 仅占位作用
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Consumer<ArrowAreaModel>(
                          builder: (context, ArrowAreaModel model, _) {
                            return Text(
                              '⇡',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: model.isLeft ? CupertinoColors.white : CupertinoColors.systemBlue,
                              ),
                            );
                          },
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
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, circle) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(0, arrowModel.isLeft),
                                  child: circle,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(0),
                                child: Text('Red'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(1, arrowModel.isLeft),
                                  child: child,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(1),
                                child: Text('Orange'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(2, arrowModel.isLeft),
                                  child: child,
                                );
                              },
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
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(3, arrowModel.isLeft),
                                  child: child,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(3),
                                child: Text('Green'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                    onTap: () => model.updateSelectedColor(4, arrowModel.isLeft),
                                    child: child
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(4),
                                child: Text('Blue'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(5, arrowModel.isLeft),
                                  child: child,
                                );
                              },
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
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(6, arrowModel.isLeft),
                                  child: child,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(6),
                                child: Text('Purple'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                    onTap: () => model.updateSelectedColor(7, arrowModel.isLeft),
                                    child: child
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: _buildColorFromArray(7),
                                child: Text('Black'),
                                radius: 40.0,
                              ),
                            ),
                            Consumer2<AddAreaModel, ArrowAreaModel>(
                              builder: (context, AddAreaModel model, ArrowAreaModel arrowModel, child) {
                                return GestureDetector(
                                  onTap: () => model.updateSelectedColor(8, arrowModel.isLeft),
                                  child: child,
                                );
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
                      Consumer2<ArrowAreaModel, AddAreaModel>(
                        builder: (context, ArrowAreaModel arrowModel, AddAreaModel addModel, child) {
                          return FloatingActionButton.extended(
                            label: Text('RGB值手动输入'),
                            backgroundColor: Colors.amber,
                            onPressed: (){
                              showCupertinoDialog<int>(context: context,
                                  builder: (context){
                                    return child;
                                  }
                              ).then((onValue){
                                if (onValue == 1) { // 点了确定按钮
                                  addModel.updateInputColor(arrowModel.isLeft, inputR, inputG, inputB);
                                } else if (onValue == 0) { // 点了取消按钮
                                  // 恢复默认值
                                  inputR = -2;
                                  inputG = -2;
                                  inputB = -2;
                                }
                              });
                            },
                          );
                        },
                        child: CupertinoAlertDialog(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class AddAreaModel extends ChangeNotifier {
  /// 左边颜色
  var leftRgbColor = [255, 255, 255];

  /// 右边颜色
  var rightRgbColor = [255, 255, 255];

  /// 结果颜色
  var resultRgbColor = [255, 255, 255];

  var selectedIndex = -1;

  /// 保存选择的颜色
  void updateSelectedColor(int index, bool left) {
    // 避免重复刷新
    if (selectedIndex == index) return;

    selectedIndex = index;

    left ? leftRgbColor = _ColorsAddDetailState.rgbColors[index]
        : rightRgbColor = _ColorsAddDetailState.rgbColors[index];

    _addColor();

    // 通知更新
    notifyListeners();
  }

  void updateInputColor(bool left, int r, int g, int b) {
    // 单个赋值会报以下异常，原因未知
    // Unsupported operation: Cannot modify an unmodifiable list
    if (left) {
      leftRgbColor = [r, g, b];
    } else {
      rightRgbColor = [r, g, b];
    }
    selectedIndex = -1; // 手工输入时需要重置

    _addColor();

    notifyListeners();
  }

  void _addColor() {
    // 更新相加后颜色
    int r = leftRgbColor[0] + rightRgbColor[0];
    if (r > 255) r = 255;

    int g = leftRgbColor[1] + rightRgbColor[1];
    if (g > 255) g = 255;

    int b = leftRgbColor[2] + rightRgbColor[2];
    if (b > 255) b = 255;

    resultRgbColor = [r, g, b];
  }
}