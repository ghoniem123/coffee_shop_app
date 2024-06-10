// ignore_for_file: prefer_const_constructors
import 'package:coffee_shop/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'vendorProvider.dart';
import 'userProvider.dart';

class VendorScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    var brandController = useTextEditingController();
    var imageController = useTextEditingController();

    void loginORsignup() async {
      var authprov = Provider.of<AuthProvider>(context, listen: false);
      var userprov = Provider.of<UserProvider>(context, listen: false);

      var email = emailController.text.trim();
      var password = passwordController.text.trim();
      var brandName = brandController.text.trim();
      var image = imageController.text.trim();

      if (email.isNotEmpty &&
          password.isNotEmpty &&
          brandName.isNotEmpty &&
          image.isNotEmpty) {
        var successOrError =
            await authprov.signup(email: email, password: password);
        if (successOrError == "success") {
          await userprov.createUser(authprov.token, "", email, password,
              DateTime.parse("2022-01-01"), "", "", brandName, image, 1,[]);

          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/profile');
        } else if (successOrError.contains("EMAIL_EXISTS")) {
          final snackBar = SnackBar(
              content: Text(
                'Email already exists',
                style: TextStyle(
                    color: Color.fromARGB(255, 209, 99, 40),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (successOrError.contains("INVALID_EMAIL")) {
          final snackBar = SnackBar(
            content: Text(
              'Incorrect email',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 99, 40),
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (successOrError.contains("WEAK_PASSWORD")) {
          final snackBar = SnackBar(
            content: Text(
              'Password should be at least 6 characters',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 99, 40),
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          content: Text(
            'Fill all the fields',
            style: TextStyle(
                color: Color.fromARGB(255, 209, 99, 40),
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 70,
                width: 70,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 254, 243, 226),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 0, 6, 0),
                    child: Text(
                      "Welcome to Brew & Bake! We're thrilled to have you join us as a vendor. Share your exquisite coffee and delightful treats with our community. Please sign up to start listing your products and manage your vendor account.",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 209, 99, 40)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text(
                      "Brand Name:",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61)),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: brandController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the brand name',
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text(
                      "Brand Image:",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: imageController,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the brand image',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 2.0), // Reduced padding
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text(
                      "Email:",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61)),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text(
                      "Password:",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 20, 61)),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          loginORsignup();
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
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 20, 61))),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/');
                        },
                        child: Text(
                          "Already have an account go to \nLogin page",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  Color.fromARGB(255, 31, 58, 147)), // Add this
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                      child: Text(
                        "continue as guest",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                Color.fromARGB(255, 31, 58, 147)), // Add this
                      ),
                    ),
                  ),
                ]))));
  }
}
