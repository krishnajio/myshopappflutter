import 'package:flutter/material.dart';
import 'package:mytestshopapp/provider/cart.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_detial_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_products.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './provider/orders.dart';


void main() {
  runApp(MyApp());
}
//devlop bt krishna
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider( providers: [
    ChangeNotifierProvider(
    create: (context) => Products()),
      ChangeNotifierProvider(
          create: (context) => Cart()),
      ChangeNotifierProvider(
        create: (context)=>Orders(),
      ),
    ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
          CartScreen.routeName : (ctx)=>CartScreen(),
          OrdersScreen.routeName : (ctx)=> OrdersScreen(),
          UserProductsScreens.routeName : (ctx)=>UserProductsScreens(),
          EditProductScreen.routeName : (ctx)=>EditProductScreen(),
        },
      ),
    );
  }
}
