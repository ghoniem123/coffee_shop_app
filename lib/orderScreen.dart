// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:coffee_shop/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'productProvider.dart';

class OrderScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final totalPrice = args['totalPrice'];
    final totalItems = args['totalItems'];

    var stateController = useTextEditingController();
    var cityController = useTextEditingController();
    var addressController = useTextEditingController();

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
        body: SingleChildScrollView(
      child:  Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Cart: ${totalItems} Items',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 20, 61))),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Total Price:  \$${totalPrice} Items',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 20, 61))),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: Text('Shipping Information',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61))),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "State:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 20, 61)),
                  ),
                ),
              ),
              Container(
                height: 25.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: stateController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your state',
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "City:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 20, 61)),
                  ),
                ),
              ),
              Container(
                height: 25.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: cityController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your city',
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Detailed Address:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 20, 61)),
                  ),
                ),
              ),
              Container(
                height: 25.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your address',
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              Center(
                  child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 217, 217, 217),
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                            child: Text("Payment Method",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'RobotoSlab',
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 7, 20, 61))),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 7, 20, 61),
                            height: 10,
                            thickness: 5,
                            // indent: 20,
                            // endIndent: 20,
                          ),
                          // Center(
                          //        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                                width: 30.0,
                                height: 30.0,
                                child: Icon(
                                  Icons.check_box_outlined,
                                  color: Color.fromARGB(255, 7, 20, 61),
                                ),
                              ),
                              Text("Cash On Delivery",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'RobotoSlab',
                                      color: Color.fromARGB(255, 209, 99, 40)))
                            ],
                            //),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
                        child: Container(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              var state = stateController.text.trim();
                              var city = cityController.text.trim();
                              var address = addressController.text.trim();

                              // if (state.isNotEmpty &&
                              //     city.isNotEmpty &&
                              //     address.isNotEmpty) {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(SnackBar(
                              //     content: Text(
                              //       'Please fill all the fields!',
                              //       style: TextStyle(
                              //           color: Color.fromARGB(255, 209, 99, 40),
                              //           fontFamily: 'Roboto',
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     // duration: Duration(seconds: 5),
                              //   ));
                              // } else {
                                Navigator.of(context).pushNamed('/feedback');
                             // }
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
                            child: Text("Confirm Order",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'RobotoSlab',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 20, 61))),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              )),
            ],
          ),
        )));
  }
}
