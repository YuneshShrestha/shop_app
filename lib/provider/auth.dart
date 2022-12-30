import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _userId;
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
      _autoLogout();

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
      prefs.setString('userData', userData);
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

  Future<void> logOut() async {
    _token = null;
    _expiryDate = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
      // _authTimer = null;
    }
    final leftDuration = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: leftDuration), logOut);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
}
