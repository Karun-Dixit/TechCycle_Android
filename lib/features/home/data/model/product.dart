import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String status;
  final String? image;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.status,
    this.image,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
