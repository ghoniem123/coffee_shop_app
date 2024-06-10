import 'package:coffee_shop/feedbackScreen.dart';
import 'package:coffee_shop/orderScreen.dart';
import 'package:coffee_shop/productDetailScreen.dart';
import 'package:coffee_shop/productsScreen.dart';
import 'package:coffee_shop/vendorSignupScreen.dart';
import 'package:flutter/material.dart';
import './authProvider.dart';
import './vendorProvider.dart';
// import './idProvider.dart';
import 'package:provider/provider.dart';
import 'homeScreen.dart';
import 'loginSignUpScreen.dart';
import 'profileScreen.dart';
import 'cartScreen.dart';
import './userProvider.dart';
import './productProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => VendorProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Brew and Bake',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => LoginScreen(),
            '/home': (ctx) => HomeScreen(),
            '/profile': (ctx) => ProfileScreen(),
            '/cart': (ctx) => CartScreen(),
            '/vendor': (ctx) => VendorScreen(),
            '/products': (ctx) => ProductsScreen(),
            '/productDetails': (ctx) => ProductDetailScreen(),
            '/order': (ctx)=> OrderScreen(),
            '/feedback': (ctx)=> FeedbackScreen(),
          }),
    );
  }
}
