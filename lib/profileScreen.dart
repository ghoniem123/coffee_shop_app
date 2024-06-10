// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:coffee_shop/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'authProvider.dart';
import 'package:coffee_shop/userProvider.dart';

class ProfileScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var authprov = Provider.of<AuthProvider>(context, listen: true);
    var userprov = Provider.of<UserProvider>(context, listen: true);
    var productprov = Provider.of<ProductProvider>(context, listen: true);
    var user = userprov.currentUser;

    var birthdayController = useTextEditingController();
    var phoneController = useTextEditingController();
    var countryController = useTextEditingController();
    var nameController = useTextEditingController();
    var emailController = useTextEditingController();
    var brandController = useTextEditingController();
    var imageController = useTextEditingController();

    var productNameController = useTextEditingController();
    var productDescriptionController = useTextEditingController();
    var productPriceController = useTextEditingController();
    var productImageController = useTextEditingController();
    var productCaloriesController = useTextEditingController();
    var productFatController = useTextEditingController();
    var productSugarController = useTextEditingController();
    var productCaffeineController = useTextEditingController();

    var category = useState("Iced drinks");

    print(user?.type);

    useEffect(() {
      nameController.text = user?.name ?? "";
      phoneController.text = user?.phone ?? "";
      countryController.text = user?.country ?? "";
      birthdayController.text = user?.formattedDate ?? "";
      emailController.text = user?.email ?? "";
      brandController.text = user?.brandName ?? "";
      imageController.text = user?.image ?? "";
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading:
              authprov.isAuthenticated && user?.type == 1 ? false : true,
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
      body: Column(
        children: [
          if (!authprov.isAuthenticated) ...[
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61))),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 209, 98, 42)),
                    elevation: MaterialStateProperty.all(1),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Color.fromARGB(255, 7, 20, 61)),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
          if (authprov.isAuthenticated && user?.type == 0) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(children: [
                Icon(
                  Icons.account_circle,
                  size: 150,
                  color: Color.fromARGB(255, 7, 20, 61),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name:",
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone Number:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61)),
                    ),
                  ),
                ),
                Container(
                  height: 25.0,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: phoneController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email:",
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Country:",
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: countryController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Birthdate:",
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: birthdayController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        authprov.logout();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/');
                      },
                      child: Text("Logout",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 20, 61))),
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
                    ),
                  ),
                )
              ]),
            ),
          ],
          if (authprov.isAuthenticated && user?.type == 1) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      user?.image ?? "",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Brand Name:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 20, 61)),
                      ),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: brandController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email:",
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
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/products',
                              arguments: emailController.text);
                        },
                        child: Text("View my products",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 20, 61))),
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          authprov.logout();
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/');
                        },
                        child: Text("Logout",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 20, 61))),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: authprov.isAuthenticated && user?.type == 1
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                          heightFactor: 0.88,
                          child: Container(
                              padding: EdgeInsets.all(20),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: SingleChildScrollView(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text("Add Product",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontFamily: 'RobotoSlab',
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 17, 17, 17))),
                                      ),
                                      Row(children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          //  Align(
                                          // alignment: Alignment.centerLeft,
                                          //         child:
                                          child: Text(
                                            "Category:",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'RobotoSlab',
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 7, 20, 61)),

                                            //          ),
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: category,
                                            builder: (BuildContext context,
                                                String value, Widget? child) {
                                              return DropdownButton<String>(
                                                value: category.value,
                                                items: const [
                                                  DropdownMenuItem<String>(
                                                    child: Text("Iced drinks"),
                                                    value: "Iced drinks",
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    child: Text("Hot drinks"),
                                                    value: "Hot drinks",
                                                  ),
                                                  // DropdownMenuItem<String>(
                                                  //   child: null,
                                                  //   value: null,
                                                  // ),
                                                ],
                                                onChanged: (String? value) {
                                                  category.value = value!;
                                                },
                                              );
                                            }),
                                      ]),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Text(
                                          "Product Name:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'RobotoSlab',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 20, 61)),
                                        ),
                                      ),
                                      Container(
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 209, 99, 40)),
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.name,
                                          controller: productNameController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter your product name',
                                            contentPadding: EdgeInsets.all(8.0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 35, 0, 0),
                                        child: Text(
                                          "Product Description:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'RobotoSlab',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 20, 61)),
                                        ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 209, 99, 40)),
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          controller:
                                              productDescriptionController,
                                          maxLength: 1000,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter the product description',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 2.0,
                                                    vertical: 2.0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 35, 0, 0),
                                        child: Text(
                                          "Product Price:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'RobotoSlab',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 20, 61)),
                                        ),
                                      ),
                                      Container(
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 209, 99, 40)),
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: productPriceController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter your product price',
                                            contentPadding: EdgeInsets.all(8.0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 35, 0, 0),
                                        child: Text(
                                          "Product Image:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'RobotoSlab',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 7, 20, 61)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 40),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 209, 99, 40)),
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          controller: productImageController,
                                          maxLength: 1000,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Enter the product image url',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 2.0,
                                                    vertical: 2.0),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            var productName =
                                                productNameController.text
                                                    .trim();
                                            var productDescription =
                                                productDescriptionController
                                                    .text
                                                    .trim();
                                            var productPrice = double.tryParse(
                                                productPriceController.text
                                                    .trim());
                                            var productImage =
                                                productImageController.text
                                                    .trim();

                                            if (productName.isNotEmpty &&
                                                productDescription.isNotEmpty &&
                                                productPrice != null &&
                                                productImage.isNotEmpty &&
                                                category.value.isNotEmpty) {
                                              print("I entered");

                                              productprov.createProduct(
                                                authprov.token,
                                                category.value,
                                                user!.email,
                                                productName,
                                                productDescription,
                                                productPrice,
                                                0,
                                                productImage,
                                                <String>[],
                                              );

                                              productNameController.clear();
                                              productDescriptionController
                                                  .clear();
                                              productPriceController.clear();
                                              productImageController.clear();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  'Product added successfully!',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 209, 99, 40),
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                duration: Duration(seconds: 5),
                                              ));

                                              Navigator.of(context).pop();
                                            } else {
                                              print("I did not enter");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  'Please fill all the fields',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 209, 99, 40),
                                                      fontFamily: 'Roboto',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                duration: Duration(seconds: 5),
                                              ));
                                            }
                                          },
                                          child: Text("Add Product",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'RobotoSlab',
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 7, 20, 61))),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 209, 98, 42)),
                                            elevation:
                                                MaterialStateProperty.all(1),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 20, 61)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )))));
                    });
              },
              child: Icon(Icons.add, color: Color.fromARGB(255, 209, 98, 42)),
              backgroundColor: Color.fromARGB(255, 255, 243, 226),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                side: BorderSide(
                    color: Color.fromARGB(255, 209, 98, 42), width: 2),
              ),
            )
          : null,
    );
  }
}
