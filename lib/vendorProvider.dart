import 'package:coffee_shop/product.dart';

import './user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VendorProvider with ChangeNotifier {
  List<User> _vendors = [];

  List<User> get vendors {
    return [..._vendors];
  }

  Future<void> fetchAndSetVendors(String token) async {
    final userUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/users.json?auth=$token');

    try {
      final response = await http.get(userUrl);
      print(json.decode(response.body));
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      responseData.forEach((userId, userData) {
        if (userData['type'] == "1") {
          _vendors.add(User(
              id: userId,
              name: userData['name'],
              brandName: userData['brandName'],
              image: userData['image'],
              email: userData['email'],
              password: userData['password'],
              birthDate: DateTime.parse(userData['birthDate']),
              phone: userData['phone'],
              country: userData['country'],
              type: int.parse(userData['type']),
              cart: <String>[]));

          notifyListeners();
        }
      });
    } catch (err) {
      print(err);
    }
  }

  void clearVendors() {
    _vendors = [];
  }
}
