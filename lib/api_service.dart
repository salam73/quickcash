import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quickcash/config.dart';
import 'package:quickcash/model/category.dart';
import 'package:quickcash/model/customer.dart';
import 'package:quickcash/model/login_model.dart';
import 'package:quickcash/model/product.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode((Config.key + ":" + Config.secret)),
    );
    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        print(e.response.data['code']);
        ret = false;
      } else {
        ret = false;
        print(e.response.data['code']);
      }
    }

    return ret;
  }

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    LoginResponseModel model;
    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = List<Category>();
    try {
      String url = Config.url +
          Config.categoriesURL +
          '?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
      var response = await Dio().get(
        url,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return data;
  }

  Future<List<Product>> getProducts({
    String categoryId,
    String tagName,
    int pageNumber,
    int pageSize,
    String strSearch,
    String sortBy,
    String sortOrder = "asc",
  }) async {
    // int categoryId;

    List<Product> data = List<Product>();

    try {
      String parameter = "";
      print(parameter);
      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }
      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }

      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }

      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }
      print(parameter);
      String url = Config.url +
          Config.productsuRL +
          '?consumer_key=${Config.key}&consumer_secret=${Config.secret}${parameter.toString()}';

      print(url);
      var response = await Dio().get(
        url,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return data;
  }
}
