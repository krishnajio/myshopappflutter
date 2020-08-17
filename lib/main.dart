import 'package:flutter/material.dart';
import 'package:mytestshopapp/provider/cart.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_detial_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_products.dart';
import './screens/auth_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './provider/auth.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

//devlop bt krishna
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(auth.token,
              previousProducts == null ? [] : previousProducts.items,auth.userId),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth,Orders>(
          update: (ctx,auth,previoudOrders)=>Orders(auth.token, auth.userId,previoudOrders == null ? [] : previoudOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android : CustomPageTransitionBuilder()
            })
          ),
          // home: ProductOverviewScreen(),
          home: authData.isAuth ? ProductOverviewScreen() :  FutureBuilder(
            future: authData.tryAutoLogin(),
            builder: (ctx,authResultSnapShot)=> authResultSnapShot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : AuthScreen(),
          ),// AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreens.routeName: (ctx) => UserProductsScreens(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
