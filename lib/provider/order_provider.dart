import 'package:admin_ecommarce/http/coustom_http_request.dart';
import 'package:admin_ecommarce/models/ordermodel.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  List<Order> orderData = [];

  getOrderData() async {
    orderData = await CustomHttpRequest().facthOrderData();
    notifyListeners();
  }
}
