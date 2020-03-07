import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pgw/it_tab.dart';
import 'package:pgw/math_tab.dart';
import 'generated/l10n.dart';

void main() {
  debugPaintSizeEnabled = false; // 调式对齐格子线开关
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context) {
        return S.of(context).app_name;
      },

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            title: Text(MathTab.title),
            icon: MathTab.icon,
          ),
          BottomNavigationBarItem(
            title: Text(ItTab.title),
            icon: ItTab.icon
          )
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: MathTab.title,
              builder: (context) => MathTab()
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: ItTab.title,
              builder: (context) => ItTab()
            );
          default:
            return null;
        }
      },
    );
  }
}
