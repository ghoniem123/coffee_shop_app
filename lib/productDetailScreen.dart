// ignore_for_file: prefer_const_constructors
import 'package:coffee_shop/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'productProvider.dart';

class ProductDetailScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    print(productId as String);

    var productvar = Provider.of<ProductProvider>(context, listen: true);
    var authprov = Provider.of<AuthProvider>(context);
    var userprov = Provider.of<UserProvider>(context, listen: true);
    var user = userprov.currentUser;

    print(user?.id);

    var token = authprov.token;

    print("details..........");

    useEffect(() {
        productvar.findCurrentProduct(productId as String);
    }, [productId]);

    var currentProduct = productvar.currentProduct;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 70,
            width: 70,
          ),
          backgroundColor: Color.fromARGB(255, 254, 243, 226),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 280,
                      height: 320,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 209, 99, 40), width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          currentProduct!.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        currentProduct.name,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 32,
                          color: Color.fromRGBO(7, 20, 61, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        currentProduct.description,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          color: Color.fromARGB(255, 209, 99, 40),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Price: \$${currentProduct.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 7, 20, 61),
                          fontFamily: 'RobotoSlab',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Rating: ${currentProduct.rating}/5',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 7, 20, 61),
                          fontFamily: 'RobotoSlab',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  if (authprov.isAuthenticated && user?.type == 0) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
                      child: Container(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            userprov.addToCart(token, user!.id, productId);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Product added to the cart successfully!',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 99, 40),
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              // duration: Duration(seconds: 5),
                            ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 209, 98, 42)),
                            elevation: MaterialStateProperty.all(1),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 7, 20, 61)),
                              ),
                            ),
                          ),
                          child: Text("Addt to cart",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 20, 61))),
                        ),
                      ),
                    ),
                  ]
                ],
              ))),
    );
  }
}
