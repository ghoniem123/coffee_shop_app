// ignore_for_file: prefer_const_constructors
import 'package:coffee_shop/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'productProvider.dart';

class ProductsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vendorEmail = ModalRoute.of(context)!.settings.arguments;
    print(vendorEmail as String);

    var productvar = Provider.of<ProductProvider>(context, listen: true);
    var authprov = Provider.of<AuthProvider>(context);
    var userprov = Provider.of<UserProvider>(context, listen: true);
    var user = userprov.currentUser;

    var token = authprov.token;

    void _onItemTapped(int index) {
      if (!authprov.isAuthenticated) {
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

    print(token);

    var productFetching = useMemoized(() {
      return productvar.fetchProductsFromServer(token, vendorEmail as String);
    }, [token]);

    useEffect(() {
      productvar.clearProducts();
    }, []);

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
          var iceProducts = productvar.icedProducts;
          var hotProducts = productvar.hotProducts;
          print('iceeeeeeeeeeeee');
          print(iceProducts);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(110.0),
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
                  bottom: TabBar(
                    labelStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Color.fromRGBO(7, 20, 61, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: 'Iced Products'),
                      Tab(text: 'Hot Products'),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  iceProducts.length == 0
                      ? Center(
                          child: user?.type == 1
                              ? Text(
                                  "You didnt add any Iced drinks yet!",
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                  ),
                                )
                              : Text(
                                  'No Iced Products Available',
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                  ),
                                ))
                      : ListView.builder(
                          itemCount: iceProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/productDetails',
                                          arguments: iceProducts[index].id);
                                    },
                                    child: Card(
                                      elevation: 0,
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
                                                    Text(
                                                        iceProducts[index].name,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    7,
                                                                    20,
                                                                    61),
                                                            fontFamily:
                                                                'RobotoSlab',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      iceProducts[index]
                                                          .description,
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
                                                                'Price: \$${iceProducts[index].price}',
                                                                style:
                                                                    TextStyle(
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
                                                                'Rating: ${iceProducts[index].rating}/5',
                                                                style:
                                                                    TextStyle(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                    iceProducts[index].image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )));
                          }),
                  hotProducts.length == 0
                      ? Center(
                          child: user?.type == 1
                              ? Text(
                                  "You didnt add any Hot drinks yet!",
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                  ),
                                )
                              : Text(
                                  'No Hot Products Available',
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                  ),
                                ))
                      : ListView.builder(
                          itemCount: hotProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/productDetails',
                                          arguments: hotProducts[index].id);
                                    },
                                    child: Card(
                                      elevation: 0,
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
                                                    Text(
                                                        hotProducts[index].name,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    7,
                                                                    20,
                                                                    61),
                                                            fontFamily:
                                                                'RobotoSlab',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      hotProducts[index]
                                                          .description,
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
                                                                'Price: \$${hotProducts[index].price}',
                                                                style:
                                                                    TextStyle(
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
                                                                'Rating: ${hotProducts[index].rating}/5',
                                                                style:
                                                                    TextStyle(
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
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                    hotProducts[index].image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )));
                          },
                        ),
                ],
              ),
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
                  if (authprov.isAuthenticated) ...[
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
                currentIndex: 0,
                selectedItemColor: Color.fromARGB(255, 209, 98, 42),
                unselectedItemColor: Color.fromARGB(129, 209, 98, 42),
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                onTap: _onItemTapped,
              ),
            ),
          );
        }
      },
    );
  }
}
