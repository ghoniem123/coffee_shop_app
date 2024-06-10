// ignore_for_file: prefer_const_constructors
import 'package:coffee_shop/product.dart';
import 'package:coffee_shop/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    var birthdayController = useTextEditingController();
    var phoneController = useTextEditingController();
    var countryController = useTextEditingController();
    var nameController = useTextEditingController();

    var authMode = useState(0);
    // 0 for login and 1 for signup

    // var isVendor = useState(0);
    //0 for user and 1 for vendor

    void changeAuthMode() {
      authMode.value == 1 ? authMode.value = 0 : authMode.value = 1;
    }

    void loginORsignup() async {
      var authprov = Provider.of<AuthProvider>(context, listen: false);
      var userprov = Provider.of<UserProvider>(context, listen: false);
      var email = emailController.text.trim();
      var password = passwordController.text.trim();
      var birthDate = DateTime.tryParse(birthdayController.text);
      var phone = phoneController.text;
      var country = countryController.text;
      var name = nameController.text;

      if (authMode.value == 1) {
        if (email.isNotEmpty &&
            password.isNotEmpty &&
            phone.isNotEmpty &&
            country.isNotEmpty &&
            name.isNotEmpty &&
            birthDate != null) {
          var successOrError =
              await authprov.signup(email: email, password: password);
          if (successOrError == "success") {
            await userprov.createUser(authprov.token, name, email, password,
                birthDate, phone, country, "", "", 0, <String>[]);

            changeAuthMode();
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/home');
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
      } else {
        var successOrError =
            await authprov.signin(email: email, password: password);
        if (successOrError == "success") {
          await userprov.findUser(authprov.token, email);

          if (userprov.currentUser?.type == 1) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/profile');
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/home');
          }
        } else if (successOrError.contains("EMAIL_NOT_FOUND")) {
          final snackBar = SnackBar(
            content: Text(
              'Email was not found',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 99, 40),
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (successOrError.contains("INVALID_PASSWORD")) {
          final snackBar = SnackBar(
            content: Text(
              'Incorrect password',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 99, 40),
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );

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
        } else if (successOrError.contains("MISSING_PASSWORD")) {
          final snackBar = SnackBar(
            content: Text(
              'Enter your password',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 99, 40),
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (successOrError.contains("INVALID_LOGIN_CREDENTIALS")) {
          final snackBar = SnackBar(
            content: Text(
              'Email or Password is incorrect',
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
                      authMode.value == 0
                          ? "Welcome to Brew & Bake! We're excited to share our passion for great coffee and delicious treats with you.\n Please sign in to order your favorites"
                          : "Welcome to Brew & Bake! We're excited to share our passion for great coffee and delicious treats with you.\n Create an account to join our community of coffee and bakery lovers",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 209, 99, 40)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (authMode.value == 1) ...[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text(
                        "Name:",
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
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your name',
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text(
                        "Birth date:",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'RobotoSlab',
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 20, 61)),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 209, 99, 40)),
                      ),
                      child: TextField(
                        controller: birthdayController,
                        decoration: InputDecoration(
                          labelText: ' Date',
                          border: InputBorder.none,
                        ),
                        readOnly: true,
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950, 1, 1),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.red,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDate != null) {
                            birthdayController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text(
                        "Phone Number:",
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
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your phone number',
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text(
                        "Country:",
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
                        controller: countryController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your country',
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ],
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
                        child: (authMode.value == 0)
                            ? Text('Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 7, 20, 61)))
                            : Text('Sign Up',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 7, 20, 61))),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: (authMode.value == 0)
                          ? TextButton(
                              onPressed: () {
                                changeAuthMode();
                              },
                              child: Text(
                                "Don't  have an account return back to \nSign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 31, 58, 147)), // Add this
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                emailController.clear();
                                passwordController.clear();
                                changeAuthMode();
                              },
                              child: Text(
                                "Already have an account go to \nLogin page",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 31, 58, 147)), // Add this
                              ),
                            ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/vendor');
                      },
                      child: Text(
                        "Sign up as a vendor",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                Color.fromARGB(255, 31, 58, 147)), // Add this
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
