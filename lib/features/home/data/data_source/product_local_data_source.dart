import 'package:hive/hive.dart';
import 'package:sprint1/features/home/data/model/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getProducts();
  Future<void> cacheProducts(List<Product> products);
  Future<void> clearProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<Product> productBox;

  ProductLocalDataSourceImpl(this.productBox);

  @override
  Future<List<Product>> getProducts() async {
    return productBox.values.toList();
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    await productBox.clear();
    await productBox.addAll(products);
  }

  @override
  Future<void> clearProducts() async {
    await productBox.clear();
  }
}