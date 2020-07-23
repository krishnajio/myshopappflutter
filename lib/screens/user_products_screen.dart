import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../provider/products.dart';

class UserProductsScreens extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext ctx )  async {
     await Provider.of<Products>(ctx).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>_refreshProducts(context),
             child: Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, i) => UserProductItem(
              productsData.items[i].imageUrl, productsData.items[i].title,productsData.items[i].id
            ),
          ),
        ),
      ),
    );
  }
}
