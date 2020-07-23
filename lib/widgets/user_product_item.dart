import 'package:flutter/material.dart';
import '../screens/edit_products.dart';
class UserProductItem extends StatelessWidget {
  final String imageURL;
  final String tittle;
  final String id;
  UserProductItem(this.imageURL,this.tittle,this.id);

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
              ),
      title: Text(tittle),
      trailing: Container(
        width: 120,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,),
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);

              },
            ),
            SizedBox(width: 5,),
            IconButton(
              icon: Icon(Icons.delete,color: Theme.of(context).errorColor,),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
