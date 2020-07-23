import 'package:flutter/foundation.dart';
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

  void addOrders(List<CartItem> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProduct,
        amount: total,
        daetime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
