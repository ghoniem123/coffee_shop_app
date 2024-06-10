import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _token = "";
  DateTime _expiryDate = DateTime.utc(1970);
  String _userId = "";
  bool _authenticated = false;

  bool get isAuthenticated {
    return _authenticated;
  }

  String get token {
    if (_expiryDate != DateTime.utc(1970) &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  Future<String> signup(
      {required String email, required String password}) async {
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AddYourAPIKeyHere');

    try {
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

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData['error']);
        return responseData['error']['message'];
      } else {
        _authenticated = true;
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseData['expiresIn'],
            ),
          ),
        );
        print(_authenticated.toString() +
            " " +
            _userId +
            " " +
            _expiryDate.toString());
        notifyListeners();
        return "success";
      }
    } catch (err) {
      print("The error is: " + err.toString());
      throw err;
    }
  }

  Future<String> signin(
      {required String email, required String password}) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AddYourAPIKeyHere');
    try {
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

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        // print(responseData['error']);
        return responseData['error']['message'] as String;
      } else {
        _authenticated = true;
        _token = responseData['idToken'];

        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              responseData['expiresIn'],
            ),
          ),
        );

        print(_authenticated.toString() +
            " " +
            _userId +
            " " +
            _expiryDate.toString());
        notifyListeners();
        return "success";
      }
    } catch (err) {
      print("The error is: " + err.toString());
      throw err;
    }
  }

  void logout() {
    _authenticated = false;
    _expiryDate = DateTime.now();
  }
}
