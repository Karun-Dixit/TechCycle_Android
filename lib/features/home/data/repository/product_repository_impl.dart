
import 'package:sprint1/core/network/connectivity_service.dart';
import 'package:sprint1/features/home/data/data_source/product_local_data_source.dart';
import 'package:sprint1/features/home/data/data_source/product_remote_data_source.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  ProductRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.connectivityService,
  );

  @override
  Future<List<Product>> getProducts() async {
    final isConnected = await connectivityService.isConnected();
    if (isConnected) {
      try {
        final products = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(products); // Cache for offline use
        return products;
      } catch (e) {
        throw Exception('Failed to fetch products from API: $e');
      }
    } else {
      final cachedProducts = await localDataSource.getProducts();
      if (cachedProducts.isNotEmpty) {
        return cachedProducts;
      }
      throw Exception('No internet connection and no cached data available');
    }
  }
}