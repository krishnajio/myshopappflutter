import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      String url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAeKJGDgOzyRFI2WfnAQNlUDWMuD1cdpBo';
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseBody = json.decode(response.body);

      if (responseBody['error'] != null) {
        print(responseBody['error']['message']);
        return HttpException(responseBody['error']['message']);
      }

      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'userId': _userId,
          'token': _token,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } catch (err) {
      //print(err);
      throw err;
    }

    // print(json.decode(response.body));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extracdData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryData = DateTime.parse(extracdData['expiryDate']);

    if (expiryData.isBefore(DateTime.now())) {
      return false;
    }

    _token = extracdData['token'];
    _userId = extracdData['userId'];
    _expiryDate = expiryData;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

   Future<void> logoff() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.remove('userData');
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logoff);
  }
} //Class Auth
