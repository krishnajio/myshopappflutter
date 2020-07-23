import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../provider/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
    final product= Provider.of<Products>(context).findById(productid);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              child: Image.network(product.imageUrl),
            ),
          SizedBox(width: 10,),
            Text(
              product.price.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
              ),
            ),
            SizedBox(width: 10,),
            Text(
              product.description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
              ),
            )
          ],

        ),
      ),

    );
  }
}
