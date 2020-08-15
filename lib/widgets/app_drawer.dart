import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_overview_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friends'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading:  Icon( Icons.shop),
            title: Text('Go to shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading:  Icon( Icons.payment),
            title: Text('Go my orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading:  Icon( Icons.edit),
            title: Text('Go my products'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreens.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading:  Icon( Icons.exit_to_app),
            title: Text('Go my products'),
            onTap: (){
              Navigator.of(context).pop();
              Provider.of<Auth>(context).logoff();
            },
          )
        ],
      ),
    );
  }
}
