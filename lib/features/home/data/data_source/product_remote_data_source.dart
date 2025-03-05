import 'package:sprint1/core/network/api_service.dart';
import 'package:sprint1/features/home/data/model/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<Product>> getProducts() async {
    return await apiService.fetchProducts();
  }
}