import 'package:flutter/material.dart';

import 'views/home_page.dart';
import 'views/root_page.dart';
import 'views/sign_in_page.dart';
import 'views/sign_up.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table RPG',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        SignInPage.routeName: (context) => new SignInPage(),
        SignUpPage.routeName: (context) => new SignUpPage(),
        HomePage.routeName: (context) => new HomePage(),
      },
      home: RootPage(),
    );
  }
}
