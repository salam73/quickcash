import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcash/pages/home_page.dart';
import 'package:quickcash/pages/login_page.dart';
import 'package:quickcash/pages/product_page.dart';
import 'package:quickcash/pages/signup_page.dart';
import 'package:quickcash/provider/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'المتجر',
        theme: ThemeData(
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),

          accentColor: Colors.redAccent,
          //  iconTheme: IconThemeData(color: Colors.deepOrange),

          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 22,
              color: Colors.redAccent,
            ),
            headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
            ),
            bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent,
            ),
          ),

          //primarySwatch: Colors.blue,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
