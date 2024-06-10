// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:coffee_shop/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'authProvider.dart';
import 'package:coffee_shop/userProvider.dart';

class FeedbackScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userprov = Provider.of<UserProvider>(context);
    var productprov = Provider.of<ProductProvider>(context);

    var commentController = useTextEditingController();

    var cart = userprov.cartItems;

    var token = authProvider.token;

    var rating = useState('0');

    // var isClicked = useState(false);

    void _onItemTapped(int index) {
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
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
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          // child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Align(
              //   alignment: Alignment.center,
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text('Order Have Been Delivered',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 7, 20, 61)),
                      textAlign: TextAlign.center),
                ),
                //       ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Column(children: [
                              InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, '/productDetails',
                                    //     arguments: icePr.id);
                                  },
                                  child: Card(
                                    // elevation: 0,
                                    child: Container(
                                      height: 100,
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
                                                            // Text(
                                                            //   'Rating: ${cart[index].rating}/5',
                                                            //   style: TextStyle(
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .bold,
                                                            //     fontSize: 14,
                                                            //     color: Color
                                                            //         .fromARGB(
                                                            //             255,
                                                            //             7,
                                                            //             20,
                                                            //             61),
                                                            //     fontFamily:
                                                            //         'RobotoSlab',
                                                            //   ),
                                                            // ),
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
                                              width: 80,
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
                                  )),
                              Row(children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  //  Align(
                                  // alignment: Alignment.centerLeft,
                                  //         child:
                                  child: Text(
                                    "Rating:",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'RobotoSlab',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 7, 20, 61)),

                                    //          ),
                                  ),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: rating,
                                    builder: (BuildContext context,
                                        String value, Widget? child) {
                                      return DropdownButton<String>(
                                        value: rating.value,
                                        items: const [
                                          DropdownMenuItem<String>(
                                            child: Text("0"),
                                            value: "0",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text("1"),
                                            value: "1",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text("2"),
                                            value: "2",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text("3"),
                                            value: "3",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text("4"),
                                            value: "4",
                                          ),
                                          DropdownMenuItem<String>(
                                            child: Text("5"),
                                            value: "5",
                                          ),
                                        ],
                                        onChanged: (String? value) {
                                          rating.value = value!;
                                        },
                                      );
                                    }),
                              ]),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      "Comment",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'RobotoSlab',
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 7, 20, 61)),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 209, 99, 40)),
                                ),
                                child: TextField(
                                  // readOnly: isClicked.value,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: commentController,
                                  maxLength: 1000,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 2.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  width: 120,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // var state = stateController.text.trim();
                                      // isClicked.value = true;
                                      var comment =
                                          commentController.text.trim();

                                      productprov.updateComment(
                                          token, comment, cart[index].id!);

                                      productprov.updateRating(
                                          token,
                                          double.parse(rating.value),
                                          cart[index].id!);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 209, 98, 42)),
                                      //     .resolveWith<Color>(
                                      //   (Set<MaterialState> states) {
                                      //     if (states.contains(
                                      //             MaterialState.pressed) ||
                                      //         isClicked.value)
                                      //       return Colors
                                      //           .grey; // the color when button is pressed or isClicked is true
                                      //     return Color.fromARGB(255, 209, 98,
                                      //         42); // default color
                                      //   },
                                      // ),
                                      elevation: MaterialStateProperty.all(1),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          // borderRadius: BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 20, 61)),
                                        ),
                                      ),
                                    ),
                                    child: Text("Confirm",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'RobotoSlab',
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 7, 20, 61))),
                                  ),
                                ),
                              ),
                            ]));
                      })),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
                child: Container(
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      // var state = stateController.text.trim();

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Thank you for your feedback!',
                          style: TextStyle(
                              color: Color.fromARGB(255, 209, 99, 40),
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        // duration: Duration(seconds: 5),
                      ));
                      Navigator.of(context).pushNamed('/home');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 209, 98, 42)),
                      elevation: MaterialStateProperty.all(1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(30),
                          side:
                              BorderSide(color: Color.fromARGB(255, 7, 20, 61)),
                        ),
                      ),
                    ),
                    child: Text("Enter my feedback",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'RobotoSlab',
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 20, 61))),
                  ),
                ),
              ),
            ],
          )),
      //),
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
        currentIndex: 0,
        selectedItemColor: Color.fromARGB(255, 209, 98, 42),
        unselectedItemColor: Color.fromARGB(129, 209, 98, 42),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
