import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../provider/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context).findById(productid);
    return Scaffold(
      // appBar: AppBar(
      // title: Text(product.title),
      //),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                 SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 800,)
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
