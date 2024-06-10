import "dart:async";

import "package:coffee_shop/product.dart";

import "./user.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class UserProvider with ChangeNotifier {
  User? _currentUser;
  List<Product> _cart = <Product>[];

  List<Product> get cartItems {
    return [..._cart];
  }

  void setCart(List<Product> allproducts) {
    print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    print("this is all theeeeeeeeeeeeeeeeeeeeeee $allproducts");
    _cart = [];
    print(_currentUser?.cart != null);
    // print(_currentUser?.cart != null);

    if (_currentUser?.cart != null) {
      for (var product in allproducts) {
        print('enter the loop');

        print(_currentUser!.cart.contains(product.id));

        if (_currentUser!.cart.contains(product.id)) {
          _cart.add(product);
        }
      }
    }
    // print('user cart');
    print(_cart);
    notifyListeners();
  }

  Future<void> createUser(
    String token,
    String name,
    String email,
    String password,
    DateTime birthDate,
    String phone,
    String country,
    String brandName,
    String image,
    int type,
    List<String> cart,
  ) async {
    final userUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/users.json?auth=$token');

    try {
      final response = await http.post(userUrl,
          body: json.encode({
            'name': name,
            'brandName': brandName,
            'image': image,
            'email': email,
            'password': password,
            "birthDate": birthDate.toIso8601String(),
            "phone": phone,
            "country": country,
            'type': type.toString(),
            'cart': cart
          }));

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      print(responseData);
      print("response dataaaaaaaaaaaaaaaaa");

      _currentUser = User(
        id: responseData['name'],
        name: name,
        brandName: brandName,
        image: image,
        email: email,
        password: password,
        birthDate: birthDate,
        phone: phone,
        country: country,
        type: type,
        cart: cart,
      );

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> findUser(String token, String email) async {
    final userUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/users.json?auth=$token');

    try {
      final response = await http.get(userUrl);
      print(json.decode(response.body));
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      responseData.forEach((userId, userData) {
        if (userData['email'] == email) {
          _currentUser = User(
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
              cart: userData['cart'] ?? <String>[]);

          notifyListeners();
        }
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> addToCart(String token, String userId, String productId) async {
    final userUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/users/$userId/cart.json?auth=$token');

    try {
      _currentUser!.cart.add(productId);

      await http.put(userUrl, body: json.encode(_currentUser!.cart));

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  User? get currentUser => _currentUser;
}
