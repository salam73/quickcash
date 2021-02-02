import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:quickcash/model/product.dart';

class ProductCard extends StatefulWidget {
  ProductCard({Key key, this.data}) : super(key: key);
  Product data;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Image.network(
                widget.data.images.length > 0
                    ? widget.data.images[0].src
                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                height: 120,
              ),
              Text(widget.data.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.data.salePrice != ""
                      ? 'دينار${widget.data.salePrice}'
                      : ''),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      'دينار${widget.data.regularPrice}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: widget.data.salePrice != ""
                              ? Colors.red
                              : Colors.black,
                          decoration: widget.data.salePrice != ""
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    /*Card(
      child: Column(
        children: [
          Image.network(
            widget.data.images.length > 0
                ? widget.data.images[0].src
                : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
            height: 130,
            fit: BoxFit.fill,
          ),
          Text(widget.data.name),
          Divider(
            thickness: 2,
            indent: 50,
            endIndent: 50,
          ),
          Row(
            //    mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.data.salePrice,
                ),
              ),
              Container(
                child: Text(
                  widget.data.regularPrice,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      decoration: widget.data.salePrice != ""
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ],
      ),
    );*/

    /*  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purpleAccent.withAlpha(40),
                      ),
                      Image.network(
                        widget.data.images.length > 0
                            ? widget.data.images[0].src
                            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                        height: 160,
                      ),
                      Text(widget.data.name),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );*/
  }
}
