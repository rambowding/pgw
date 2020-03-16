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
        ],
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // 结果区
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                      builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowMode, _) {
                        return GestureDetector(
                          onTap: () => arrowMode.update(true),
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
                            ),
                          ),
                        );
                      },
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    child: Text('+',
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                      builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowMode, _) {
                        return GestureDetector(
                          onTap: () => arrowMode.update(false),
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
                            ),
                          ),
                        );
                      },
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    child: Text('=',
                      textAlign: TextAlign.center,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.systemGrey, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text('?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    flex: 5,
                  ),
                ],
              ),
              // 箭头区
              Container( // 此区域用Container来wrap一下，否则高度会过高，导致超过屏幕尺寸，原因未知
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Consumer<ArrowAreaModel>(
                        builder: (context, ArrowAreaModel model, _) {
                          if (model.isLeft) {
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
                          if (model.isLeft) {
                            return Container();
                          } else {
                            return Image.asset('assets/images/arrow_up.png');
                          }
                        },
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 6,
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
                                  onPressed: () => resultModel.update('1', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('2', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('3', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('4', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('5', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('6', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('7', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('8', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('9', arrowModel.isLeft),
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
                                  onPressed: () => resultModel.update('0', arrowModel.isLeft),
                                  child: child,
                                ),
                                child: Text('0',
                                  style: TextStyle(
                                      fontSize: 30
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                            ),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Consumer2<ResultAreaModel, ArrowAreaModel>(
                                builder: (context, ResultAreaModel resultModel, ArrowAreaModel arrowModel, child) => FloatingActionButton(
                                  heroTag: 10,
                                  onPressed: () => resultModel.update('c', arrowModel.isLeft),
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
    );
  }
}

/// 测试局部刷新用，暂时保留
class MyFab extends StatelessWidget {
  final index;

  const MyFab(this.index);

  @override
  Widget build(BuildContext context) {
    print('---------------MyTab build---index=$index');
    return Icon(Icons.add);
  }
}

/// 结果区的model
class ResultAreaModel with ChangeNotifier {

  String left = '0';
  String right = '0';

  void update(String key, bool isSelectLeft) {
    if (isSelectLeft) {
      if (key == 'c') left = '0';// 清除
      else if (left == '0') left = key;
      else {
        if (left.length >= 4) {
          BotToast.showText(text: '数字太大啦，请先练习一万以内的数字');
          return;
        }
        left += key;
      }
    } else {
      if (key == 'c') right = '0';
      else if (right == '0') right = key;
      else {
        if (right.length >= 4) {
          BotToast.showText(text: '数字太大啦，请先练习一万以内的数字');
          return;
        }
        right += key;
      }
    }
//    print('-------isLeft=$isSelectLeft----------left=$left----------right=$right');

    // 通知消费者更新
    notifyListeners();
  }
}

/// 箭头区的model
class ArrowAreaModel with ChangeNotifier {
  /// true表示修改左边数字，false表示修改右边数字
  bool isLeft = true;

  void update(bool left) {
    if (isLeft == left) return;

    isLeft = left;
    notifyListeners();
  }
}