import 'package:sprint1/features/home/data/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}