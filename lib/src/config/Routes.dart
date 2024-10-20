import 'package:flutter/material.dart';
import 'package:project/src/pages/MainPage.dart';
import 'package:project/src/pages/WelcomeScreen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/welcome':(_) => WelcomeScreen(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}