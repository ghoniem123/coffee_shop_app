// ignore_for_file: prefer_const_constructors
import 'package:coffee_shop/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'productProvider.dart';

class CartScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var userprov = Provider.of<UserProvider>(context);
    var productprov = Provider.of<ProductProvider>(context);
    var token = authProvider.token;

    var user = userprov.currentUser;

    var cart = userprov.cartItems;

    print("cccccccccccccccccccccccccccccccccccccccccccccc");

    print(cart);

    var productFetching = useMemoized(() {
      return productprov.fetchAllProductsFromServer(token).then((_) {
        userprov.setCart(productprov.allProduct);
        return productprov.allProduct;
      });
    }, [token]);

    void _onItemTapped(int index) {
      if (!authProvider.isAuthenticated) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/home');
            break;
          case 1:
            Navigator.of(context).pushNamed('/profile');
            break;
        }
      } else {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/home');
            break;
          case 1:
            Navigator.of(context).pushNamed('/cart');
            break;
          case 2:
            Navigator.of(context).pushNamed('/profile');
            break;
        }
      }
    }

    useEffect(() {
      productprov.clearProducts();
    });

    return FutureBuilder(
        future: productFetching,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 209, 99, 40)),
                )));
          } else {
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
                  )),
              body: Column(children: [
                Center(
                  child: Text('My Cart : ${cart.length ?? 0} Items',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Color.fromARGB(255, 7, 20, 61),
                      )),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, '/productDetails',
                                    //     arguments: icePr.id);
                                  },
                                  child: Card(
                                    // elevation: 0,
                                    child: Container(
                                      height: 200,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(cart[index].name,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 7, 20, 61),
                                                          fontFamily:
                                                              'RobotoSlab',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    cart[index].description,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'RobotoSlab',
                                                        color: Color.fromARGB(
                                                            255, 209, 98, 42),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Price: \$${cart[index].price}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        7,
                                                                        20,
                                                                        61),
                                                                fontFamily:
                                                                    'RobotoSlab',
                                                              ),
                                                            ),
                                                            Text(
                                                              'Rating: ${cart[index].rating}/5',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        7,
                                                                        20,
                                                                        61),
                                                                fontFamily:
                                                                    'RobotoSlab',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150,
                                              height: 200,
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 209, 99, 40),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  cart[index].image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )));
                        })),
                Center(
                  child: Text(
                    'Price : \$${cart.fold(0.0, (total, current) => total + current.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 7, 20, 61),
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Taxes : \$${0.14 * cart.fold(0.0, (total, current) => total + current.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 7, 20, 61),
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Total Price : \$${cart.fold(0.0, (total, current) => total + current.price) + 0.14 * cart.fold(0.0, (total, current) => total + current.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 7, 20, 61),
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    width: 280,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/order', arguments: {
                          'totalPrice': cart.fold(0.0,
                                  (total, current) => total + current.price) +
                              0.14 *
                                  cart.fold(
                                      0.0,
                                      (total, current) =>
                                          total + current.price),
                          'totalItems': cart.length,
                        });
                        // userprov.addToCart(token, user!.id, productId);

                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text(
                        //     'Product added to the cart successfully!',
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 209, 99, 40),
                        //         fontFamily: 'Roboto',
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        //   // duration: Duration(seconds: 5),
                        // ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 209, 98, 42)),
                        elevation: MaterialStateProperty.all(1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                                color: Color.fromARGB(255, 7, 20, 61)),
                          ),
                        ),
                      ),
                      child: Text("Proceed to checkout",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 20, 61))),
                    ),
                  ),
                ),
              ]),
              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      activeIcon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                      label: "Home"),
                  if (authProvider.isAuthenticated) ...[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                      ),
                      activeIcon: Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      label: "Cart",
                    ),
                  ],
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                    activeIcon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    label: "Profile",
                  ),
                ],
                currentIndex: 1,
                selectedItemColor: Color.fromARGB(255, 209, 98, 42),
                unselectedItemColor: Color.fromARGB(129, 209, 98, 42),
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                onTap: _onItemTapped,
              ),
            );
          }
        });
  }
}
