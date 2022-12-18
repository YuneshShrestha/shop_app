import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';
import './product.dart';

// ChangeNotifier helps to create a communication channel using context
class Products with ChangeNotifier {
  // _items cannot be accessed from outside
  List<Product> _items = [];
  List<Product> get items {
    // return copy of _items
    // we do this to prevent data to be changed from outside this class
    // so that only this class can change data which helps to use notifyListeners
    return [..._items];
  }

  List<Product> get showFavs {
    return _items.where((element) => element.isFavourite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url = "https://myapp-8ae0f-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Product> products = [];
      if (extractedData == null) return;
      extractedData.forEach((productID, productData) {
        products.insert(
            0,
            Product(
                id: productID,
                title: productData['title'],
                description: productData['description'],
                price: productData['price'],
                imageUrl: productData['imageUrl']));
      });
      _items = products;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = "https://myapp-8ae0f-default-rtdb.firebaseio.com/products.json";
    // body takes json format so we can't directly convert object to json but we convert map to json
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFavourite": product.isFavourite
          }));

      product = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      _items.insert(0, product);

      // Listeners listening to this notfier gets rebuild when something
      // changes
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    try {
      final url =
          "https://myapp-8ae0f-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(Uri.parse(url),
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "imageUrl": newProduct.imageUrl,
            "price": newProduct.price,
          }));
      final index = _items.indexWhere((element) => element.id == id);
      _items[index] = newProduct;
      notifyListeners();
    } catch (e) {
      throw HttpException(message: "Error Occured");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://myapp-8ae0f-default-rtdb.firebaseio.com/products/$id.json";
    final existingItemIndex = _items.indexWhere((item) => item.id == id);
    Product? existingItem = _items[existingItemIndex];
    _items.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw HttpException(message: "Error Occured");
    }
    existingItem = null;
  }

  Product getProductById(String id) {
    return items.firstWhere((item) => item.id == id);
  }
}
