import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw/it_tab.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlDetail extends StatefulWidget {

  @override
  _HtmlDetailState createState() => _HtmlDetailState();

}

class _HtmlDetailState extends State<HtmlDetail> {

  final _textEditingController = TextEditingController();

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
//    print('-----------------build');
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.refresh_bold),
          onPressed: () {
            _loadTextFieldContent(_controller, _textEditingController.text);
          },
        ),
    ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: WebViewModel()),
        ],
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CupertinoTextField(
                  controller: _textEditingController,
                  placeholder: '请在这输入html',
                  maxLines: null,
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey, width: 2),
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.systemGrey3,
                width: MediaQuery.of(context).size.width,
                child: Consumer<WebViewModel>(
                  builder: (context, WebViewModel model, _) {
                    return Text(model.title);
                  },
                ),
              ),
              Expanded(
                child:Consumer<WebViewModel>(
                  builder: (context, WebViewModel model, _) {
                    return WebView(
                      initialUrl: 'https://www.baidu.com',
                      onWebViewCreated: (WebViewController controller) {
                        _controller = controller;
                      },
                      onPageFinished: (String url) {
//                        print(('----------onPageFinished url=$url'));
                        model.updateTitle(_controller);
                      },
                    );
                  },
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 通过webview加载输入框的内容
  void _loadTextFieldContent(WebViewController controller, String text) async{
    if (controller == null) {
      print('webview controller is null');
      return;
    }

    if (text.isEmpty) {
      BotToast.showText(text: '输入内容为空');
      return;
    }

    final String contentBase64 =
      base64Encode(const Utf8Encoder().convert(text));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}

class WebViewModel extends ChangeNotifier {
  String title = '网页标题';

  void updateTitle(WebViewController controller) async{
    String newTitle = await controller.getTitle();

    if (newTitle == title) return;

    if (newTitle.isEmpty) {
      title = '网页标题';
    }

    title = newTitle;
    notifyListeners();
  }
}