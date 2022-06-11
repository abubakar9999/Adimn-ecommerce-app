import 'package:admin_ecommarce/http/coustom_http_request.dart';
import 'package:admin_ecommarce/pages/screen/add_category.dart';
import 'package:admin_ecommarce/pages/screen/edit_category.dart';
import 'package:admin_ecommarce/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
      body: ModalProgressHUD(
        inAsyncCall: onProgress == true,
        progressIndicator: CircularProgressIndicator(),
        child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://apihomechef.antopolis.xyz/images/${catagorydata.categorydata[index].image}"),
                                              fit: BoxFit.cover)),
                                    ),
                                    Positioned(
                                        child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(10))),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Are you sure ?'),
                                                    titleTextStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: aTextColor),
                                                    titlePadding:
                                                        EdgeInsets.all(10),
                                                    content: Text(
                                                        'Once you delete, the item will gone permanently.'),
                                                    contentTextStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: aTextColor),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 35,
                                                            top: 10,
                                                            right: 40),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            onProgress = true;
                                                          });
                                                          await CustomHttpRequest
                                                              .deleteCatagory(
                                                                  catagorydata
                                                                      .categorydata[
                                                                          index]
                                                                      .id!
                                                                      .toInt());
                                                          setState(() {
                                                            catagorydata
                                                                .categorydata
                                                                .removeAt(
                                                                    index);
                                                            onProgress = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          print(
                                                              "dedettttttttttttttttttttttttttttt");
                                                        },
                                                        child: Text("Delete"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    )),
                                    Positioned(
                                        right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  primaryColor.withOpacity(0.5),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditCategory(
                                                              categoryModel:
                                                                  catagorydata
                                                                          .categorydata[
                                                                      index],
                                                            )));
                                              },
                                            ),
                                          ),
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
      ),
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


// Positioned(
//                                         top: 0,
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           height: 0,
//                                           width: 80,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Expanded(
//                                                 child: IconButton(
//                                                     icon: Icon(
//                                                       Icons.edit,
//                                                       size: 15,
//                                                       color: Colors.white,
//                                                     ),
//                                                     onPressed: () {}),
//                                               ),
//                                               Expanded(
//                                                 child: IconButton(
//                                                   icon: Icon(
//                                                     Icons.delete,
//                                                     size: 15,
//                                                     color: Colors.white,
//                                                   ),
//                                                   onPressed: () {
//                                                    
//                                                   },
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),