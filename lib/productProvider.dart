// ignore_for_file: prefer_final_fields

import "dart:async";
import "./user.dart";
import "./product.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class ProductProvider with ChangeNotifier {
  List<Product> _vendorProducts = [];
  Product? _currentProduct;
  List<Product> _icedProducts = [];
  List<Product> _hotProducts = [];
  List<Product> _allProducts = [];

  List<Product> get allProduct {
    return [..._allProducts];
  }

  List<Product> get vendorProducts {
    return [..._vendorProducts];
  }

  List<Product> get icedProducts {
    return [..._icedProducts];
  }

  List<Product> get hotProducts {
    return [..._hotProducts];
  }

  Product? get currentProduct {
    return _currentProduct;
  }

  Future<void> createProduct(
    String token,
    String category,
    String vendorEmail,
    String name,
    String description,
    double price,
    double rating,
    String image,
    // double calories,
    // double fat,
    // double sugar,
    // double caffeine,
    List<String> comments,
  ) async {
    final productsUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/products.json?auth=$token');

    try {
      final response = await http.post(productsUrl,
          body: json.encode({
            'category': category,
            'vendorEmail': vendorEmail,
            'name': name,
            'description': description,
            'price': price,
            'rating': rating,
            'image': image,
            // 'calories': calories,
            // 'fat': fat,
            // 'sugar': sugar,
            // 'caffeine': caffeine,
            'comments': comments,
          }));

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> fetchAllProductsFromServer(String token) async {
    final productsUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(productsUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      responseData.forEach((productId, productData) {
        _allProducts.add(Product(
          id: productId,
          category: productData['category'],
          vendorEmail: productData['vendorEmail'],
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          rating: (productData['rating'] as num).toDouble(),
          image: productData['image'],
          comments: [],
        ));

        // notifyListeners();
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> fetchProductsFromServer(String token, String email) async {
    print("ENTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    final productsUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/products.json');

    print("fetccccccccccccch");

    try {
      final response = await http.get(productsUrl);

      print(response);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      print("this is the data");
      print(responseData);

      responseData.forEach((productId, productData) {
        if (productData['vendorEmail'] == email) {
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          _vendorProducts.add(Product(
            id: productId,
            category: productData['category'],
            vendorEmail: productData['vendorEmail'],
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            rating: (productData['rating'] as num).toDouble(),
            image: productData['image'],
            comments: [],
          ));
        }

        _icedProducts = _vendorProducts
            .where((element) => element.category == "Iced drinks")
            .toList();

        _hotProducts = _vendorProducts
            .where((element) => element.category == "Hot drinks")
            .toList();

        print("tbis is aaaaaaaaaaaaaaaaaaaaaaa");

        print(_vendorProducts);

        notifyListeners();
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateRating(
      String token, double rating, String productId) async {
    _currentProduct!.rating = (_currentProduct!.rating + rating);

    // print(_currentProduct!.rating);
    print(productId);

    final productUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/products/$productId/rating.json?auth=$token');

    try {
      final response = await http.put(
        productUrl,
        body: json.encode(_currentProduct!.rating),
      );

      if (response.statusCode == 200) {
        print('Update successful');
      } else {
        print('Update failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateComment(
      String token, String comment, String productId) async {
    _currentProduct?.comments.add(comment);

    final productUrl = Uri.parse(
        'https://coffee-f4d2a-default-rtdb.firebaseio.com/products/$productId/comments.json?auth=$token');

    try {
      await http.put(
        productUrl,
        body: json.encode(_currentProduct?.comments),
      );

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void findCurrentProduct(String id) {
    _currentProduct = _vendorProducts.firstWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearProducts() {
    _vendorProducts = [];
    _icedProducts = [];
    _hotProducts = [];
    _allProducts = [];
  }
}
