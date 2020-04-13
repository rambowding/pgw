import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';

/// 数学项的详情页
class MathDetail extends StatefulWidget {
  final int id;
  final String title;

  MathDetail({this.id, this.title});

  @override
  _MathDetailState createState() => _MathDetailState();
}

class _MathDetailState extends State<MathDetail> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ResultAreaModel()),
          ChangeNotifierProvider.value(value: ArrowAreaModel()),
          ChangeNotifierProvider.value(value: OperatorModel()),
        ],
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                // 算术符区
                Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Consumer2<OperatorModel, ResultAreaModel>(
                      builder: (context, OperatorModel opModel, ResultAreaModel resultModel,  _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              heroTag: '+',
                              onPressed: () {
                                opModel.update(0);
                                resultModel.resetResult();
                              },
                              label: Text('加(+)', style: TextStyle(color: CupertinoColors.systemOrange),),
                              backgroundColor: _updateOpAreaColor(opModel.value == 0),
                            ),
                            FloatingActionButton.extended(
                              heroTag: '-',
                              onPressed: () {
                                opModel.update(1);
                                resultModel.resetResult();
                              },
                              label: Text('减(-)', style: TextStyle(color: CupertinoColors.systemOrange),),
                              backgroundColor: _updateOpAreaColor(opModel.value == 1),
                            ),
                            FloatingActionButton.extended(
                              heroTag: '×',
                              onPressed: () {
                                opModel.update(2);
                                resultModel.resetResult();
                              },
                              label: Text('乘(×)', style: TextStyle(color: CupertinoColors.systemOrange),),
                              backgroundColor: _updateOpAreaColor(opModel.value == 2),
                            ),
                            FloatingActionButton.extended(
                              heroTag: '÷',
                              onPressed: () {
                                opModel.update(3);
                                resultModel.resetResult();
                              },
                              label: Text('除(÷)', style: TextStyle(color: CupertinoColors.systemOrange),),
                              backgroundColor: _updateOpAreaColor(opModel.value == 3),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // 结果区
                Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                          builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowMode, _) {
                            return GestureDetector(
                              onTap: () => arrowMode.update(0),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: CupertinoColors.systemGrey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  resultModel.left,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        flex: 6,
                      ),
                      Expanded(
                        child: Consumer<OperatorModel>(
                          builder: (context, OperatorModel model, _) {
                            return Text(_updateOperatorChar(model.value),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            );
                          },
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                          builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowMode, _) {
                            return GestureDetector(
                              onTap: () => arrowMode.update(1),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: CupertinoColors.systemGrey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  resultModel.right,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        flex: 6,
                      ),
                      Expanded(
                        child: Text('=',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                          builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, _) {
                            return GestureDetector(
                              onTap: () => arrowModel.update(2),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: CupertinoColors.systemGrey, width: 0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(resultModel.result,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        flex: 6,
                      ),
                    ],
                  ),
                ),
                // 箭头区
                Container( // 此区域用Container来wrap一下，否则高度会过高，导致超过屏幕尺寸，原因未知
                  height: 60,
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Consumer<ArrowAreaModel>(
                          builder: (context, ArrowAreaModel model, _) {
                            if (model.index == 0) {
                              return Image.asset('assets/images/arrow_up.png');
                            } else {
                              return Container();
                            }
                          },
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Consumer<ArrowAreaModel>(
                          builder: (context, ArrowAreaModel model, _) {
                            if (model.index == 1) {
                              return Image.asset('assets/images/arrow_up.png');
                            } else {
                              return Container();
                            }
                          },
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Consumer<ArrowAreaModel>(
                          builder: (context, ArrowAreaModel model, _) {
                            if (model.index == 2) {
                              return Image.asset('assets/images/arrow_up.png');
                            } else {
                              return Container();
                            }
                          },
                        ),
                        flex: 5,
                      ),
                    ],
                  ),
                ),
                // 键盘区
                Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // FloatingActionButton没找到设置宽高的属性，通过外部包装一个
                              // SizedBox来实现设置宽高
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 1,
                                    onPressed: () => resultModel.update('1', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('1',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 2,
                                    onPressed: () => resultModel.update('2', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('2',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 3,
                                    onPressed: () => resultModel.update('3', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('3',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // FloatingActionButton没找到设置宽高的属性，通过外部包装一个
                              // SizedBox来实现设置宽高
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 4,
                                    onPressed: () => resultModel.update('4', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('4',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 5,
                                    onPressed: () => resultModel.update('5', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('5',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 6,
                                    onPressed: () => resultModel.update('6', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('6',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // FloatingActionButton没找到设置宽高的属性，通过外部包装一个
                              // SizedBox来实现设置宽高
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 7,
                                    onPressed: () => resultModel.update('7', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('7',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 8,
                                    onPressed: () => resultModel.update('8', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('8',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 9,
                                    onPressed: () => resultModel.update('9', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('9',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // FloatingActionButton没找到设置宽高的属性，通过外部包装一个
                              // SizedBox来实现设置宽高
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 0,
                                    onPressed: () => resultModel.update('0', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('0',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer3<ResultAreaModel, ArrowAreaModel, OperatorModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel,
                                      OperatorModel opModel, child) {
                                    if (arrowModel.index == 2) {
                                      return FloatingActionButton(
                                        heroTag: -1,
                                        onPressed: () {
                                          // 只有选中结果按钮才响应点击事件处理逻辑
                                          if (arrowModel.index == 2) {
                                            bool answerRight = resultModel.checkResult(opModel.value);

                                            String text = '答错啦，再想一想';
                                            if (answerRight) {
                                              text = '答对啦，你真棒';
                                            }
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  content: Text(text),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: Text('关闭'),
                                                      onPressed: () => Navigator.of(context).pop(),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        backgroundColor: arrowModel.index == 2 ? CupertinoColors.systemOrange : CupertinoColors.white,
                                        child: child,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                  child: Text('检查答案',
                                    style: TextStyle(
                                        fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                  builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                    heroTag: 10,
                                    onPressed: () => resultModel.update('c', arrowModel.index),
                                    child: child,
                                  ),
                                  child: Text('C',
                                    style: TextStyle(
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 12),),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 更新算术符区的背景色
  Color _updateOpAreaColor(bool selected) {
    return selected ? CupertinoColors.systemIndigo : CupertinoColors.white;
  }

  /// 更新算术符
  String _updateOperatorChar(int value) {
    String char = '+';
    switch (value) {
      case 0:
        char = '+';
        break;
      case 1:
        char = '-';
        break;
      case 2:
        char = '×';
        break;
      case 3:
        char = '÷';
        break;
      default:
        char = '+';
        break;
    }
    return char;
  }
}

/// 结果区的model
class ResultAreaModel with ChangeNotifier {

  String left = '0';
  String right = '0';
  String result = '?';
  double realResult = -1; // 默认值，表示未计算

  void update(String key, int select) {
    if (select == 0) {
      if (key == 'c') left = '0';// 清除
      else if (left == '0') left = key;
      else {
        if (left.length >= 4) {
          BotToast.showText(text: '数字太大啦，请先练习一万以内的数字');
          return;
        }
        left += key;
      }
    } else if (select == 1) {
      if (key == 'c') right = '0';
      else if (right == '0') right = key;
      else {
        if (right.length >= 4) {
          BotToast.showText(text: '数字太大啦，请先练习一万以内的数字');
          return;
        }
        right += key;
      }
    } else if (select == 2) {
      if (key == 'c') result = '0';
      else if (result == '0' || result == '?') result = key;
      else {
        result += key;
      }
    }
//    print('-------isLeft=$isSelectLeft----------left=$left----------right=$right');

    realResult = -1; // 需要重复结果，否则不会作计算操作，参见updateResult方法
    // 通知消费者更新
    notifyListeners();
  }

  bool checkResult(int operator) {
    // 当result为非-1时，表示已经经过计算，此时不再重复计算
    if (realResult == -1) {
      switch (operator) {
        case 0:
          realResult = double.parse(left) + double.parse(right);
          break;
        case 1:
          realResult = double.parse(left) - double.parse(right);
          break;
        case 2:
          realResult = double.parse(left) * double.parse(right);
          break;
        case 3:
          double tmpRight = double.parse(right);
          if (tmpRight == 0) {
            BotToast.showText(text: '除数不能为0');
            realResult = 0; // 表示经过计算了
          } else {
            realResult = double.parse(left) / tmpRight;
          }
          break;
        default:
          break;
      }
    }
    print('---op=$operator---left=$left---right=$right----result=$result---realResut=$realResult');
    return result == _adjustResult(realResult.toString());
  }

  /// 去掉结果中的.0字符
  String _adjustResult(String result) {
    if (result.endsWith('.0')) {
      return result.substring(0, result.length - 2);
    }
    return result;
  }

  void resetResult() {
    if (realResult != -1) {
      realResult = -1;
      notifyListeners();
    }
  }
}

/// 箭头区的model
class ArrowAreaModel with ChangeNotifier {
  /// 0表示算术符号左边数字，1表示算术符号右边数字，2表示结果数字
  int index = 0;

  void update(int select) {
    if (index == select) return;

    index = select;
    notifyListeners();
  }
}

/// 算术符model
class OperatorModel with ChangeNotifier {

  // 0表示加法，1表示减法，2表示乘法，3表示除法
  int value = 0;

  void update(int newValue) {
    if (value == newValue) return;

    value = newValue;
    notifyListeners();
  }
}