import 'package:admin_ecommarce/http/coustom_http_request.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categorydata = [];

  getCategoryData() async {
    categorydata = await CustomHttpRequest().facthCategory();
    notifyListeners();
  }
}
