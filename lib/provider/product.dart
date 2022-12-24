import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});
  Future<void> toggleFavrouite(String token, String userId) async {
    var currentFav = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        "https://myapp-8ae0f-default-rtdb.firebaseio.com/userFavourite/$userId/$id.json?auth=$token";
    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        isFavourite = currentFav;
        notifyListeners();
      }
    }
    // Catch kina bhnae net na chalda ni error aauna paro
    catch (e) {
      isFavourite = currentFav;
      notifyListeners();
    }
  }
}
