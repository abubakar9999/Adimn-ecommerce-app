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
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 1.8,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: catagorydata.categorydata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://apihomechef.antopolis.xyz/images/${catagorydata.categorydata[index].image}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color:
                                                primaryColor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(10))),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 0,
                                          width: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {}),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://apihomechef.antopolis.xyz/images/${catagorydata.categorydata[index].icon}")),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "${catagorydata.categorydata[index].name}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      },
                    ),
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
