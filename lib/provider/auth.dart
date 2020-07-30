import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';


class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
      if (responseBody['error'] != null){
        return HttpException(responseBody['error']['message']);
      }
    } catch (err) {
          throw err;
    }

    // print(json.decode(response.body));
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
