import 'package:coffee_shop/product.dart';
import 'package:intl/intl.dart';

class User {
  String id;
  String? name;
  String? brandName;
  String? image;
  String email;
  String password;
  DateTime? birthDate;
  String? phone;
  String? country;
  int type; //0 for user, 1 for vendor
  List<String> cart;
  User({
    this.id="",
    this.name,
    this.brandName,
    this.image,
    required this.email,
    required this.password,
    this.birthDate,
    this.phone,
    this.country,
    required this.type,
    required this.cart,
  });

  String get formattedDate {
    return DateFormat('dd-MM-yyyy').format(birthDate!);
  }
}
