import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart';
import '../widgets/order_items.dart' as ordsc;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Yours Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
          builder: (ctx,dataSnapshot){
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LinearProgressIndicator(minHeight: 20,),);
            }
            else{
              if(dataSnapshot.error!= null)
                {
                  // ...
                  // Do error handling stuff
                  return Center(
                    child: Text('An error occurred!'),
                  );
                }
                else{
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => ordsc.OrderItems( order: orderData.orders[i]),
                  ),
                );
              }
            }
           }
        ),
    );
  }
}


//_isLoading
//? Center(child: CircularProgressIndicator())
//: ListView.builder(
//itemCount: ordersData.orders.length,
//itemBuilder: (ctx, i) => ordsc.OrderItems(
//order: ordersData.orders[i],
//),
//),);