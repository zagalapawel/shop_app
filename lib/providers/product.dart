import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final url = Uri.https(
      'fluttershopapp-a7999-default-rtdb.europe-west1.firebasedatabase.app',
      '/userFavorites/$userId/$id.json',
      {'auth': token},
    );
    final _oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(
      url,
      body: jsonEncode(
        isFavorite,
      ),
    );
    if (response.statusCode >= 400) {
      isFavorite = _oldStatus;
      notifyListeners();
      throw HttpException('Cloud not add to favorite.');
    }
  }
}
