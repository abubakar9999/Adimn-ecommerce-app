import 'package:admin_ecommarce/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mydata = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: mydata.orderData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(mydata.orderData[index].user!.name.toString()),
                  subtitle: Text(mydata.orderData[index].payment.toString()),
                  leading: CircleAvatar(
                    child: Text(mydata.orderData[index].id.toString()),
                  ),
                  trailing: Column(
                    children: <Widget>[
                      Text(mydata.orderData[index].price.toString()),
                      Text(mydata.orderData[index].discount.toString()),
                      Text(mydata.orderData[index].quantity.toString()),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
