import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/config.dart';
import 'package:quickcash/widgets/widget_home_categories.dart';
import 'package:quickcash/widgets/widget_home_products.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousel(context),
            WidgetHomeCategories(),
            WidgetHomeProducts(
                labelName: 'Today Offers', tagId: Config.todayOffersTagId),
            WidgetHomeProducts(
                labelName: 'Top Selling Products',
                tagId: Config.topSellingProductsTagId)
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Carousel(
          overlayShadow: false,
          borderRadius: true,
          boxFit: BoxFit.none,
          autoplay: true,
          dotSize: 4.0,
          images: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://ssl-static.libsyn.com/p/assets/8/2/9/b/829bbc8c5e1b07b5/logosoliditunes.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://ssl-static.libsyn.com/p/assets/8/2/9/b/829bbc8c5e1b07b5/logosoliditunes.jpg'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://raw.githubusercontent.com/jlouage/flutter-carousel-pro/master/screenshots/screenshot01.png'),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  'https://raw.githubusercontent.com/jlouage/flutter-carousel-pro/master/screenshots/screenshot01.png'),
            ),
          ],
        ));
  }
}
