// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'authProvider.dart';
import 'authProvider.dart';
import 'vendorProvider.dart';
import 'package:coffee_shop/userProvider.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var vendorProvider = Provider.of<VendorProvider>(context, listen: true);
    var token = authProvider.token;

    var vendors;

    void _onItemTapped(int index) {
      if (!authProvider.isAuthenticated) {
        switch (index) {
          case 1:
            Navigator.of(context).pushNamed('/profile');
            break;
        }
      } else {
        switch (index) {
          case 1:
            Navigator.of(context).pushNamed('/cart');
            break;
          case 2:
            Navigator.of(context).pushNamed('/profile');
            break;
        }
      }
    }

    var vendorFetching = useMemoized(() {
      return vendorProvider.fetchAndSetVendors(token);
    }, [token]);

    useEffect(() {
      vendorProvider.clearVendors();
    }, []);

    return FutureBuilder(
      future: vendorFetching,
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
          var vendors = vendorProvider.vendors;
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
            body: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 15, 30, 0),
                    child: Text(
                      "Welcome to Brew and Bake!",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Color.fromRGBO(7, 20, 61, 1),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                    child: Text(
                      "Dive into a world where the perfect cup of coffee\n meets the finest baked delights.\nChoose your category and start your\njourney with us",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                          color: Color.fromARGB(255, 209, 98, 42)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: vendors.length == 0
                      ? Center(
                          child: Text("No Vendors currently selling products!"))
                      : ListView.builder(
                          itemCount: vendors.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/products',
                                    arguments: vendors[index].email);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                // width: 150,
                                // height: 380,
                                child: Center(
                                  child: SizedBox(
                                    width: 190,
                                    height: 220,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 6,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                vendors[index].image ?? "",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ListTile(
                                              title: Text(
                                                vendors[index].brandName ?? "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
      },
    );
  }
}
