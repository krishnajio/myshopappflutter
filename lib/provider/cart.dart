import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, caretItem) {
      total += caretItem.qty * caretItem.price;
    });
    return total;
  }

  void addItems(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            qty: existingCartItem.qty + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(), title: title, price: price, qty: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void removeSingleItem(String productID){
    if (!_items.containsKey(productID)) {
      return;
    }

    if (_items[productID].qty > 1 ) {
      _items.update(
        productID,
            (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            qty: existingCartItem.qty - 1),
      );
    }
    else{
      _items.remove(productID);
    }
      notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }
}

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.qty,
      @required this.price});
}
