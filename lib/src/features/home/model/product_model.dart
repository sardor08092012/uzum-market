

import 'package:hive/hive.dart';

part 'product_model.g.dart';
@HiveType(typeId: 0)
class ProductModel {
  @HiveField(1)
  final String company;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final double rating;

  const ProductModel({
    required this.company,
    this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      company: json['company'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      if (description != null) 'description': description,
      'image': image,
      'name': name,
      'price': price,
      'rating': rating,
    };
  }

  ProductModel copyWith({
    String? company,
    String? description,
    String? image,
    String? name,
    double? price,
    double? rating,
  }) {
    return ProductModel(
      company: company ?? this.company,
      description: description ?? this.description,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    return 'Product(company: $company, description: $description, image: $image, name: $name, price: $price, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.company == company &&
        other.description == description &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return company.hashCode ^
        description.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        rating.hashCode;
  }
}
