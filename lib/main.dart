import 'package:flutter/material.dart';
import 'package:movilesfinal/pages/aparments_page.dart';
import 'package:movilesfinal/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apartments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        AparmentPage.routeName: (context) => AparmentPage(),
      },
      home: AparmentPage(),
    );
  }
}
