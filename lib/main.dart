import 'package:admin_ecommarce/pages/auth/sign_In_page.dart';
import 'package:admin_ecommarce/pages/bottomNavigation.dart';
import 'package:admin_ecommarce/provider/category_provider.dart';

import 'package:admin_ecommarce/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OrderProvider>(create: (context) => OrderProvider()),
    ChangeNotifierProvider<CategoryProvider>(
        create: (context) => CategoryProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SingInPage(),
    );
  }
}
