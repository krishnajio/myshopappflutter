import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart';
import '../widgets/order_items.dart' as ordsc;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) => {
      Provider.of<Orders>(context,listen: false).fetchAndSetOrders()
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx,i) => ordsc.OrderItems(order:ordersData.orders[i],),
      )
    );

  }
}
