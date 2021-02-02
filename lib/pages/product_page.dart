import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcash/model/product.dart';
import 'package:quickcash/pages/base_page.dart';
import 'package:quickcash/provider/products_provider.dart';
import 'package:quickcash/widgets/widget_product_card.dart';

import '../api_service.dart';

// ignore: must_be_immutable
class ProductPage extends BasePage {
  int categoryId;

  ProductPage({Key key, this.categoryId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  int _page = 1;
  ScrollController _scrollController = ScrollController();

  final _sortByOption = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "Price: Low to High", "asc"),
  ];

  @override
  void initState() {
    // apiService = APIService();

    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStream();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page);
      }
    });

    super.initState();
  }

  @override
  Widget pageUI() {
    return _productsList();
  }

  Widget _productsList() {
    return Consumer<ProductProvider>(
        // future: apiService.getProducts(categoryId: widget.categoryId),

        builder: (context, productsModel, child) {
      print(productsModel.allProduct.length.toString());
      if (productsModel.allProduct != null &&
          productsModel.allProduct.length > 0 &&
          productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
        return _buildList(productsModel.allProduct,
            productsModel.getLoadMoreStatus() == LoadMoreStatus.LOADING);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget _buildList(List<Product> items, bool isLoadMore) {
    return Column(
      children: [
        _productFilter(),
        Flexible(
          child: GridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: items.map((Product item) {
              return Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductCard(
                    data: item,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: CircularProgressIndicator(),
          ),
          visible: isLoadMore,
        )
      ],
    );

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: items.map((Product item) {
        return Container(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ProductCard(
              data: item,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _productFilter() {
    return Container(
      height: 51,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(9),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productsList =
                    Provider.of<ProductProvider>(context, listen: false);
                productsList.resetStream();
                productsList.setSortOrder(sortBy);
                productsList.fetchProducts(_page);
              },
              itemBuilder: (BuildContext context) {
                return _sortByOption.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Container(
                      child: Text(item.text),
                    ),
                  );
                }).toList();
              },
              icon: Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
