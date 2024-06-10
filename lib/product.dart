// enum MilkType { whole, skim, almond, soy, oat, coconut, none }
import 'package:uuid/uuid.dart';

// enum Size { small, medium, large }

// class SizePrice {
//   Size size;
//   double price;
//   SizePrice({required this.size, required this.price});

//   Map<String, dynamic> toJson() {
//     return {
//       'size': size,
//       'price': price,
//     };
//   }
// }

class Product {
  String? id;
  String category;
  String vendorEmail;
  String name;
  String description;
  // List<SizePrice> size;
  double price;
  double rating;
  // MilkType milkType;
  String image;
  // String addOns;
  // double calories;
  // double fat;
  // double sugar;
  // double caffeine;
  List<String> comments;

  Product({
    this.id,
    required this.category,
    required this.name,
    required this.vendorEmail,
    required this.description,
    // required this.size,
    required this.price,
    required this.rating,
    // required this.milkType,
    required this.image,
    // required this.addOns,
    // required this.calories,
    // required this.fat,
    // required this.sugar,
    // required this.caffeine,
    required this.comments,
  });
}
