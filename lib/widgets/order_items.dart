import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/orders.dart' as ord;

class OrderItems extends StatefulWidget {
  final ord.OrderItem order;
  OrderItems({this.order});

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.order.amount.toString()),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.daetime),
            ),
            trailing: IconButton(
              icon: Icon( _expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded)
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 4),
            height: min(widget.order.products.length * 20.0 + 10.0,100.0),
            child: ListView.builder(

              itemCount: widget.order.products.length,
              itemBuilder: (ctx,i)=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.order.products[i].title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('${widget.order.products[i].qty.toString()} x ${widget.order.products[i].price}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
