import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime daetime;

  OrderItem(
      {@required this.id,
      @required this.products,
      @required this.amount,
      @required this.daetime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final timeStamp = DateTime.now();

    try {
      const url = 'https://myshopapp-1caec.firebaseio.com/orders.json';
      final response = await http.post(url, body: json.encode({
        'amount' : total,
        'daetime' : timeStamp.toIso8601String(),
        'products' : cartProduct.map((cp) => {
          'id' : cp.id,
          'title': cp.title,
          'qty':cp.qty,
          'price' : cp.price
        }).toList()

      },),);

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          products: cartProduct,
          amount: total,
          daetime: DateTime.now(),
        ),
      );
      notifyListeners();
    }
    catch(err) {}
  }
}
