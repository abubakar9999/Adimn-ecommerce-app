import 'package:admin_ecommarce/pages/screen/add_category.dart';
import 'package:admin_ecommarce/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../widgets/colors.dart';

class CategoryPag extends StatefulWidget {
  const CategoryPag({Key? key}) : super(key: key);

  @override
  State<CategoryPag> createState() => _CategoryPagState();
}

class _CategoryPagState extends State<CategoryPag> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catagorydata = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: catagorydata.categorydata.isNotEmpty
              ? NotificationListener<UserScrollNotification>(
                  onNotification: (notfication) {
                    setState(() {
                      if (notfication.direction == ScrollDirection.forward) {
                        _buttonVisiable = true;
                      } else if (notfication.direction ==
                          ScrollDirection.reverse) {
                        _buttonVisiable = false;
                      }
                    });
                    return true;
                  },
                  child: Container(
                    child: ListView.builder(
                        itemCount: catagorydata.categorydata.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child: Column(
                            children: <Widget>[
                              Text("${catagorydata.categorydata[index].name}")
                            ],
                          ));
                        }),
                  ),
                )
              : CircularProgressIndicator()),
      floatingActionButton: _buttonVisiable == true
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));

                    //   Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => AddCategory())).then(
                    (value) => catagorydata.getCategoryData());
              },
              backgroundColor: aBlackCardColor,
              child: Icon(
                Icons.add,
                size: 30,
                color: aPrimaryColor,
              ),
            )
          : null,
    );
  }

  bool onProgress = false;

  bool _buttonVisiable = true;
  ScrollController? _scrollController;
}
