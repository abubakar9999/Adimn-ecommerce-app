import 'dart:convert';

import 'package:admin_ecommarce/models/category_model.dart';
import 'package:admin_ecommarce/widgets/tost_message.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../models/ordermodel.dart';

class CustomHttpRequest {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

  late SharedPreferences sharedPreferences;

  Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}",
    };
    print("Token is ${sharedPreferences.getString("token")} ");

    return header;
  }

  facthOrderData() async {
    List<Order> orderData = [];
    late Order order;
    var respons = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/all/orders"),
        headers: await CustomHttpRequest().getHeaderWithToken());
    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body);
      for (var item in data) {
        order = Order.fromJson(item);
        orderData.add(order);
      }
    }
    return orderData;
  }

  facthCategory() async {
    List<CategoryModel> categorydata = [];
    late CategoryModel categoryModel;

    var respons = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/category"),
        headers: await CustomHttpRequest().getHeaderWithToken());

    var data = jsonDecode(respons.body);
    if (respons.statusCode == 200) {
      for (var catdata in data) {
        categoryModel = CategoryModel.fromJson(catdata);
        categorydata.add(categoryModel);
      }
    }
    return categorydata;
  }

  static Future<dynamic> deleteCatagory(int id) async {
    var respons = await http.delete(
      Uri.parse(
          "https://apihomechef.antopolis.xyz/api/admin/category/$id/delete"),
      headers: await CustomHttpRequest().getHeaderWithToken(),
    );

    if (respons.statusCode == 200) {
      showInToast("Delete  SuccessFull");
    } else {
      showInToast("Delete Errror");
    }
  }
}
