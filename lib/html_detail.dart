import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw/it_tab.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlDetail extends StatefulWidget {

  @override
  _HtmlDetailState createState() => _HtmlDetailState();

}

class _HtmlDetailState extends State<HtmlDetail> {

  final Completer<WebViewController> _webviewController =
      Completer<WebViewController>();

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
        trailing: FutureBuilder<WebViewController>(
          future: _webviewController.future,
          builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
            return CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.refresh_bold),
              onPressed: () {
                _loadTextFieldContent(controller.data, _textEditingController.text);
              },
            );
          },
        ),
      ),
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
            Text('网页title'),
            Expanded(
              child: WebView(
                initialUrl: 'https://www.baidu.com',
                onWebViewCreated: (WebViewController controller) {
                  _webviewController.complete(controller);
                },
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// 通过webview加载输入框的内容
  void _loadTextFieldContent(WebViewController controller, String text) async{
//    print('------------------------text=$text');
    final String contentBase64 =
      base64Encode(const Utf8Encoder().convert(text));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}