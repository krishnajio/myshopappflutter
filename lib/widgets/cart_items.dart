import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String prodID;
  final double price;
  final int qty;
  final String title;

  CartItems(this.id, this.prodID,  this.price, this.qty, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(

      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(prodID);
      },
      confirmDismiss: (direction){
       return showDialog(context: context,
        builder: (ctx)=>AlertDialog(
          title: Text('Are u sure?'),
          content: Text('Do you want to remove the item'),
          actions: <Widget>[
            FlatButton(
              child: Text('YES'),
              onPressed: (){
                Navigator.of(ctx).pop(true);
              },
            ),
            FlatButton(
              child: Text('NO'),
              onPressed: (){
                Navigator.of(ctx).pop(false);
              },
            )
          ],
        ),);


      },
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(child: Text(price.toString()))),
              ),
              title: Text(title),
              subtitle: Text('Total : ${qty * price}'),
              trailing: Text('$qty x'),
            ),
          )),
    );
  }
}
