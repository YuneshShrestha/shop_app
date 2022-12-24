import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId!;
  }

  Future<void> authentication(
      String email, String password, String urlString) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlString?key=AIzaSyCUWClv5finc5j-CeoHogtPH1CIkVSLZ0I";
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseDecode = json.decode(response.body);
      if (responseDecode['error'] != null) {
        throw HttpException(message: responseDecode['error']['message']);
      }
      _token = responseDecode['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseDecode['expiresIn']),
        ),
      );
      _userId = responseDecode['localId'];
      notifyListeners();
    } catch (e) {
      // throws when
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    // If you want put return it will exceute befor getting result from authentication
    return authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return authentication(email, password, 'signInWithPassword');
  }
}
