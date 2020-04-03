import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgw/it_tab.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlDetail extends StatefulWidget {

  @override
  _HtmlDetailState createState() => _HtmlDetailState();

}

class _HtmlDetailState extends State<HtmlDetail> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: ItTab.title,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.refresh_bold),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
                child: CupertinoTextField(
                  placeholder: '请在这输入html',
                  maxLines: null,
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey, width: 2),
                  ),
                ),
            ),
            Expanded(
              child: WebView(
                initialUrl: 'https://www.baidu.com',
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}