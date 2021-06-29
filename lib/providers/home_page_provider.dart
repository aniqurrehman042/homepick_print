import 'package:flutter/material.dart';
import 'package:homepick_print/data/models/product.dart';

class HomePageProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      name: '',
      price: 0.0,
      qty: 0,
    ),
  ];
  List<String> _recipients = [];
  bool _loading = false;
  String _certificateYears = '10';

  String get certificateYears => _certificateYears;

  set certificateYears(String value) {
    _certificateYears = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<String> get recipients => _recipients;

  set recipients(List<String> value) {
    _recipients = value;
    notifyListeners();
  }

  double _totalAmount = 0;
  String _issuedTo = '';
  String _contact = '';
  String _email = '';
  String _address = '';
  String _debug = '';

  String get debug => _debug;
  set debug(String value) {
    _debug = value;
    notifyListeners();
  }

  String get issuedTo => _issuedTo;

  set issuedTo(String value) {
    _issuedTo = value;
    notifyListeners();
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  double get totalAmount => _totalAmount;

  set totalAmount(double value) {
    _totalAmount = value;
    notifyListeners();
  }

  String get contact => _contact;

  set contact(String value) {
    _contact = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get address => _address;

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int productIndex) {
    _products.removeAt(productIndex);
    notifyListeners();
  }

  void removeRecipient(int recipientIndex) {
    _recipients.removeAt(recipientIndex);
    notifyListeners();
  }

  double getTotalAmount() {
    var totalAmount = 0.0;
    _products.forEach(
        (product) => totalAmount += product.price * product.qty.toDouble());
    return totalAmount;
  }

  void updateProduct(Product product, int productIndex) {
    var oldProduct = _products[productIndex];
    if (product.name != null) {
      oldProduct.name = product.name;
    }
    if (product.price != null) {
      oldProduct.price = product.price;
    }
    if (product.qty != null) {
      oldProduct.qty = product.qty;
    }
    notifyListeners();
  }

  void updateRecipient(String recipient, int index) {
    _recipients[index] = recipient;
    notifyListeners();
  }

  void addRecipient() {
    _recipients.add('');
    notifyListeners();
  }
}
