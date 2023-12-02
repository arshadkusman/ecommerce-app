import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:sample/models/category_model.dart';
import 'package:sample/models/orderdetailmodel.dart';
import 'package:sample/models/product_model.dart';
import 'package:sample/models/user_model.dart';

class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  static const mainurl = 'http://bootcamp.cyralearnings.com/';

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('${mainurl}view_offerproducts.php'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>?> fetchCatProducts(String catid) async {
    log("catid ==$catid");
    final response = await http.post(
        Uri.parse('${mainurl}get_category_products.php'),
        body: {'catid': catid.toString()});
    log("statuscode ==${response.statusCode}");
    if (response.statusCode == 200) {
      log("catid in string");
      log("response ==${response.body}");
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Category');
    }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
      log("username ==$username");
      final response = await http.post(
          Uri.parse('${mainurl}get_orderdetails.php'),
          body: {'username': username.toString()});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.post(Uri.parse('${mainurl}getcategories.php'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<UserModel> fetchUser(String username) async {
    final response = await http.post(Uri.parse('${mainurl}get_user.php'),
        body: {'username': username});

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load fetchUser');
    }
  }
}
