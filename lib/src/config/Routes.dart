import 'package:flutter/material.dart';
import 'package:project/src/pages/MainPage.dart';
import 'package:project/src/pages/WelcomeScreen.dart';

import '../widgets/ListaCategorias.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/welcome':(_) => WelcomeScreen(),
      '/categorias':(_)=> ListaCategorias(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}